module Jekyll
  class S3ImageTag < Liquid::Tag

    def initialize(tag_name, params, tokens)
      super
      args = split_params(params)
      @image_name = args[0]
      @alt_text = args[1]
      @width = args[2]
      @height = args[3]
    end

    def render(context)
        site = context.registers[:site]
        page_id = context.environments.first["page"]["id"]
        image_url = site.config['image_url'] + "/" + page_id.gsub('/','-').sub('-', '') + "/#{@image_name}"

        "<a href=\"" + image_url + "\">
        <img width=\"#{@width}\" height=\"#{@height}\" title=\"#{@alt_text}\" alt=\"#{@alt_text}\" src=\"" + image_url + "\"/>
        </a>"
    end
  end
end

def split_params(params)
  params.split(",").map(&:strip)
end
Liquid::Template.register_tag('s3_image', Jekyll::S3ImageTag)
