RakutenWebService.configure do |c|
  if ENV['SECRET_KEY_BASE_DUMMY'].nil?
    c.application_id = Rails.application.credentials.rakuten[:application_id]
  end
end
