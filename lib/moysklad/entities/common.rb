module Moysklad::Entities::Common
  extend ::ActiveSupport::Concern

  included do
    include HappyMapper
    include Moysklad::Entities::XmlFix

    attribute :readMode,    String
    attribute :changeMode,  String

    element :accountUuid,   String
    element :accountId,     String
    element :uuid,          String
  end

end
