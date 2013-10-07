require 'filterable/nil_filter'

module Filterable

  class FilterFactory

    def initialize
      @factories = {}
    end

    def register(filter_name, filter_class, *filter_args)
      @factories[filter_name] = [filter_class, *filter_args]
    end

    def build(filter_name, filter_options = {})
      filter_class, *filter_args = filter_class_and_args(filter_name)
      filter_class.new(filter_options, *filter_args)
    end

    private

    def filter_class_and_args(filter_name)
      @factories.fetch(filter_name) { [NilFilter, {}] }
    end

  end

end
