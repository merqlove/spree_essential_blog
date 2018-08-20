module Spree
  module Admin
    class BlogsResource < Spree::Admin::Resource
      def sub_namespace_parts
        @controller_path.split('/')[2..-3]
      end
    end
  end
end