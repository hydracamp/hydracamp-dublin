class Book < ActiveFedora::Base
    has_many :pages, :property => :is_part_of
    has_metadata 'descMetadata', type: Datastream::BookMetadata
    has_metadata 'pageList', type: Datastream::StructureMetadata


    delegate :title, to: 'descMetadata', unique: true
    delegate :author, to: 'descMetadata'

    delegate :page_list, to: 'pageList'


    def add_page(page)
        page.book = self
        page.save

        if pageList.page_list.length > 0
            index = pageList.page_list.nodeset.xpath("//page").size
            pageList.page_list(index).order = (index + 1).to_s
            pageList.page_list(index).pid = page.pid

        else
            pageList.page_list.order = "1"
            pageList.page_list.pid = page.pid
        end
    end


end