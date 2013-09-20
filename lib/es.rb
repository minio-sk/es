module ES
  def self.new(*args) # faux constructor
    Client.new(*args)
  end
end

require 'es/version'
require 'es/connection'
require 'es/raw_client'
require 'es/client'
require 'es/utils'
