Handlebars.registerHelper "link_tag", (text, url) ->
  new Handlebars.SafeString("<a href='#{url}'>#{text}</a>")

Handlebars.registerHelper "image_tag", (src, alt, width, height) ->
  new Handlebars.SafeString(
    "<img src='#{src}' alt='#{alt}' width='#{width}' height='#{height}'>"
  )

Handlebars.registerHelper "gravatar_tag", (id, size) ->
  src = "https://www.gravatar.com/avatar/#{id}.jpg?s=#{size}"
  new Handlebars.SafeString(
    "<img src='#{src}' alt='Gravatar' width='#{size}' height='#{size}' " +
      "class='img-thumbnail'>"
  )

Handlebars.registerHelper "nav_class", (route) ->
  current_route = Router.current()
  return '' unless current_route
  if current_route.template is route then "active" else ""
