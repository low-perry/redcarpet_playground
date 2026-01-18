require 'redcarpet'

class NewTabRenderer < Redcarpet::Render::HTML
  def link(url, title, content)
    # Force target _blank
    "<a href='#{url}' title='#{title}' target='_blank'>#{content}</a>"
  end
end

renderer = NewTabRenderer.new
markdown = Redcarpet::Markdown.new(renderer)

# Output
puts markdown.render("[OpenAI](https://www.openai.com 'OpenAI Homepage')")