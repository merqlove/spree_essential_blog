class Spree::Blogs::Admin::PostCategoriesController < Spree::Admin::ResourceController

  before_filter :load_data

  private

  def location_after_save
    admin_post_categories_url(@post)
  end

  def load_data
    @post = Spree::Post.find_by_path(params[:post_id])
    @post_categories = Spree::PostCategory.all
  end

  def permitted_resource_params
    params[resource.object_name].present? ? params.require(resource.object_name).permit(:name, :permalink) : ActionController::Parameters.new
  end

end
