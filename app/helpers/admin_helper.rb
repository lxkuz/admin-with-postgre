module AdminHelper
  def menu_list_item(url, options = {strategy: :inclusive},&block)
    extra_class = 'active' if is_active_link?(url, options[:strategy])
    "<li class='#{extra_class}'>#{capture(&block)}</li>".html_safe
  end

  def render_breadcrumbs
    return unless @breadcrumbs.try(:any?)
    content_tag :ol, class: 'breadcrumb' do
      @breadcrumbs.map do |obj|
        if obj[:url]
          content_tag :li, link_to(obj[:name], obj[:url])
        else
          content_tag :li, class: 'active' do
            content_tag :strong, obj[:name]
          end
        end
      end.join.html_safe
    end
  end

  def render_sort_button(order)
    order_params = params.clone
    reversion = { 1 => :desc, -1 => :asc }
    button_classes = { -1 => :desc, 1 => :asc }
    if order_params[:order_by].try(:[], order).blank?
      rev_key = :asc 
    else
      old_key = order_params[:order_by][order]
      rev_key = reversion[old_key]
      button_class = button_classes[old_key]
    end
    order_params[:order_by] = {}
    order_params[:order_by][order] = rev_key
    link_to url_for(order_params), class: 'btn btn-xs btn-white' do
      concat content_tag :i, nil, class: "fa fa-sort-#{button_class}" if button_class
      concat '&nbsp'.html_safe
      concat I18n.t("helpers.sort_by.#{order}")
    end
  end
end