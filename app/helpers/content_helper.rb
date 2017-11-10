module ContentHelper
  def allowed_tags_for_preview
    %w(b strong i em u s strike del p)
  end

  def preview(object)
    if object.respond_to?(:summary?) && object.summary?
      html = object.summary
    else
      html = object.body
    end

    html = truncate(sanitize(html, tags: allowed_tags_for_preview),
                    length: 500, escape: false, separator: /\s/)

    Nokogiri::HTML.fragment(html).to_html.html_safe # rubocop:disable Rails/OutputSafety
  end

  def html(html)
    if html
      doc = Nokogiri::HTML.fragment(html)
      doc.to_html.html_safe # rubocop:disable Rails/OutputSafety
    end
  end

  def tags(object, url_helper)
    url_base = breadcrumbs[-2]
    links = object.tags.map do |tag|
      link_to tag.name, send(url_helper, tag: tag.name)
    end
    safe_join(links)
  end

  def managed_content(region)
    content = ManagedContent.find_by!(region: region)
    html(content.body)
  end
end
