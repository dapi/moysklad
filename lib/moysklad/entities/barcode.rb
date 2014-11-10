module Moysklad::Entities
  class Barcode < Base
    include Common

    tag 'barcode'

    attribute :barcode, String
    # EAN13
    attribute :barcodeType, String

  end
end

