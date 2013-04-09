class Page < ActiveFedora::Base
  has_metadata 'descMetadata', type: Datastream::PageMetadata

  belongs_to :book, :property=> :is_part_of
  has_file_datastream :name => "pageContent", :type=>ActiveFedora::Datastream

  delegate :number, to: 'descMetadata'
  delegate :text, to: 'descMetadata'
end