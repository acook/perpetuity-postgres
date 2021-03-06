require 'perpetuity/postgres/table_name'

module Perpetuity
  class Postgres
    class SQLSelect
      attr_reader :selection, :table, :where, :group_by, :order, :limit, :offset

      def initialize *args
        @selection = if args.one?
                       '*'
                     else
                       args.shift
                     end
        options = args.first
        @table = options.fetch(:from)
        @where = options[:where]
        @group_by = options[:group]
        @order = options[:order]
        @limit = options[:limit]
        @offset = options[:offset]
      end

      def to_s
        "SELECT #{selection} FROM #{TableName.new(table)}" << where_clause.to_s <<
                                                              group_by_clause.to_s <<
                                                              order_clause.to_s <<
                                                              limit_clause.to_s <<
                                                              offset_clause.to_s
      end

      def where_clause
        if where
          " WHERE #{where}"
        end
      end

      def group_by_clause
        if group_by
          " GROUP BY #{group_by}"
        end
      end

      def order_clause
        order = Array(self.order)
        order.map! do |(attribute, direction)|
          if direction
            "#{attribute} #{direction.to_s.upcase}"
          else
            attribute
          end
        end

        unless order.empty?
          " ORDER BY #{order.join(',')}"
        end
      end

      def limit_clause
        if limit
          " LIMIT #{limit}"
        end
      end

      def offset_clause
        if offset
          " OFFSET #{offset}"
        end
      end
    end
  end
end
