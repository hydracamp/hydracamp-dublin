class Book < ActiveFedora::Base
  has_many :pages, :property => :is_part_of
  has_metadata 'descMetadata', type: Datastream::BookMetadata

  delegate :title, to: 'descMetadata', unique: true
  delegate :author, to: 'descMetadata'
  
  def to_solr(solr_doc={})
    super
    solr_doc["text_tesim"] = []
    self.pages.each do |page|
      solr_doc["text_tesim"] << page.text[0]
    end
    return solr_doc
  end
end