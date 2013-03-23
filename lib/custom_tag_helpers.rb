# TMP solution:
# https://github.com/middleman/middleman/pull/370#issuecomment-6727140
# https://github.com/bhollis/middleman/blob/1229a9991a4bf575bef5edb6180dac5b63fce5c5/middleman-core/lib/middleman-core/application.rb#L220
module Middleman
  class Application
    # Work around this bug: http://bugs.ruby-lang.org/issues/4521
    # where Ruby will call to_s/inspect while printing exception
    # messages, which can take a long time (minutes at full CPU)
    # if the object is huge or has cyclic references, like this.
    def to_s
      "the Middleman application context"
    end
  end
end

module CustomTagHelpers

  def md2html(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text)
  end

  def vimeo(vimeo_id, attrs = {})
    video_attrs = {
      :src                   => "http://player.vimeo.com/video/#{vimeo_id}",
      :width                 => 500,
      :height                => 281,
      :frameborder           => "0",
      :webkitAllowFullScreen => true,
      :mozallowfullscreen    => true,
      :allowFullScreen       => true
    }
    capture_haml do
      haml_tag :div, inject_class(attrs, 'resp-video') do
        haml_tag :iframe, video_attrs
      end
    end
  end

  def image(url, sizes = [], attrs = {})
    attrs[:src] = url
    attrs = inject_class(attrs, 'resp')
    sizes.each do |size|
      attrs[:"data-#{size}"] = image_url_for_size(url, size)
    end
    capture_haml do
      haml_tag :img, attrs
    end
  end

  def nav(items, attrs = {})
    attrs_to_merge = [:type, :rel].freeze
    capture_haml do
      haml_tag :nav do
        haml_tag :ul, attrs do
          items.each do |item|
            item, item_options = item.is_a?(Hash) ? item.to_a.flatten : [item, {}]
            item_options       = {:path => item_options} if item_options.is_a? String

            path        = item_options[:path]        || "/#{item.downcase.dasherize}"
            path_regexp = item_options[:path_regexp] || /^#{path.gsub('.html', '')}/


            haml_tag :li, :class => item.downcase do
              new_attrs = {
                :href  => path,
                :class => ('active' if request.path =~ path_regexp),
                # this is used for development only!
                # :href  => path + '.html',
                # :class => ('active' if request.path.gsub('.html', '') == path.gsub('/', '')),
                :title => "Read about #{item.downcase}",
                :data => {:filter => item.downcase}
              }
              attrs_to_merge.each do |key|
                new_attrs.merge! key => attrs[key] if attrs[key]
              end
              haml_tag :a, item, new_attrs
            end
          end
        end
      end
    end
  end

private

  def inject_class(attributes, klass)
    attrs = attributes.dup
    attrs[:class] ||= ''
    attrs[:class] << " #{klass}"
    attrs[:class].strip!
    attrs
  end

  def image_url_for_size(url, size)
    extension = File.extname(url)
    url.chomp(extension) + '-' + size.to_s + extension
  end

end
