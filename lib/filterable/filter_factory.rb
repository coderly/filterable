require 'pry'

module Filterable

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

    def register(filter_name, filter_class, defaults = {})
      @factories[filter_name] = [filter_class, defaults]
    end

    def build(filter_name, options = {})
      klass, defaults = fetch(filter_name)
      klass.new build_options(options, defaults)
    end

    private

    def build_options(options, defaults)
      if defaults.respond_to?(:to_hash) && options.respond_to?(:to_hash)
        defaults.to_hash.merge(options.to_hash)
      else
        options
      end
    end

    def fetch(filter_name)
      @factories.fetch(filter_name) { [NilFilter, {}] }
    end

  end

end
