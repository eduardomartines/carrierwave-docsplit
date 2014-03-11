module CarrierWave
  module Pdf2thumbs
    class ProcessorService
      def initialize(input_path, output_path, width, height)
        @input_path  = input_path
        @output_path = output_path
        @width       = width
        @height      = height
      end

      def process
        create_folder
        extract_images
      end

      private

      def create_folder
        FileUtils.mkdir_p(@output_path)
      end

      def extract_images
        Docsplit.extract_images(@input_path, output: @output_path, size: size)
      end

      def size
        "#{@width}x#{@height}"
      end
    end
  end
end
