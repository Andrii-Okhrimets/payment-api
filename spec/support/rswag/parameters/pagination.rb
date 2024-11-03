module Rswag
  module Parameters
    module Pagination
      def self.extended(base)
        base.parameter name: :page, in: :query, required: false, type: :integer,
                       description: 'Page number'
        base.parameter name: :per_page, in: :query, required: false, type: :integer,
                       description: 'Items per page'
      end
    end
  end
end
