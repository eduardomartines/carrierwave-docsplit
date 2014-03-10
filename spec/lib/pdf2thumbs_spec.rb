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
  end

  after do
    FileUtils.rm(file_path('doc_copy.pdf'))
  end

  describe "#extract_images" do
    context "local storage" do
      it "extracts the images" do
        @instance.pdf2thumbs(200, nil)
      end
    end

    context "remote storage" do
    end
  end
end
