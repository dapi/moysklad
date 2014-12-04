# Правильный Ruby-клиент для API moysklad.ru

[![Build Status](https://travis-ci.org/BrandyMint/moysklad.svg)](https://travis-ci.org/BrandyMint/moysklad)

Отличительные черты:

* Модуль разработан согласно принципам SOLID. Легко расширяем.

## Возможности

* Легкое внесение изменений (добавление новых моделей и ресурсов)
* Удобный доступ ко всем действиям с ресурсами.
* Кеширование ресурса со всеми записями (используем ресурс как локальную базу)
* Понятные исключения при ошибках с сетью.

## Установка

Все, как обычно, добавляем в Gemfile:

    gem 'moysklad'


## Использование

Создаем благоприятное окружение для работы с API:

> client = Moysklad::Client.new login:'ВАШ ЛОГИН', password:'ВАШ ПАРОЛЬ'
> universe = Moysklad::Universe.new client: client

### Список элементов.

Например список товаров.

> universe.goods.list
> => [Moysklad::Entities::Good, Moysklad::Entities::Good, ..]

Обратите внимание, что список возвращается "как есть" и для работы с ним есть более удобные методы.

Страница товаров:

> page = universe.goods.page
> => Moysklad::Entities::Page

> page.total
> => 1280

> page.count
> => 1000

> page.start
> => 0

> page.items
> =>[Moysklad::Entities::Good, ..]

Есть очень удобная возможность автоматически загрузать ВСЕ товары с учетом пейджирования:

> goods = universe.goods.all
> goods.count
> => 1280

> goods
> => [Moysklad::Entities::Page]


### Получить конкретный элемент

> universe.goods.get $uuid
> => [Moysklad::Entities::Good]


### Создаем элемент

Например загрузка заказа покупателя:

> co = Moysklad::Entities::CustomerOrder.new
> co.vatIncluded = true
> co.applicable  = true
> co.customerOrderPosition = [Moysklad::Entities::CustomerOrderPosition.new]
>
> created_order = universe.customer_orders.create co
> => [Moysklad::Entities::Good]
> created_order.uuid
> => uuid нового заказа

### Удаляем элемент

> universe.goods.delete $uuid

### Кеширование

Одной из главных возможностей данного модуля является возможность работать с API как с базой данных,
не выполняя запрос по получению каждого товара по-отдельности, и выдавать данные их кеша.

Класический способ получить данные по товару делает GET запрос каждый раз:

> > universe.goods.get $uuid
> => Client: GET exchange/rest/ms/xml/Good/f24937e7-7ba1-11e4-90a2-8ecb000abf12 {}
> => [Moysklad::Entities::Good]

Продвинутый способ вытаскивает все данные сразу и в дальнейшем берет обьекты из кеша:

> > universe.goods.find $uuid
> => Client: GET exchange/rest/ms/xml/Good/list {:start=>0}
> => Client: GET exchange/rest/ms/xml/Good/list {:start=>1000}
> => [Moysklad::Entities::Good]

И в следующий раз API уже не дергается:

> > universe.goods.find $another_uuid
> => [Moysklad::Entities::Good]

Это позволяет экономить на прямых запросах к API и избавляет нас от блокирования моимскладом по ограничению количества запросов за еденицу времени.


### Список доступных ресутсов:

> universe.resources_list
> => [:stock, :metadata, :custom_entity_metadata, :goods, :good_folders, :uoms, :countries,
      :features, :custom_entities, :customer_orders, :warehouses, :companies,
      :consignments, :my_companies]


## Pull Requests

### Добавление новых моделей и ресутсрв

Если в API моего склада есть справочник, который еще не добавлен в этот модуль, можете сделать это сами следующим образом.

Например добавляем Country.


1. Добавляем в фикстуры пример выгрузки из API для тестирования и отладки:

> MS_LOGON=логин MS_PASSWORD=пароль ./script/rest.sh Country list > ./spec/fixtures/Country_list.raw

2. Создаем сущность на основе уже существующей, например good.rb

> cp ./lib/moysklad/entities/good.rb ./lib/moysklad/entities/country.rb

3. Описываем свойства новой сущности Country.rb в терминах [nokogiri-happymapper](https://github.com/dam5s/happymapper)-а

> vi ./lib/moysklad/entities/country.rb

4. Добавляем сущность в requirements

> vi ./lib/moysklad/entities.rb

5. Содаем автоматический ресурс (имя ресурса во множественном числе)

> vi ./lib/moysklad/resources.rb

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
