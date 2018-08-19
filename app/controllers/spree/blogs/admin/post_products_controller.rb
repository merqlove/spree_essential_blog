class Spree::Blogs::Admin::PostProductsController < Spree::Admin::BaseController

  before_action :load_data

  def create
    position = @post.products.count
    @product = Spree::Variant.find(params[:variant_id]).product
    Spree::PostProduct.create(:post_id => @post.id, :product_id => @product.id, :position => position)
    render :partial => "spree/blogs/admin/post_products/related_products_table", :locals => { :post => @post }, :layout => false
  end

  def destroy
    @related = Spree::PostProduct.find(params[:id])
    return unless @related.destroy
    render_js_for_destroy
  end

  private

  def load_data
    @post = Spree::Post.find_by_path(params[:post_id])
  end

  def permitted_resource_params
    return ActionController::Parameters.new unless params[resource.object_name].present?
    params.require(resource.object_name).permit(:post_id, :product_id, :position)
  end
end