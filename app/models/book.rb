class Book < ActiveFedora::Base
  has_many :pages, :property => :is_part_of
  has_metadata 'descMetadata', type: Datastream::BookMetadata
  has_metadata 'pageList', type: Datastream::StructureMetadata


  delegate :title, to: 'descMetadata', unique: true
  delegate :author, to: 'descMetadata'

  delegate :page_list, to: 'pageList'
end