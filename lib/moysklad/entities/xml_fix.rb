module Moysklad::Entities::XmlFix
  extend ::ActiveSupport::Concern

  included do

    def to_xml
      super(Nokogiri::XML::Builder.new(encoding: 'utf-8')).to_xml 
    end
  end
end

