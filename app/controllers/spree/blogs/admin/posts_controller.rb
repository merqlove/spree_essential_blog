class Spree::Blogs::Admin::PostsController < Spree::Admin::ResourceController

  update.before :set_category_ids

  def new
    @post = Spree::Post.new
    @post.posted_at ||= Time.now
  end

  private

  def set_category_ids
    return unless permitted_resource_params[:post_category_ids].is_a?(Array)
    permitted_resource_params[:post_category_ids].reject!{|i| i.to_i == 0 }
  end

  def location_after_save
    path = params[:redirect_to].to_s.strip.sub(/^\/+/, "/")
    path.blank? ? object_url : path
  end

  def find_resource 
    @object ||= Spree::Post.find_by_path(params[:id])
  end

  def collection
    params[:q] ||= {}
    params[:q][:s] ||= "posted_at desc"
    @search = Spree::Post.search(params[:q])
    @collection = @search.result.page(params[:page]).per(Spree::Config[:admin_orders_per_page])
  end

  def permitted_resource_params
    return ActionController::Parameters.new unless params[resource.object_name].present?
    params.require(resource.object_name).permit(:blog_id,
                                                :title,
                                                :name,
                                                :teaser,
                                                :body,
                                                :posted_at,
                                                :author,
                                                :live,
                                                :tag_list,
                                                :post_category_ids,
                                                :product_ids_string)
  end

end
