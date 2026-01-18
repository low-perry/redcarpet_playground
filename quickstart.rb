require 'redcarpet'

# Renderer init
renderer = Redcarpet::Render::HTML.new

# Parser init
markdown = Redcarpet::Markdown.new(renderer)

# Render output
output = markdown.render("This is **extremely** fast.")

puts output