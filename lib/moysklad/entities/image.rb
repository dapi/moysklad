module Moysklad::Entities
  class Image < Base
    attribute :meta,  Meta
    attribute :title, String
    attribute :filename, String
    attribute :size, Integer
    attribute :updated, Time
    attribute :miniature, Meta
    attribute :tiny, Meta

    def download(client, dir)
      client.download meta.href, dir + filename
    end
  end
end
