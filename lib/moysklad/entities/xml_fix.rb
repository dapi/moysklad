module Moysklad::Entities::XmlFix
  extend ::ActiveSupport::Concern

  included do

    def to_utf_xml
      #to_xml(Nokogiri::XML::Builder.new(encoding: 'utf-8')).to_xml
      to_xml
    end

    def to_xml
      super(Nokogiri::XML::Builder.new(encoding: 'utf-8')).to_xml
    end

    def to_s
      to_utf_xml.to_s
    end
  end
end
