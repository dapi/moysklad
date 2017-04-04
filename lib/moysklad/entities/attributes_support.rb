module AttributesSupport
  def initialize(data)
    data['attrs'] = data.delete 'attributes' if data['attributes']
    super data
  end
end
