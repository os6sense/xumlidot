#require 'spec'
require 'mocha'
require 'active_record'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require_relative '../xamin'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
load(File.dirname(__FILE__) + '/schema.rb')
