module Spree
  module BlogsCustomResource
    extend ActiveSupport::Concern

    def resource
      return @resource if @resource
      parent_model_name = parent_data[:model_name] if parent_data
      @resource = Spree::Admin::BlogsResource.new controller_path, controller_name, parent_model_name, object_name
    end
  end
end
