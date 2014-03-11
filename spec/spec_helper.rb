require "carrierwave"
require "docsplit"
require "mini_magick"
require "carrierwave/pdf2thumbs"

def file_path(*paths)
  File.expand_path(File.join(File.dirname(__FILE__), "fixtures", *paths))
end

def pdf_info_extractor(info_key, file_path, options = {})
  Docsplit::InfoExtractor.new.extract(info_key, file_path, options)
end

RSpec.configure do |config|
  config.mock_with :rspec
end

