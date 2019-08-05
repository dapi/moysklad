module Moysklad::Entities
  # Пример:
  # https://online.moysklad.ru/api/remap/1.1/doc/index.html#документ-заказ-покупателя
  #
  class CustomerOrder < Entity

    # АТРИБУТЫ СУЩНОСТИ ¶
    #
    # meta - Метаданные о Заказе покупателя
    # id - ID в формате UUID Только для чтения
    # accountId - ID учетной записи Только для чтения
    attribute :accountId,          String

    # syncId - ID синхронизации Только для чтения
    attribute :syncId,          String

    # version - Версия сущности Только для чтения
    # updated - Момент последнего обновления сущности Только для чтения
    # deleted - Момент последнего удаления сущности Только для чтения
    # name - номер Заказа покупателя
    # description - Комментарий Заказа покупателя
    attribute :description, String

    # externalCode - Внешний код Заказа покупателя
    # moment - Дата Заказа
    attribute :moment, Time

    # applicable - Отметка о проведении
    attribute :applicable, Boolean

    # vatIncluded - Включен ли НДС в цену
    attribute :vatIncluded, Boolean

    # vatEnabled - Учитывается ли НДС
    attribute :vatEnabled, Boolean

    # sum - Сумма Заказа в установленной валюте Только для чтения
    attribute :sum, Integer

    # rate - Валюта
    attribute :rate, Rate

    # owner - Владелец (Сотрудник)
    attribute :owner, Owner
    # shared - Общий доступ

    attribute :shared, Boolean

    # group - Отдел сотрудника
    attribute :group, Group

    # organization - Ссылка на ваше юрлицо в формате Метаданных Необходимое
    attribute :organization, Entity

    # agent - Ссылка на контрагента в формате Метаданных Необходимое
    attribute :agent, Entity

    # store - Ссылка на склад в формате Метаданных
    attribute :store, Entity

    # contract - Ссылка на договор в формате Метаданных
    attribute :contract, Entity

    # state - Статус Заказа в формате Метаданных

    attribute :state, Entity

    # organizationAccount - Ссылка на счёт вашего юрлица в формате Метаданных
    attribute :organizationAccount, Entity

    # agentAccount - Ссылка на счёт контрагента в формате Метаданных
    attribute :agentAccount, Entity

    # attributes - Коллекция доп. полей.
    # attribute :attributes, Hash

    # documents - Список печатных форм в формате Метаданных
    attribute :documents, Entity


    # Поля при expand’е:
    #
    # name - номер документа
    # moment - дата печати
    # href - ссылка на файл печатной формы
    # fileName - название файла печатной формы
    # updated - дата последнего изменения
    # created - Дата создания Только для чтения
    #

    # vatSum - Сумма НДС Только для чтения
    attribute :vatSum, Integer

    # positions - Ссылка на позиции в Заказе в формате Метаданных
    attribute :positions, Object # Array[CustomerOrderPosition] или CollectionMeta

    # reservedSum - Сумма товаров в резерве Только для чтения
    attribute :reservedSum, Integer

    # deliveryPlannedMoment - Планируемая дата отгрузки
    attribute :deliveryPlannedMoment, Time

    # payedSum - Сумма входящих платежей по Заказу Только для чтения
    attribute :payedSum, Integer

    # shippedSum - Сумма отгруженного Только для чтения
    attribute :shippedSum, Integer

    # invoicedSum - Сумма счетов покупателю Только для чтения
    attribute :invoicedSum, Integer

    # project - Ссылка на проект в фоÑмате Метаданных
    #
    # СВЯЗИ С ДРУГИМИ ДОКУМЕНТАМИ
    #
    # purchaseOrders - Массив ссылок на связанные заказы поставщикам
    # demands - Массив ссылок на связанные отгрузки
    # payments - Массив ссылок на связанные платежи
    # invoicesOut - Массив ссылок на связанные счета покупателям
    #def state universe
      #cache :customer_order_states, universe do
        #fail "No stateUuid in CustomerOrder #{uuid}" unless stateUuid
        #workflow = universe.workflows.findWhere name: 'CustomerOrder'
        #workflow.states.find { |s| s.uuid == stateUuid }
      #end
    #end
  end
end
