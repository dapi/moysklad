#  Ruby-клиент к REST XML API у moysklad.ru

[![Build Status](https://travis-ci.org/BrandyMint/moysklad.svg)](https://travis-ci.org/BrandyMint/moysklad)

## Особенности

* Модуль разработан согласно принципам SOLID. Легко расширяем.
* Спецификации для всех используемых сущностей. Например [Good](lib/moysklad/entities/good.rb)
* Удобный доступ ко всем действиям с ресурсами (Create, Read, Update, Delete, List).
* _Кеширование и предзагрузка_ ресурса со всеми записями (используем ресурс как локальную базу)
* Понятные исключения при ошибках с сетью.
* Работа с нескольмими аккаунтами склада одновременно (отсуствие глобальных переменных).

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

```
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


### Список доступных ресурсов:

```ruby
universe.resources_list
# => [:stock, :metadata, :custom_entity_metadata, :goods, :good_folders, :uoms, :countries,
      :features, :custom_entities, :customer_orders, :warehouses, :companies,
      :consignments, :my_companies]
```

## Pull Requests

### Добавление новых моделей и ресурсов.

На данный момен в библиотеку добавлено 60% справочников используемых в моемскладе. Я добавляю новые справочники по мере необходимости. Но вы можете это сделать и сами следующим образом.

Например добавляем `Country`.

1. Добавляем в фикстуры пример выгрузки из API для тестирования и отладки:

    MS_LOGON=логин MS_PASSWORD=пароль ./script/rest.sh Country list > ./spec/fixtures/Country_list.raw

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

## Присылайте пул-реквесты )
