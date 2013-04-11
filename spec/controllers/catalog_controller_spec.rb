require 'spec_helper'

describe CatalogController, :type => :request do
    include Devise::TestHelpers

    render_views

    before(:all) do
        @book = Book.new
        @book.title = "My title"
        @book.author = "My author"
        @book.save
    end

    it "should display the modification time label on the document view" do
        get :show, :id => @book.pid
 
        response.body.should include("Modification time")
    end

    it "should display the modification time in a correct datetime format" do
        get :show, :id => @book.pid

        expected_datetime =  DateTime.iso8601(@book.modified_date).strftime( "%Y-%m-%d %H:%M:%S" )
        response.body.should include( expected_datetime )
    end

end
