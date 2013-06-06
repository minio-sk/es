require 'es/version'
require 'es/client'

module ES
  def self.new(*args) # faux constructor
    Client.new(*args)
  end
end
