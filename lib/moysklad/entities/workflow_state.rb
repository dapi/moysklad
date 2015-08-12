module Moysklad::Entities
  class WorkflowState < Base
    include CommonObject
    include Moysklad::Entities::XmlFix

    element :uuid, String
  end
end
