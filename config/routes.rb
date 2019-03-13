Spree::Core::Engine.append_routes do

  class PossibleBlog
    def self.matches?(request)
      fullpath = request.fullpath
      return false unless fullpath.match?(%r{/([a-z0-9\-\_\/]{3,})})
      return false if fullpath.match?(%r{(^\/+(#{SpreeEssentialBlog.route_regex}admin|account|cart|checkout|content|login|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user)+)})

      blog_id = %r{/([a-z0-9\-\_]{3,})}.match(fullpath)
      return false unless blog_id

      Spree::Blog.exists?(permalink: blog_id[1])
    end
  end

  scope(:module => 'blogs') do

    namespace :admin do

      resources :blogs, :constraints => { :id => /[a-z0-9\-\_\/]{3,}/ }

      resources :posts do
        resources :images, :controller => 'post_images' do
          collection do
            post :update_positions
          end
        end
        resources :products, :controller => 'post_products'
        resources :categories, :controller => 'post_categories'
      end

      resource :disqus_settings

    end
    constraints(PossibleBlog) do
      constraints(
        :year  => /\d{4}/,
        :month => /\d{1,2}/,
        :day   => /\d{1,2}/
      ) do
        get ':blog_id/:year(/:month(/:day))' => 'posts#index', :as => :post_date
        get ':blog_id/:year/:month/:day/:id' => 'posts#show',  :as => :full_post
      end

      get ':blog_id/category/:id'   => 'post_categories#show', :as => :post_category, :constraints => { :id => /.*/ }
      get ':blog_id/search/:query'  => 'posts#search',         :as => :search_posts, :query => /.*/
      get ':blog_id/archive'        => 'posts#archive',        :as => :archive_posts
      get ':blog_id'                => 'posts#index',          :as => :blog_posts

    end

  end

end
