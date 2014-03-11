module CarrierWave
  module Pdf2thumbs
    class Processor
      def initialize(input_path, output_path, width, height)
        @input_path  = input_path
        @output_path = output_path
        @width       = width
        @height      = height
      end

      def process
        extract_images
      end

      private

      def extract_images
        CarrierWave::Pdf2thumbs::ProcessorService.new(@input_path, @output_path, @width, @height).process
      end
    end
  end
end
