$:.unshift File.dirname(__FILE__) + '/../../lib'
require 'jukebox/core'
World(Jukebox::TestDataBuilder)
