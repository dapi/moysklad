require 'happymapper'
require 'active_support'
require "moysklad/version"

module Moysklad
   extend ActiveSupport::Autoload

   autoload :Entities
   autoload :Resources
   autoload :Client
   autoload :Universe
end
