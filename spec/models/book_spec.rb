require "spec_helper"

describe Book do
  # before do
  #   @book = Book.new
  # end
  it "should have Book descMetadata" do
    subject.datastreams["descMetadata"].should be_kind_of(Datastream::BookMetadata)
  end
  it "should delegate methods" do
    subject.title = "My Title"
    subject.should respond_to(:title)
    subject.should respond_to(:author)
    subject.title.should == "My Title"
  end
  
  describe "#to_solr" do
    before do
      @book = Book.create(title: "My Title", author: "Author Name")  

      # Create two Pages with different text, and link to the Book
      Page.create(number: 1, text: "Lorem ipsum", book: @book)
      Page.create(number: 2, text: "dolor", book: @book)
      
      # Need to reload the Book or test fails since @book.pages returns empty
      @book = Book.find(@book.pid)
      
      @solr_doc = @book.to_solr    
    end
    
    it "should set solr fields for our metadata" do
      @solr_doc["title_tesim"].should == ["My Title"]
      @solr_doc["author_tesim"].should == ["Author Name"]
      @solr_doc["title_si"].should == "My Title"
    end

    it "should have text for all associated pages" do
      @solr_doc["text_tesim"].should include("Lorem ipsum")
      @solr_doc["text_tesim"].should include("dolor")
    end      
  end
end