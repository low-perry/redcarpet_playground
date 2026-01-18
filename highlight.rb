require 'redcarpet'
require 'rouge'

class SyntaxHighlightingRenderer < Redcarpet::Render::HTML
  def block_code(code, language)
    # Language validation
    lexer = Rouge::Lexer.find(language) || Rouge::Lexers::PlainText

    # Rouge formatting
    formatter = Rouge::Formatters::HTML.new
    formatter.format(lexer.lex(code))
  end
end

renderer = SyntaxHighlightingRenderer.new
markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)

code = <<~MARKDOWN
  Here is some Ruby code:

  ```ruby
  def hello
    puts "Hello World"
  end
```
MARKDOWN

puts markdown.render(code)

# Generate CSS
theme = Rouge::Themes::Github.render(scope: '.highlight')

puts ""
puts theme
puts ""

puts markdown.render(code)