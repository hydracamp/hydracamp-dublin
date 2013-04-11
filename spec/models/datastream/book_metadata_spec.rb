require 'spec_helper'

describe Datastream::BookMetadata do
	before(:each) do
		@book_metadata = Rails.root + 'spec/fixtures/book_metadata.xml'
		@ds = Datastream::BookMetadata.from_xml(File.new(@book_metadata))
	end

	it "should be able to set and save a title and author" do
		@ds.title.should == ["Some Title"]
		@ds.author.should == ["An Author", "Second Author"]
	end

	it "should be possible to remove an author using the author_name=() assignment" do
	   @ds.author.should == ["An Author", "Second Author"]
       @ds.author_name=["An Author"]
       @ds.author.should == ["An Author"]
	end
end