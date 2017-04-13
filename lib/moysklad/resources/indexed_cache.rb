module IndexedCache
  def cache!
    all.count
  end

  private

  def cache_fetch
    return cache[:list] if cache[:list]
    cache[:list] = yield
    cache[:index] = prepare_index cache[:list]

    cache[:list]
  end

  def cache
    @cache ||= {}
    @cache[cache_key] ||= { index: nil, list: nil}
  end

  def cached_index
    cache[:index]
  end

  def cache_index(index)
    cache[:index] = index
  end

  def cache_key
    if __getobj__.respond_to? :cache_key
      __getobj__.send :cache_key
    else
      :default
    end
  end
end
