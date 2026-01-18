require 'redcarpet'

renderer = Redcarpet::Render::HTML.new

# Extension configuration
# Renderer with extensions
markdown = Redcarpet::Markdown.new(renderer, tables: true, strikethrough: true)

text = <<~MARKDOWN
  This is a ~~bad~~ good list:

  | Item   | Price |
  | ------ | ----- |
  | Apple  | $1.00 |
  | Bread  | $2.50 |
MARKDOWN

puts markdown.render(text)