module Moysklad::Entities
  class Base
    #include Object

    private

    def cache ns, key
      @cache||={}
      @cache[ns]||={}
      cc = @cache[ns]

      cc[key] = yield unless cc.has_key? key
      cc[key]
    end
  end
end
