require "carrierwave"
require "docsplit"
require "mini_magick"
require "carrierwave/pdf2thumbs"

def file_path(*paths)
  File.expand_path(File.join(File.dirname(__FILE__), "fixtures", *paths))
end

RSpec.configure do |config|
  config.mock_with :rspec
end

