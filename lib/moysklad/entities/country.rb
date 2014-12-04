module Moysklad::Entities
  class Country < Base
    include CommonObject
    include Moysklad::Entities::XmlFix

    tag 'country'

    element   :code,              String
  end
end
