module Moysklad::Resources
  class MetadataIndexed < Indexed
    def subresource_by_name name, uuid=nil
      model = all_subresources_by_name[name.to_s]
      if uuid

        model.attributeMetadata.select { |a| a.uuid==uuid }.first
      else
        model
      end
    end

    private

    def all_subresources_by_name
      @all_subresources||=begin
                            cache={}
                            all.map { |r| cache[r.name] = r }
                            cache
                          end
    end
  end
end
