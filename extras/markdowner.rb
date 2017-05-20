class Markdowner
  # opts[:allow_images] allows <img> tags
  # opts[:disable_profile_links] disables @username -> /u/username links

  def self.to_html(text, opts = {})
    if text.blank?
      return ""
    end

    exts = [:tagfilter, :autolink, :strikethrough]
    root = CommonMarker.render_doc(text.to_s, [:SMART], exts)

    unless opts[:disable_profile_links]
      walk_text_nodes(root) {|n| postprocess_text_node(n)}
    end

    ng = Nokogiri::HTML(root.to_html([:SAFE], exts))

    # change <h1>, <h2>, etc. headings to just bold tags
    ng.css("h1, h2, h3, h4, h5, h6").each do |h|
      h.name = "strong"
    end

    if !opts[:allow_images]
      ng.css("img").remove
    end

    # make links have rel=nofollow
    ng.css("a").each do |h|
      h[:rel] = "nofollow" unless h[:href].starts_with?("/")
    end

    ng.at_css("body").inner_html
  end

  def self.walk_text_nodes(node, &block)
    return if node.type == :link
    return block.call(node) if node.type == :text

    node.each do |child|
      walk_text_nodes(child, &block)
    end
  end

  def self.postprocess_text_node(node)
    while node
      return unless node.string_content =~ /\B(@[\w\-]+)/
      before, user, after = $`, $1, $'

      node.string_content = before

      if User.exists?(:username => user[1..-1])
        link = CommonMarker::Node.new(:link)
        link.url = "/u/#{user[1..-1]}"
        node.insert_after(link)

        link_text = CommonMarker::Node.new(:text)
        link_text.string_content = user
        link.append_child(link_text)

        node = link
      else
        node.string_content += user
      end

      if after.length > 0
        remainder = CommonMarker::Node.new(:text)
        remainder.string_content = after
        node.insert_after(remainder)

        node = remainder
      else
        node = nil
      end
    end
  end
end
