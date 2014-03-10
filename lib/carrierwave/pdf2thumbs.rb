require "carrierwave/pdf2thumbs/version"
require "carrierwave/pdf2thumbs/extract"

module Carrierwave
  module Pdf2thumbs
    module ClassMethods
      def pdf2thumbs(width, height)
        proccess extract: [width, height]
      end
    end

    def extract(width, height)
      CarrierWave::Pdf2thumbs::Extract.new(width, height)
    end
  end
end
