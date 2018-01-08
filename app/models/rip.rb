require 'ripper'
require 'pp'

file = File.read('v1.rb')
pp Ripper.sexp(file)
