module Moysklad::Entities
  class Error < Base
    include HappyMapper

    tag 'error'

    element :uid,     String
    element :moment,  Time
    element :message, String

    element :stack,   String
  end
end
