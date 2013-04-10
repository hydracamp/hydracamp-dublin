class Book < ActiveFedora::Base
  has_many :pages, :property => :is_part_of
  has_metadata 'descMetadata', type: Datastream::BookMetadata

  delegate :title, to: 'descMetadata', unique: true
  delegate :author, to: 'descMetadata'
end