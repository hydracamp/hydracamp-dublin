require 'spec_helper'

describe BooksController do
    describe "creating" do
        it "should render the create page" do
            get :new
            assigns[:book].should be_kind_of Book
            response.should render_template("new")
        end
        it "should support create requests" do
            post :create, :book=>{"title"=>"My title", "author"=>"The Author"}
            book = assigns[:book]
            book.title.should == "My title"
            book.author.first.should == "The Author"
        end
    end

    describe "editing" do
        before(:all) do
            @book = Book.new
            @book.title = "My title"
            @book.author << "The author"
            @book.save
            @object_pid = @book.pid
        end

        it "should support edit requests" do
            get :edit, :id=>@object_pid
            assigns[:book].should be_kind_of Book
            assigns[:book].pid.should == @object_pid
        end

        it "should support updating objects" do
            put :update, :id=>@object_pid, :book=>{"title"=>"New title", "author"=>"New Author"}
            book = assigns[:book]
            book.title.should == "New title"
            book.author.first.should == "New Author"
        end

    end

end
