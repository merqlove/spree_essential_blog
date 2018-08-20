class Spree::Blogs::Admin::BlogsController < Spree::Admin::ResourceController

  def show
    redirect_to admin_blogs_path
  end

  private

  def find_resource
    Spree::Blog.find_by_permalink!(params[:id])
  end

  def collection
    params[:q] ||= {}
    params[:q][:s] ||= "name asc"
    @search = Spree::Blog.search(params[:q])
    @collection = @search.result.page(params[:page]).per(Spree::Config[:admin_orders_per_page])
  end

  def permitted_resource_params
    return ActionController::Parameters.new unless params[resource.object_name].present?
    params.require(resource.object_name).permit(:name, :permalink)
  end

  def model_class
    Spree::Blog
  end
end
