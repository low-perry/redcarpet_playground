require 'redcarpet'

# Safety options
renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)

# Extension setup
markdown = Redcarpet::Markdown.new(renderer, autolink: true)

# Render unsafe content
input = "This is <b>bold</b> and <script>alert('bad')</script>"
puts markdown.render(input)