# API сервиса МойСклад позволяет оперировать с такими документами как Отгрузка, Заказ покупателя, Счёт покупателю, Розничная продажа. 
# Перечисленные документы содержат позиции, работать с которыми можно как в составе отдельного документа, так и с помощью специальных ресурсов для управления позициями документа.

module Moysklad::Resources::Positions
  # Создаем позицию документа по uuid
  #
  # @return [Moysklad::Entities::Base]
  def create_position model_uuid, position
    position.class.build client.post(create_position_path(model_uuid), position.to_json)
  end

  def create_position_path(model_uuid)
    [prefix_path, model_uuid, 'positions'].join('/')
  end
end
