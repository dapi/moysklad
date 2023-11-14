# Concern
module AttributesConverter
  def initialize(data = {})
    if data['attributes']
      if data['attributes'].is_a? Array
        data['attrs'] = data.delete 'attributes'
        binding.pry
      elsif data['attributes'].is_a? Hash
        puts data['attributes']
      else
        binding.pry
      end
    end
    super data
  end
end
