class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  require 'open-uri'
end
