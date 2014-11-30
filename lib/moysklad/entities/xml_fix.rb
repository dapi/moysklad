module Moysklad::Entities::XmlFix
  extend ::ActiveSupport::Concern

  def to_xml builder = nil,default_namespace = nil,tag_from_parent = nil
    unless builder
      builder = Nokogiri::XML::Builder.new(encoding: 'utf-8')
      write_out_to_xml = true
    end

    result = super builder, default_namespace, tag_from_parent

    write_out_to_xml ? result.to_xml : result
  end

end
