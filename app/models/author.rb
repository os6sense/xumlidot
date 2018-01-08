class Author < ActiveRecord::Base
  has_many :books
  def write(); end
end
