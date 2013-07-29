require 'filterable/collection'

module Filterable
  describe Collection do

    class MultipleOfFilter
      def initialize(multiple)
        @multiple = multiple
      end

      def call(collection)
        collection.select { |n| n % @multiple == 0 }
      end
    end

    class GreaterThanFilter
      def initialize(number)
        @number = number
      end

      def call(collection)
        collection.select { |c| c > @number }
      end
    end

    let(:numbers) { (1..9) }

    context 'when defining a collection with multiple filters' do

      class NumberCollection < Collection
        filter :multiple, MultipleOfFilter
        filter :gt, GreaterThanFilter
      end

      let(:collection) { NumberCollection.new(numbers, multiple: 3, gt: 5, some_option: 3) }
      subject { collection }

      its(:to_a) { should eq [6, 9] }
    end

  end
end