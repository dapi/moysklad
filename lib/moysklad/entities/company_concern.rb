module Moysklad::Entities::CompanyConcern
  extend ActiveSupport::Concern
  included do
    include HappyMapper
    include Moysklad::Entities::CommonObject

    attribute :created,     Time
    attribute :archived,    HappyMapper::Boolean

    attribute :companyType, String

    attribute :discount,     Float
    attribute :autoDiscount, Float
    attribute :discountCardNumber, String
    attribute :discountCorrection, Float

    element   :code,         String

  end
end
