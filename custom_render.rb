require 'redcarpet'

# Custom HTML renderer
class BookRenderer < Redcarpet::Render::HTML
  # Header override
  def header(text, header_level)
    "<h#{header_level} style='color: red;'>Chapter: #{text}</h#{header_level}>"
  end
end

# Init custom renderer
renderer = BookRenderer.new
markdown = Redcarpet::Markdown.new(renderer)

# Output
puts markdown.render("# The Beginning")
puts markdown.render("## The Middle")