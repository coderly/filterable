module Filterable
  class HashBuilder

    def self.build(&block)
      builder = HashBuilder.new
      builder.instance_eval(&block)
      builder.hash
    end

    attr_reader :hash

    def initialize
      @hash = {}
    end

    def method_missing key, value, *, &block
      @hash[key] = block ? HashBuilder.build(&block) : value
    end

  end
end