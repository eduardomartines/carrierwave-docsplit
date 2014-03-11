require "spec_helper"

describe CarrierWave::Pdf2thumbs do
  WIDTH    = 200
  HEIGHT   = nil
  FILENAME = "doc_copy.pdf"

  let(:folder_name) { "#{WIDTH}x#{HEIGHT}" }

  before do
    @klass = Class.new do
      include CarrierWave::Pdf2thumbs
      def store_dir; file_path; end
    end
    @instance = @klass.new
    FileUtils.cp(file_path("doc.pdf"), file_path(FILENAME))
    @instance.pdf2thumbs(WIDTH, HEIGHT)
  end

  after do
    FileUtils.rm(file_path(FILENAME))
    FileUtils.rm(file_path(folder_name))
  end

  describe "#extract_images" do
    it "creates the folder" do
      File.exist?(file_path(folder_name)).should be_true
    end

    it "extracts all the pages" do
      count = Docsplit::InfoExtractor.new.extract(:length, file_path(FILENAME), {})
      images = Dir.glob(File.join(file_path(folder_name), "*"))
      images.length.should == count
    end

    it "extracts with the right width" do
      image = Dir.glob(File.join(file_path(folder_name), "*"))[0]
      width = MiniMagick::Image.open(image)[:width]
      width.should == WIDTH
    end

    context "remote storage" do
      it "extracts to the right path"
    end
  end
end
