require "carrierwave"
require "carrierwave/pdf2thumbs/version"
require "carrierwave/pdf2thumbs/processor"

module CarrierWave
  module Pdf2thumbs
    extend ActiveSupport::Concern

    module ClassMethods
      def pdf2thumbs(width, height)
        process pdf2thumbs: [width, height]
      end
    end

    def pdf2thumbs(width, height)
      CarrierWave::Pdf2thumbs::Processor.new(width, height)
    end
  end
end
