# Concern
module AttributesConverter
  def initialize(data = {})
    if data['attributes']
      if data['attributes'].is_a? Array
        data['attrs'] = data.delete 'attributes'
      elsif data['attributes'].is_a? Hash
        # do nothing
      else
        raise "Strange attribute class #{data['attribute']}"
      end
    end
    super data
  end
end
