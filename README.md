#  Ruby-клиент для REST XML API Moysklad

[![Build Status](https://travis-ci.org/BrandyMint/moysklad.svg)](https://travis-ci.org/BrandyMint/moysklad)
[![Dependency Status](https://www.versioneye.com/user/projects/548225818674a4b5b90004dd/badge.svg?style=flat)](https://www.versioneye.com/user/projects/548225818674a4b5b90004dd)
[![Code Climate](https://codeclimate.com/github/BrandyMint/moysklad/badges/gpa.svg)](https://codeclimate.com/github/BrandyMint/moysklad)

* http://www.rubydoc.info/gems/moysklad

## Особенности

* Модуль разработан согласно принципам SOLID. Легко расширяем.
* Все используемые сущности описаны и структурированы. Например [Good](lib/moysklad/entities/good.rb)
* Любые действия с ресурсами (Create, Read, Update, Delete, List).
* Виртуальные действия с ресурсами (`where`, `findWhere`)
* Автоматическая подгрузка списка если все данные не уместились в один запрос (метод `all`)
* _Кеширование и предзагрузка_ ресурса со всеми записями (используем ресурс как локальную базу)
* Работа с нескольмими аккаунтами склада одновременно (отсуствие глобальных переменных).
* Удобная работа с подресурсами (например справочником свойств товара)
* _Ассоциации_ между сущностями автоматически получают данные по API (`good.features`).
* [Client](lib/moysklad/client.rb) для прямого обращения к API в случае крайней необходимости.

## Установка

Все, как обычно, добавляем в Gemfile:

    gem 'moysklad'

## Использование

Создаем благоприятное окружение для работы с API:

```ruby
universe = Moysklad::Universe.build login:'ВАШ ЛОГИН', password:'ВАШ ПАРОЛЬ'
```

### Список элементов.

Например список товаров (`Good`).

```ruby
universe.goods.list
# => [Moysklad::Entities::Good, Moysklad::Entities::Good, ..]
```

Обратите внимание, что список возвращается "как есть" и для работы с ним есть более удобные методы.

Параметры списка.

```ruby
universe.stock.list slotUuid: uuid
```

Страница товаров:

```ruby
page = universe.goods.page
# => Moysklad::Entities::Page

page.total
# => 1280

page.count
# => 1000

page.start
# => 0

# page.items
# =>[Moysklad::Entities::Good, ..]

Есть очень удобная возможность автоматически загрузать ВСЕ товары с учетом пейджирования:

> goods = universe.goods.all
> goods.count
> => 1280

> goods
> => [Moysklad::Entities::Page]
```

### Получить конкретный элемент

```ruby
universe.goods.get $uuid
# => [Moysklad::Entities::Good]
```

### Создаем элемент

Например загрузка заказа покупателя:

```ruby
co = Moysklad::Entities::CustomerOrder.new
co.vatIncluded = true
co.applicable  = true
[...]
co.customerOrderPosition = [Moysklad::Entities::CustomerOrderPosition.new]

created_order = universe.customer_orders.create co
# => [Moysklad::Entities::Good]

created_order.uuid
# => uuid нового заказа
```

### Удаляем элемент

```ruby
universe.goods.delete $uuid
```

### Кеширование и предзагрузка

Одной из главных возможностей данного модуля является возможность работать с API как с базой данных,
не выполняя запрос по получению каждого товара по-отдельности, и выдавать данные их кеша.

Класический способ получить данные по товару делает GET запрос каждый раз:

```ruby
universe.goods.get $uuid
# => Client: GET exchange/rest/ms/xml/Good/f24937e7-7ba1-11e4-90a2-8ecb000abf12 {}
# => [Moysklad::Entities::Good]
```

Продвинутый способ вытаскивает все данные сразу и в дальнейшем берет обьекты из кеша:

```ruby
> universe.goods.find $uuid
# => Client: GET exchange/rest/ms/xml/Good/list {:start=>0}
# => Client: GET exchange/rest/ms/xml/Good/list {:start=>1000}
# => [Moysklad::Entities::Good]
```

И в следующий раз API уже не дергается:

```ruby
universe.goods.find $another_uuid
# => [Moysklad::Entities::Good]
```

Это позволяет экономить на прямых запросах к API и избавляет нас от блокирования моимскладом по ограничению количества запросов за еденицу времени.


## Поиск по фильтру

Возвращает список элементов отображенных по фильтру:

```ruby
universe.features.where goodUuid: uuid
# => [Moysklad::Enities::Feature, Moysklad::Enities::Feature]
```

Тоже самое, только возвращается первый элемент или nil:

```ruby
universe.features.findWhere goodUuid: uuid
# => [Moysklad::Enities::Feature]
```

### Список доступных ресурсов:

```ruby
universe.resources_list
# => [:stock, :embedded_entity_metadata, :custom_entity_metadata, :goods, :good_folders, :uoms, :countries,
      :features, :custom_entities, :customer_orders, :warehouses, :companies,
      :consignments, :my_companies]
```

## Справочники и подресурсы

Доступ к Мойсклад устроен так, что некоторые справочники запрятаны в одной коллекции.
Например если вы хотите получить все виды свойств товаров, то это можно сделать следующим образом.

```ruby
universe.embedded_entity_metadata.subresource_by_name(:GoodFolder).all
# => [Moysklad::Entities::AttributeMetadata, Moysklad::Entities::AttributeMetadata]
```

Или получить конкретное свойство:

```ruby
universe.embedded_entity_metadata.subresource_by_name(:GoodFolder).find uuid
# => Moysklad::Entities::AttributeMetadata
```

## Автоматическая обработка ассоциаций (отношения)

Нравятся `belongs_to` и `has_many` в рельсах? Тут есть почти тоже самое.

```ruby
feature = universe.features.find uuid
feature.good
# Client: GET exchange/rest/ms/xml/Good/f24937e7-7ba1-11e4-90a2-8ecb000abf12 {}
# => [Moysklad::Entities::Good]
```

Пример как получить все данные по товару, включая модификации, свойства и их характеристики:

```ruby
good = universe.goods.find uuid
# Client: GET exchange/rest/ms/xml/Good/f24937e7-7ba1-11e4-90a2-8ecb000abf12 {}

good.features universe
# Client: GET exchange/rest/ms/xml/Feature/list {}
# => [Moysklad::Entities::Feature, ..]

attribute = good.attributes.first
# => [Moysklad::Entities::Attribute, ..]

attribute.is_dictionary?
# => true
```

Получаем вид свойства:

```ruby
attribute.embedded_entity_metadata universe
# Client: GET exchange/rest/ms/xml/Metadata/list {}
# => [Moysklad::Entities::AttributeMetadata]
```

Получаем описание пользовательского справочника к которому принадлежит свойства

```ruby
dictionary = attribute.embedded_entity_metadata(universe).dictionatyMetadata(universe)
# Client: GET exchange/rest/ms/xml/CustomEntityMetadata/uuid {}
# => [Moysklad::Entities::CustomEntityMetadata]
```

Значения всех элементов пользовательского справочника:

```ruby
dictionary.entities(universe)
# => [Moysklad::Entities::CustomEntity, ...]
```

Подробнее смотри в исходниках сущностей.

## Pull Requests

### Добавление новых моделей и ресурсов.

На данный момен в библиотеку добавлено 60% справочников используемых в моемскладе. Я добавляю новые справочники по мере необходимости. Но вы можете это сделать и сами следующим образом.

Например добавляем `Country`.

1. Добавляем в фикстуры пример выгрузки из API для тестирования и отладки:

    MS_LOGON=логин MS_PASSWORD=пароль ./scripts/rest.sh Country list > ./spec/fixtures/Country_list.raw

2. Создаем сущность на основе уже существующей, например good.rb

    cp ./lib/moysklad/entities/good.rb ./lib/moysklad/entities/country.rb

3. Описываем свойства новой сущности Country.rb в терминах [nokogiri-happymapper](https://github.com/dam5s/happymapper)-а

    vi ./lib/moysklad/entities/country.rb

4. Добавляем сущность в requirements

    vi ./lib/moysklad/entities.rb

5. Содаем автоматический ресурс (имя ресурса во множественном числе)

    vi ./lib/moysklad/resources.rb

6. Делаем spec для сущности и для ресурса.

    > vi ./spec/lib/moysklad/resources/countries_spec.rb
    > vi ./spec/lib/moysklad/entities/country_spec.rb

7. Проверяем что тесты проходят.

8. Присылаем Pull Request

## Тестирование

    > bundle exec guard

## Полезняшки

Скрипт для быстрого доступа к сервисам моего склада

    > MS_LOGON=логин MS_PASSWORD=пароль ./script/rest.sh Country list > ./spec/fixtures/Country_list.raw

## Ссылочки

* Картапамяти по API http://www.mindmeister.com/246618635/online-moysklad-ru
* Документация для разработчииков https://support.moysklad.ru/hc/ru/sections/200561443-Разработчикам
* Неплохая схема API в json https://gist.github.com/dapi/22a0790db19a4ff51a37
* Хороший клиент на JavaScript/nodejs https://github.com/wmakeev/moysklad-client

## Присылайте пул-реквесты )

## Авторство

* Данил Письменный (brandymint.ru)
