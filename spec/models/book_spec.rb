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

    describe ".add_page" do
        subject { Book.create( title: "Test", author: "Me" ) }


        before do
            @p = Page.create(text: "Hello World", number: "1")
            subject.add_page(@p)
        end
        it "should add a reference from book to page" do
            local = Book.find(subject.pid)
            local.pages.include?(@p).should == true
        end

        it "should add a reference from page to book" do
            local = Page.find(@p.pid)
            local.book.should == subject
        end

        it "should add a page element if no pages exist" do
            # TODO add assertions
        end

        it "should append a page element if previous page exists" do
            # TODO add assertions
            @another_p = Page.create(text: "Goodbye World", number: "2")
            subject.add_page(@another_p)
        end


        #it "should update page element if page already exists"

        # it "should update StructureMetadata if it does exist"

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