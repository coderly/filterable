module Filterable

  NoFilterError = Class.new(StandardError)

  class NilFilter
    def initialize(*)
    end
    def call(collection)
      collection
    end
  end

  class FilterFactory

    def initialize
      @factories = {}
    end

    def []=(filter_name, filter_class)
      @factories[filter_name] = filter_class
    end

    def [](filter_name)
      @factories.fetch(filter_name) { NilFilter }
    end

    def build(filter_name, options = {})
      self[filter_name].new(options)
    end

  end

end
