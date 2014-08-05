$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'permpress'
Dir['./spec/support/**/*.rb'].each{|file| require file}
