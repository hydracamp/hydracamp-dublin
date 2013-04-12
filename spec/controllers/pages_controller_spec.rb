	# pages_controller_spec.rb
require 'spec_helper'

describe PagesController do
	before do
		@b = Book.create(title: 'Anna Karenina', author: 'Tolstoy, Leo')
	end
	describe ".new" do
		describe "When book_id is provided" do
			it "should load the book" do
				get :new, book_id: @b.pid
				response.should be_successful
				assigns[:book].should == @b
			end
			# describe "when book does not exist" do
			# end
		end

		# is this what we want, or should a book have to exist?
		describe "When book_id is NOT provided" do
			it "should still work" do
				get :new
				response.should be_successful
				assigns[:book].should be_nil
			end
		end

	end

	describe ".create" do
		describe "When book_id is provided" do
			it "should create a page and associated it with the book" do
				old_count = Page.count
				post :create, book_id: @b.pid, page: {number: "1", text: "Happy families are all alike;"}
				response.should redirect_to page_path(assigns[:page].pid)
				assigns[:page].should be_kind_of Page
				assigns[:page].book.should == @b
				Page.count.should == old_count+1
			end
			# describe "when book does not exist" do
			# end
		end

		# is this what we want, or should a book have to exist?
		describe "When book_id is NOT provided" do
			it "should still work" do
			end
		end






		# describe "When a new page is created" do
		# 	before do
		# 		p = subject.new(book: @b, number: 1, text: "Happy families are all alike;")
		# 	end
		# 	it "it should be a member of the book's pages" do
		# 		local = Book.find(@b.pid)
		# 		local.pages.include?(p).should be_true
		# 	end
		# end
	end

end