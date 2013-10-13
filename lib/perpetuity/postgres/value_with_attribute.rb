module Perpetuity
  class Postgres
    class ValueWithAttribute
      attr_reader :value, :attribute
      def initialize value, attribute
        @value = value
        @attribute = attribute
      end

      def type
        attribute.type
      end

      def embedded?
        attribute.embedded?
      end
    end
  end
end
