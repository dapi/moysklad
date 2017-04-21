#!/bin/bash ruby
$LOAD_PATH.unshift './lib'
require 'moysklad'
require 'byebug'
require 'pry'
universe = Moysklad::Universe.build login: ENV['MS_LOGIN'], password: ENV['MS_PASSWORD']


# goods -> products
# good_folders -> productfolders
# features -> variants
# consignments -> assortments
# stock.listWithConsignments
# uom -> done
# warehouses
#
# custom_entities -> значения словарей (придется брать по-одному)
#
# custom_entity_metadata -> словари
#   https://online.moysklad.ru/api/remap/1.1/entity/companysettings/metadata/
#
#   https://online.moysklad.ru/api/remap/1.1/entity/product/metadata/
#   https://online.moysklad.ru/api/remap/1.1/entity/variant/metadata/
#
#   attributes + characteristics
#
# embeded_entity_metada -> свойства
#
# https://online.moysklad.ru/api/remap/1.1/entity/companysettings/metadata/
# https://online.moysklad.ru/api/remap/1.1/entity/variant/metadata/
# https://online.moysklad.ru/api/remap/1.1/entity/product/metadata/
#
# stores =  universe.stores.all

# binding.pry
# puts universe.uoms.list
#
# Список словарей
# m = universe.company_settings_metadata
##
## Список аттрибутов
#dictionaries = m.customEntities

#dictionaries.each do |a|
  #puts '---'
  #puts a.meta.href
  #puts a.entityMeta.href
  #binding.pry
  #puts a.entities(universe).map { |e| [e.id, e.name].join(':') }.join(', ')
#end

a = universe.counterparties.all(filter: { phone: '79033891228' })


binding.pry

# products = universe.products.all

o = universe.organizations.all

organization = o.first

cp = Moysklad::Entities::Counterparty.new(
  name: 'Письменный Данил Викторович (test)',
  externalCode: 'test-couterpaty',
  actualAddress: 'Чебоксары, ул. Водопроводная, дом 7',
  email: 'danil@brandymint.ru',
  tags: ['kiiiosk'],
  phone: '+79033891228'
)
agent = universe.counterparties.create cp
assortment = {
  meta: {
    "href"=>"https://online.moysklad.ru/api/remap/1.1/entity/product/022528e1-fcfe-11e6-7a69-97110054d4e7",
    "metadataHref"=>"https://online.moysklad.ru/api/remap/1.1/entity/product/metadata",
    "type"=>"product",
    "mediaType"=>"application/json"
  }
}
positions = [
  Moysklad::Entities::CustomerOrderPosition.new(
    quantity: 1,
    price: 123,
    discount: 0,
    vat: 0,
    reserve: 1,
    assortment: assortment
  )
]
customer_order = Moysklad::Entities::CustomerOrder.new(
  name: "TEST-#{Time.now.to_i}",
  code: '123456',
  moment: Moysklad::Entities::Time.now,
  vatEnabled: false,
  applicable: false,
  organization: organization,
  agent: agent,
  # state: state,
  positions: positions,
  description: 'Тестовый заказ'
)

order = universe.customer_orders.create customer_order

binding.pry
puts order

# puts universe.currencies.findWhere isoCode: '643'
# Получаем рекурсивно действительно все значения
#custom_entities = universe.all_custom_entities
#binding.pry
#puts custom_entities.count
#
# Все элементы словаря
# list = universe.custom_entities(custom_entity_meta_id: 'e63c1592-807b-11e4-90a2-8ecb00113f68').all
# puts  list
# attrs = universe.variants.metadata.attrs
# attr = attrs.first
# e63c1592-807b-11e4-90a2-8ecb00113f68
# entities = attr.entities universe
#id = "022528e1-fcfe-11e6-7a69-97110054d4e7"
#byebug
#products = universe.products.all(expand: :productFolder)
#byebug
#products.each do |p|
  #puts p.dump.to_json
  ## binding.pry if p.externalCode == 'fhiI8yDIjwC-1-kiIbSO62'
  ## puts "#{p.externalCode}\t#{p.id}\t#{p.name}"
#end
# product.image.download(client)

#products.rows.each do |p|
  #binding.pry if p.attrs.count > 0
#end


#puts products.count

#products.rows.each do |p|
  #next unless p.characteristics
  #puts p.characteristics.map { |c| c.meta.href }
##  #puts p.characteristics.join('; ')
#end
# puts products.metadata
#roduct = products.rows.first

# Товар с attributes
# product = universe.products.get "02bbdea5-dbde-11e6-7a69-8f55000f3f4e"

#product_folders = universe.productfolders.list
#puts product_folders.rows.map { |pf| pf['dump'] }
#puts product_folders.meta.size
#puts universe.productfolders.get product_folders.rows.first.id

# variants = universe.variants.list
# byebug
## puts variants.meta.size
#variants.rows.each do |v|
  #next unless v.characteristics
  #puts v.characteristics.map { |c| c.meta.href }
  ## puts v.characteristics.join('; ')
#end
#puts products.meta.size
## puts universe.variants.get variants.rows.first.id
##
# stores = universe.stores.list
#puts stores.meta.size
## puts universe.stores.get stores.rows.first.id
#

# consignments = universe.consignments.all
#
#stockstore_uri = universe.stores.all.last.meta.href
#puts stockstore_uri
#list = universe.assortments.all stockstore: stockstore_uri
#binding.pry
#puts list.count
