require 'spec_helper'

describe Datastream::StructureMetadata do
	before() do
		p = Rails.root + 'spec/fixtures/pages.xml'
		@ds = Datastream::StructureMetadata.from_xml(File.new(p))
	end
	it "should have pages" do
		@ds.pages.should_not be_empty

		puts @ds.pages.nodeset.xpath('//page').size
		@ds.pages.nodeset.xpath('//page').size.should == 7
	end
end
