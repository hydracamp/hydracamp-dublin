class PagesController < ApplicationController
	def new
		if params[:book_id] # maybe this should be required or else 400?
			@book = Book.find(params[:book_id])
		end

		@page = Page.new

		respond_to do |format|
			format.html
		end
	end


	def create
		@page = Page.new(params[:page])
		@page.save

		if params[:book_id]
			@book = Book.find(params[:book_id])
			@book.add_page(@page)
		end

		respond_to do |format|
			format.html { redirect_to page_path(@page), notice: 'Page was successfully added.' }
		end
	end

	def show
		@page = Page.find(params[:id])

		respond_to do |format|
			format.html
		end
	end

	def edit
		@page = Page.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
		end
	end

	def index
		@pages = Page.all

		respond_to do |format|
			format.html # index.html.erb
		end
	end


	def destroy
		@page = Page.find(params[:id])
		@page.destroy

		respond_to do |format|
			format.html { redirect_to pages_path, notice: 'Page was sucessfully deleted.' }
		end
	end

end
