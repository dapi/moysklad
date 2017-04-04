#!/bin/bash ruby
$LOAD_PATH.unshift './lib'
require 'moysklad'
universe = Moysklad::Universe.build login: ENV['MS_LOGIN'], password: ENV['MS_PASSWORD']

# goods -> products
# good_folders -> productfolders
# features -> variants
# consignments -> assortments
# stock.listWithConsignments
# uom -> donw
# warehouses
#
# custom_entities -> значения словарей (придется брать по-одному)
#
# custom_entity_metadata -> словари
#   https://online.moysklad.ru/api/remap/1.1/entity/companysettings/metadata/
#
# embeded_entity_metada -> свойства
#   https://online.moysklad.ru/api/remap/1.1/entity/product/metadata/
#   https://online.moysklad.ru/api/remap/1.1/entity/variant/metadata/
#
#   attributes + characteristics
#
# custom_metadata (Нет такого)
#
# customer_orders
#

# https://online.moysklad.ru/api/remap/1.1/entity/companysettings/metadata/
# https://online.moysklad.ru/api/remap/1.1/entity/variant/metadata/
# https://online.moysklad.ru/api/remap/1.1/entity/product/metadata/
#
# puts universe.uoms.list
#
puts universe.variants.metadata
#products = universe.products.list

#products.rows.each do |p|
  #binding.pry if p.attrs.count > 0
#end


#puts products.count

#products.rows.each do |p|
  #next unless p.characteristics
  #puts p.characteristics.map { |c| c.meta.href }
##  #puts p.characteristics.join('; ')
#end
#puts products.meta.size
#roduct = products.rows.first

# Товар с attributes
# product = universe.products.get "02bbdea5-dbde-11e6-7a69-8f55000f3f4e"

#product_folders = universe.productfolders.list
#puts product_folders.rows.map { |pf| pf['dump'] }
#puts product_folders.meta.size
#puts universe.productfolders.get product_folders.rows.first.id

#variants = universe.variants.list
## puts variants.meta.size
#variants.rows.each do |v|
  #next unless v.characteristics
  #puts v.characteristics.map { |c| c.meta.href }
  ## puts v.characteristics.join('; ')
#end
#puts products.meta.size
## puts universe.variants.get variants.rows.first.id
##
#stores = universe.stores.list
#puts stores.meta.size
## puts universe.stores.get stores.rows.first.id
#

#list = universe.assortments.all
#puts list.count
