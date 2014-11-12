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

if defined? Rails
  Moysklad.logger = Rails.logger
else
  Moysklad.logger = Logger.new STDERR
end
