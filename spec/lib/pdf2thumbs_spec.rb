require "spec_helper"

describe CarrierWave::Pdf2thumbs do
  before do
    @klass = Class.new do
      include CarrierWave::Pdf2thumbs
    end
    @instance = @klass.new
    FileUtils.cp(file_path('doc.pdf'), file_path('doc_copy.pdf'))
    @instance.stub(:current_path).and_return(file_path('doc_copy.pdf'))
    @instance.stub(:cached?).and_return true
    @instance.pdf2thumbs(200, nil)
  end

  after do
    FileUtils.rm(file_path('doc_copy.pdf'))
  end

  describe "#extract_images" do
    it "extracts images with the correct size"

    it "extracts all the pages"

    context "local storage" do
      it "creates the right folder"

      it "extracts to the right path"
    end

    context "remote storage" do
    end
  end
end
