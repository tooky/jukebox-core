$:.unshift File.dirname(__FILE__) + '/../../lib'
require 'wedding_jukebox/core'
World(WeddingJukebox::TestDataBuilder)
