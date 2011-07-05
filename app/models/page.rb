# This is the model class that represents all pages, including blog posts.
# It is not an ActiveRecord model, it stores it's data in files.
class Page 
  include GitModel::Persistable

  attribute :title
  attribute :categories, :default => []
  attribute :site_menu_position, :default => nil
  attribute :allow_comments, :default => true # TODO implement comments
  attribute :include_in_feed, :default => true # TODO implement Atom feed

  def date
    if id =~ /(\d{4}-\d{2}-\d{2})-.+/
      return Date.parse($1)
    else
      return nil
    end
  end

  def is_post?
    date ? true : false
  end

  # Determine the name of the main part
  def main_part
    # TODO iterate over blobs here instead of using filesystem
    maybes = blobs.keys.keep_if{|k| k =~ /^main/}

    return maybes.any? ? File.basename(maybes.first) : nil
  end

  # return all Page objects that have the given category in the categories array
  def self.in_category(category)
    find_all(:categories => lambda{|cats| cats.include?(category)}, :order_by => :id, :order => :desc)
  end

  # return all Page objects that have a date that matches the given date range.
  # A date range is a string that matches 'YYYY/MM/DD' or 'YYYY/MM' or just
  # 'YYYY'
  def self.in_date_range(date_range)
    pattern = date_range.gsub(/\//, '-')
    find_all(:id => lambda{|id| id =~ /^#{pattern}/}, :order_by => :id, :order => :desc)
  end

  def self.all_posts
    # TODO add a spec
    find_all(:id => lambda{|id| id =~ /^(\d+-){3}/}, :order_by => :id, :order => :desc)
  end

  def self.all_categories
    @categories = Page.all_values_for_attr(:categories).flatten.sort.uniq
  end

  # convert an id to the format with slashes that's used in url's
  def self.urlify(id)
    if id =~ /(\d{4})-(\d{2})-(\d{2})-(.+)/
      return "#{$1}/#{$2}/#{$3}/#{$4}"
    else
      return id
    end
  end

  # convert an id from the format with slashes that's used in url's
  def self.de_urlify(id)
    if id =~ /(\d{4})\/(\d{2})\/(\d{2})\/(.+)/
      return "#{$1}-#{$2}-#{$3}-#{$4}"
    else
      return id
    end
  end

  # Determine the type of a part based on the name, returning a normalized
  # canonical type name in lower case. 
  # Examples:
  #   "foo.md" -> "markdown"
  #   "bar.htm -> "html"
  #   "baz.HTML -> "html"
  def self.type(name)
    return nil unless name && File.extname(name) =~ /\.(.*)/
    
    type = $1.downcase

    # return the canonical type name if it's an abbreviation:
    case type
    when "md"
      type = "markdown"
    when "htm"
      type = "html"
    when "rb"
      type = "ruby"
    end

    return type
  end

end
