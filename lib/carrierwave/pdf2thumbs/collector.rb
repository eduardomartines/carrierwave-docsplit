module CarrierWave
  module Pdf2thumbs
    class Collector
      def initialize(output_path)
        @output_path = output_path
      end

      def thumbs
        fetch_thumbs
      end

      private

      def fetch_thumbs
        path  = File.join(@output_path, "*")
        files = Dir.glob(path).sort
        files
      end
    end
  end
end
