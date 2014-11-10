module Moysklad::Resources

  class Good < Base; end
  class Feature < Base; end

  class Metadata < Base
    def entity_class
      Moysklad::Entities::EmbeddedEntityMetadata
    end
  end

  class CustomerOrder < Base; end
  class Warehouse < Base; end
  class Company < Base; end
  class Consignment < Base; end
  class MyCompany < Base; end

end
