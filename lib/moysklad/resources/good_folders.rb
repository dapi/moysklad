module Moysklad::Resources
  class GoodFolders < Base

    def self.type
      :goods
    end

    def self.pluralized_type
      :good_folders
    end

    def prefix_path
      PREFIX_PATH + 'Goods'
    end

  end
end

