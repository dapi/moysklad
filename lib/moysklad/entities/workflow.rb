module Moysklad::Entities
  class Workflow < Base
    include CommonObject
    include Moysklad::Entities::XmlFix

    element :code, String
    element :uuid, String

    has_many :states, Moysklad::Entities::WorkflowState, tag: :state
  end
end
