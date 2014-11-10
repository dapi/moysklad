module Moysklad::Entities
  class GoodRef < Base
    include HappyMapper

    tag 'goodRef'

    attribute :uuid,  String
    attribute :name,  String
    attribute :code,  String
    attribute :objectType, String
  end
end
