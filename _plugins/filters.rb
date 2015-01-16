module Jekyll
  module Filters

    # Outputs a list of categories as comma-separated <a> links. This is used
    # to output the category list for each post on a category page.
    #
    #  +categories+ is the list of categories to format.
    #
    # Returns string
    def category_links(categories)
      categories = categories.sort!.map do |category|
        "<a class='category' href='/categories/#{category}/'>#{category}</a>"
      end

      case categories.length
      when 0
        ""
      when 1
        categories[0].to_s
      else
        categories.join(', ')
      end
    end
  end
end
Liquid::Template.register_filter(Jekyll::Filters)
