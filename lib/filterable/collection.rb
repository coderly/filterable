require 'forwardable'

require 'filterable/filter_factory'

module Filterable

  class Collection
    extend Forwardable

    def initialize(base_collection, filter_options = {})
      @base_collection = base_collection
      @filter_options = filter_options
    end

    def self.filter_factory
      @filter_factory ||= FilterFactory.new
    end

    def self.filter(filter_name, filter_class)
      filter_factory[filter_name] = filter_class
    end

    def_delegators :filtered_collection, *Enumerable.instance_methods, :empty?

    protected

    def filtered_collection
      @filtered_collection ||= apply_filters base_collection
    end

    private

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
