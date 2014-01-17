Router.configure
  autoRender: false
  notFoundTemplate: "not_found"

Router.map ->
  @route "index",
    path: "/"
    data: ->
      if user = Users.findOne(login: username())
        user: user
        repos: Repositories.find(login: username(), fork: false)
        forks: Repositories.find(login: username(), fork: true)

  @route "example"

Template.header.events "click #search button": ->
  Router.go "/"
  username = $("#search input[type=text]").val()
  Meteor.call "create_repositories_if_not_exists", username
  Meteor.call "create_user_if_not_exists", username
  Session.set "username", username

username = -> Session.get("username") or default_username
