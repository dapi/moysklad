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

> client = MS::Client.new login:'ВАШ ЛОГИН', password:'ВАШ ПАРОЛЬ'

## Тестирование

> ./scripts/rest.sh Consignment list

## Ссылочки

* Картапамяти по API http://www.mindmeister.com/246618635/online-moysklad-ru
* Документация для разработчииков https://support.moysklad.ru/hc/ru/sections/200561443-Разработчикам

## Присылайте пул-реквесты )
