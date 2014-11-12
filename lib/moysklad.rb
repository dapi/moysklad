require 'happymapper'
require 'active_support'
require "moysklad/version"
require 'logger'

module Moysklad
  mattr_accessor :logger
  extend ActiveSupport::Autoload

  autoload :Entities
  autoload :Resources
  autoload :Client
  autoload :Universe
end

Moysklad.logger = Logger.new STDERR
