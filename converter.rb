require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class CalloutRenderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  # Supported callouts
  CALLOUT_TYPES = %w[note tip important warning danger].freeze

  def table_cell(content, alignment)
    content = content.gsub('TOKEN_PIPE', '|')
    "<td style='text-align: left'>#{content}</td>"
  end

  def block_quote(quote)
    # Regex for callout blocks
    split_pattern = /(?=<p>\[(?:#{CALLOUT_TYPES.join('|')})\])/i

    # Split content blocks
    chunks = quote.split(split_pattern)

    # Process blocks
    rendered_chunks = chunks.map do |chunk|
      # Filter empty
      next if chunk.strip.empty?

      # Identify callout
      if chunk =~ /^\s*<p>\[(#{CALLOUT_TYPES.join('|')})\]/i
        type = $1.downcase
        display_title = type.capitalize

        # Strip marker
        clean_content = chunk.sub(/\[#{type}\]/i, '')

        # Prepare title
        title_element = "<span class='callout-title callout-title-#{type}'>#{display_title}</span>"

        # Content injection
        if clean_content.strip.start_with?("<p>")
          final_content = clean_content.sub("<p>", "<p>#{title_element}")
        else
          # Fallback injection
          final_content = "<div class='callout-title callout-title-#{type}'>#{display_title}</div>#{clean_content}"
        end

        "<div class='callout callout-#{type}'>#{final_content}</div>"
      else
        # Fallback for normal blockquotes
        "<blockquote>#{chunk}</blockquote>"
      end
    end

    # 5. Glue the styled chunks back together
    rendered_chunks.join("\n")
  end
end

# --- Script Execution ---

# Read the input file
input_text = File.read('input.md')

# Initialize renderer with options enabled
renderer = CalloutRenderer.new
markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true, tables: true)

# Convert to HTML
body_content = markdown.render(input_text)

# Wrap in full HTML template
html_output = <<~HTML
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8">
    <title>Modern Callouts</title>
    <link rel="stylesheet" href="style.css">
  </head>
  <body>
    <div class="container">
      #{body_content}
    </div>
  </body>
  </html>
HTML

# Write to file
File.write('output.html', html_output)
puts "Successfully created output.html!"