module Moysklad::Entities
  class Images < Base
    include HappyMapper
    include Moysklad::Entities::XmlFix

    tag 'images'

    has_many :image, Moysklad::Entities::Image
  end
end
