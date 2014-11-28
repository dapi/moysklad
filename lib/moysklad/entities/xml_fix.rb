module Moysklad::Entities::XmlFix
  extend ::ActiveSupport::Concern

  def to_xml *args
    nokogiri = Nokogiri::XML::Builder.new(encoding: 'utf-8')
    super(nokogiri).to_xml
  end

  def to_s
    to_xml.to_s
  end
end
