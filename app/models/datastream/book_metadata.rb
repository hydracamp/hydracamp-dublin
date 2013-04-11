class Datastream::BookMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "fields")
    t.title(index_as: [:stored_searchable, :sortable])
    t.author(index_as: :stored_searchable)
  end

  def self.xml_template
    Nokogiri::XML.parse("<fields/>")
  end

  def author_name=(values)
    ng_xml.search(self.author.xpath).each do |n|
      n.remove
    end
    self.author = values
  end
  
  def to_solr(solr_doc={})
    super
    solr_doc["title_si"] = title.first
    return solr_doc
  end
end