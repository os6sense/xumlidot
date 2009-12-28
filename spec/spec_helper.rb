require 'spec'
require 'mocha'
require 'active_record'
require 'xamin'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

Spec::Runner.configure do |config|
  
end

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
load(File.dirname(__FILE__) + '/schema.rb')
