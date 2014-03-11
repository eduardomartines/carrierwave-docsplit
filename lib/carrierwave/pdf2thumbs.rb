require "carrierwave"
require "carrierwave/pdf2thumbs/version"
require "carrierwave/pdf2thumbs/processor"
require "carrierwave/pdf2thumbs/processor_service"

module CarrierWave
  module Pdf2thumbs
    extend ActiveSupport::Concern

    module ClassMethods
      def pdf2thumbs(width, height)
        process pdf2thumbs: [width, height]
      end
    end

    def pdf2thumbs(width, height)
      CarrierWave::Pdf2thumbs::Processor.new(input_path, output_path, width, height).process
    end

    private

    def current_path
      current_path
    end

    alias_method :input_path, :current_path

    def output_path
      path = Pathname.new(input_path).dirname
      File.join(path, output_folder_name)
    end

    def output_folder_name
      "#{@width}x#{@height}"
    end
  end
end
