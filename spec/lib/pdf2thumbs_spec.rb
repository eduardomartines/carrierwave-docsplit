require "spec_helper"

describe CarrierWave::Pdf2thumbs do
  WIDTH    = rand(200..700)
  HEIGHT   = nil
  FILENAME = "doc_copy.pdf"

  let(:folder_name) do
    "#{WIDTH}x#{HEIGHT}"
  end

  let(:number_of_pages) do
    pdf_info_extractor(:length, file_path(FILENAME))
  end

  let(:first_extracted_image_path) do
    Dir.glob(File.join(file_path(folder_name), "*"))[0]
  end

  before do
    @klass = Class.new do
      include CarrierWave::Pdf2thumbs
      def store_dir; file_path; end
    end
    @instance = @klass.new
    FileUtils.cp(file_path("doc.pdf"), file_path(FILENAME))
    @instance.stub(:current_path).and_return(file_path(FILENAME))
    @instance.pdf2thumbs(WIDTH, HEIGHT)
  end

  after do
    FileUtils.rm(file_path(FILENAME))
    FileUtils.rm_rf(file_path(folder_name))
  end

  describe "Processor" do
    it "creates the folder" do
      File.exist?(file_path(folder_name)).should be_true
    end

    it "extracts all the pages" do
      number_of_images = Dir.glob(File.join(file_path(folder_name), "*")).length
      number_of_images.should be_equal number_of_pages
    end

    it "extracts with the right width" do
      image_width = MiniMagick::Image.open(first_extracted_image_path)[:width]
      image_width.should be_equal WIDTH
    end
  end

  describe "Collector" do
    it "returns the hash of images" do
      @instance.thumbs.should have_key folder_name
    end

    it "returns the hash with all the images" do
      @instance.thumbs[folder_name].length.should be_equal number_of_pages
    end

    it "returns sorted images" do
      @instance.thumbs[folder_name].each_with_index do |image_path, index|
        image_path.should end_with "_#{index + 1}.png"
      end
    end
  end
end
