module CarrierWave
  module Pdf2thumbs
    class Processor
      def initialize(input_path, width, height)
        @input_path = input_path
        @width      = width
        @height     = height
      end

      def process
        extract_images
      end

      private

      def extract_images
        CarrierWave::Pdf2thumbs::ProcessorService.new(input_path, output_path, width, height).process
      end

      def input_path
        @input_path
      end

      def output_path
        path = Pathname.new(@input_path).dirname
        File.join(path, output_folder_name)
      end

      def output_folder_name
        "#{@width}x#{@height}"
      end

      def width
        @width
      end

      def height
        @height
      end
    end
  end
end
