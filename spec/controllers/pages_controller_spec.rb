# pages_controller_spec.rb
require 'spec_helper'

describe PagesController do
	describe "new" do
		describe "when book_id is provided" do
			it "should load the book" do
				b = Book.create(title: 'Anna Karenina', author: 'Tolstoy, Leo')
				get :new, book_id: b.pid
				response.should be_successful
				assigns[:book].should == b
			end
		end
		describe "when book_id is NOT provided" do
			it "should still work" do
				get :new
				response.should be_successful
				assigns[:book].should be_nil
			end
		end
		# describe "when provided book_id does not exist" do
		# end

	end

	describe "create" do 
		it 
	end

	# page = subject.new(book: b, number: 1, text: "Happy families are all alike;")
end