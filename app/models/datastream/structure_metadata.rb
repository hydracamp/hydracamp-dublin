class Datastream::StructureMetadata < ActiveFedora::OmDatastream

  set_terminology do |t|
    t.root(path: "pages") {
    t.page {
      t.pid(path: {attribute: "pid"})
      t.order(path: {attribute: "order"})
    }
  }
  end

  def self.xml_template
    Nokogiri::XML.parse("<pages/>")
  end
end