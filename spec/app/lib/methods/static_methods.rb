# frozen_string_literal: true

class Printer
  class << self
    def print; end
  end
end

class Printer2
  class << self
    def print; end
  end

  def colors; end
end

class Printer3
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def colors; end
end

class Printer4
  def self.print; end

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def colors; end
end
