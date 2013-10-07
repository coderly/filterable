module Filterable
  class NilFilter
    def initialize(*)
    end
    def call(collection)
      collection
    end
  end
end