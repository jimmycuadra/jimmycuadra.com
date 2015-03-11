module JimmyCuadra
  module Markdown
    extend self

    attr_reader :redcarpet, :safe_redcarpet

    def render(text, options = {})
      initialize_redcarpet unless redcarpet && safe_redcarpet

      html = if options[:safe]
        safe_redcarpet.render(text)
      else
        redcarpet.render(text)
      end

      doc = Nokogiri::HTML.fragment(html)
      doc.css("pre").each do |pre|
        codeblock = pre.children.first
        lang = codeblock[:class]
        next if lang.nil?
        pre.replace CodeRay.scan(codeblock.text, lang).div(css: :class)
      end

      doc.to_s.html_safe
    end

    private

    def initialize_redcarpet
      renderer_options = { hard_wrap: true }

      safe_renderer_options = renderer_options.merge({
        filter_html: true,
        no_styles: true,
        safe_links_only: true
      })

      renderer = Redcarpet::Render::HTML.new(renderer_options)
      safe_renderer = Redcarpet::Render::HTML.new(safe_renderer_options)

      markdown_options = {
        autolink: true,
        fenced_code_blocks: true,
        no_intra_emphasis: true,
      }

      @redcarpet = Redcarpet::Markdown.new(renderer, markdown_options)
      @safe_redcarpet = Redcarpet::Markdown.new(safe_renderer, markdown_options)
    end
  end
end
