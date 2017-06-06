class CustomBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.render "/partial/breadcrumb", elements: @elements
  end
end
