require 'virtus'
require 'active_support'
require "moysklad/version"

require 'logger'

module Moysklad
  mattr_accessor :custom_logger
  extend ActiveSupport::Autoload

  require_relative 'moysklad/entities'
  autoload :Error
  autoload :Resources
  autoload :Client
  autoload :Universe

  def self.logger= value
    self.custom_logger = value
  end

  def self.logger
    return custom_logger if custom_logger

    if defined? Rails
      Rails.logger
    else
      Logger.new STDERR
    end
  end
end
