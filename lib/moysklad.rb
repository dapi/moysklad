require 'virtus'
require 'json'
require 'active_support'
require 'moysklad/version'
require 'moysklad/attributes_converter'

require 'logger'

module Moysklad
  mattr_accessor :custom_logger

  %w{
    entities
    error
    resources
    client
    universe
  }.each do |m|
    require_relative "moysklad/#{m}"
  end

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
