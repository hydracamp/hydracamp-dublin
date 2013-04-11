class PagesController < ApplicationController
	def new
		if params[:book_id]
			@book = Book.find(params[:book_id])
		end
		@page = Page.new
		respond_to do |format|
			format.html
		end
	end


	def create
		
	end
end
