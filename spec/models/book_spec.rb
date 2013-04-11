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

    subject.should respond_to(:page_list)

    subject.title.should == "My Title"
  end

  it "should have a pageList stream" do
    subject.datastreams["pageList"].should be_kind_of(Datastream::StructureMetadata)
  end

  describe "update_attributes" do
    it "should update the Book with appropiate fields" do
       params = {"title"=>"Test", "author"=>["Test", "Test 2"]}

       subject.update_attributes(params)
       
       subject.title.should == "Test"
       subject.author.should == ["Test", "Test 2"]
    end
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
      @solr_doc["title_si"].should == "My Title"
    end
  end

end