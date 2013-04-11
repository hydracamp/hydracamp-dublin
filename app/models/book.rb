class Book < ActiveFedora::Base
  has_many :pages, :property => :is_part_of
  has_metadata 'descMetadata', type: Datastream::BookMetadata
  has_metadata 'pageList', type: Datastream::StructureMetadata


  delegate :title, to: 'descMetadata', unique: true
  delegate :author, to: 'descMetadata'

  delegate :page_list, to: 'pageList'

  #Override update_attributes to add call to descMetadata.author_name
  def update_attributes(params = {})
    self.descMetadata.author_name=params["author"] unless params["author"].nil?
    super(params)
  end

end