require "spec_helper"

describe Book do
  # before do
  #   @book = Book.new
  # end
  it "should have Book descMetadata" do
    subject.datastreams["descMetadata"].should be_kind_of(Datastream::BookMetadata)
  end
  it "should delegate methods" do
    subject.should respond_to(:title)
    subject.should respond_to(:author)
  end
  describe "to_solr" do
    before do
      subject.title = "My Title"
      subject.author = "Author Name"
      @solr_doc = subject.to_solr
    end
    it "should set solr fields for our metadata" do
      @solr_doc["title_tesim"].should == ["My Title"]
      @solr_doc["author_tesim"].should == ["Author Name"]
    end
    # it "should set title sort field" do
    #   pending
    # end
  end
end