module CarrierWave
  module Pdf2thumbs
    class Processor
      def initialize(width, height)
        @width  = width
        @height = height
      end

      def process
        extract_images
      end

      private

      def extract_images
        ::ProcessorService.new(input_path, output_path, @width, @height)
      end

      def input_path
        # code
      end

      def output_path
        # code
      end
    end
  end
end
