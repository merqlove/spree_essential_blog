class Spree::Blog < ActiveRecord::Base
  RESERVED_PATHS = %r{(^\/*(admin|account|cart|checkout|content|login|pg|orders|products|s|session|signup|shipments|states|t|tax_categories|user)\/+)}

  has_many :posts, :class_name => 'Spree::Post', :dependent => :destroy
  has_many :categories, -> { distinct }, :through => :posts, :source => :post_categories

  validates :name, :presence => true
  validates :permalink, :uniqueness => true, :format => { :with => %r{[a-z0-9\-\_\/]+\z}i }, :length => { :within => 3..40 }
  validate  :permalink_availablity

  before_validation :normalize_permalink

  class << self
    def find_by_permalink!(path)
      super path.to_s.gsub(%r{(^\/+)|(\/+$)}, '')
    end

    def find_by_permalink(path)
      find_by_permalink!(path)
    rescue StandardError => _
      ActiveRecord::RecordNotFound
    end

    def to_options
      order(:name).map{ |i| [i.name, i.id] }
    end
  end

  def to_param
    permalink.gsub(%r{(^\/+)|(\/+$)}, '')
  end

  private

  def permalink_availablity
    errors.add(:permalink, 'is reserved, please try another.') if "/#{permalink}/".match?(RESERVED_PATHS)
  end

  def normalize_permalink
    self.permalink = (permalink.blank? ? name.to_s.parameterize : permalink).downcase.gsub(%r{(^[\/\-\_]+)|([\/\-\_]+$)}, '')
  end

end
