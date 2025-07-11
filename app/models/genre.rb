class Genre < ApplicationRecord
  has_many :books, dependent: :restrict_with_exception

  validates :name, presence: true
  validates :store_genre_id, presence: true, uniqueness: { scope: :name }

  class << self
    def search_and_create_by!(genre_ids)
      genre_id = genre_ids.split('/').first
      application_id = Rails.application.credentials.rakuten[:application_id]

      uri = URI.parse("https://app.rakuten.co.jp/services/api/BooksGenre/Search/20121128?format=json&booksGenreId=#{genre_id}&applicationId=#{application_id}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      request['Content-Type'] = 'application/json'

      response = http.request(request)
      json = JSON.parse(response.body)

      genre_name = json.dig('current', 'booksGenreName') || '未分類'

      find_or_create_by!(store_genre_id: genre_id) do |g|
        g.name = genre_name
      end
    end
  end
end
