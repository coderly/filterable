require 'forwardable'

require 'filterable/filter_factory'
require 'filterable/hash_builder'

module Filterable

  class Collection
    extend Forwardable

    def initialize(base_collection, filter_options = {}, &filter_options_block)
      @base_collection = base_collection

      if block_given?
        @filter_options = HashBuilder.build(&filter_options_block)
      else
        @filter_options = filter_options
      end
    end

    def self.filter(filter_name, filter_class, *args)
      filter_factory.register filter_name, filter_class, *args
    end

    def_delegators :filtered_collection, *Enumerable.instance_methods, :empty?, :to_ary

    protected

    def filtered_collection
      @filtered_collection ||= apply_filters base_collection
    end

    private

    def self.filter_factory
      @filter_factory ||= FilterFactory.new
    end

    attr_reader :base_collection, :filter_options

    def filters
      @filters ||= filter_options.map { |(name, options)| filter_factory.build(name, options) }
    end

    def apply_filters(collection)
      filters.inject(collection) { |c, filter| filter.call(c) }
    end

    def filter_factory
      self.class.filter_factory
    end

  end

end
