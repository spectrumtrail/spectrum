module MarkdownHelper
  def markdown(text)
    options = []
    Markdown.new(text, *options).to_html.html_safe
  end

  class MarkdownRender < Redcarpet::Render::HTML
    def initialize(extensions = {})
      super extensions.merge(link_attributes: { target: '_blank' })
    end
  end

  def markdown_file(filename)
    path = Rails.root.join('app', 'assets', 'markdowns', filename)
    text = File.read(path)
    Redcarpet::Markdown.new(MarkdownRender, fenced_code_blocks: true).render(text).html_safe
  end
end