Meteor.methods
  create_repositories_if_not_exists: (username) ->
    if Repositories.find({login: username}).count() is 0
      Meteor.call "load_repositories", username

  create_user_if_not_exists: (username) ->
    if Users.find({login: username}).count() is 0
      Meteor.call "load_user", username

  load_repositories: (username) ->
    uri = "https://api.github.com/users/#{username}/repos"
    HTTP.call "GET", uri, headers: {'User-Agent': 'Meteor'}, (error, result) ->
      repos = []
      for repo in EJSON.parse result.content
        Repositories.insert
          login: username
          name: repo.name
          description: repo.description
          fork: repo.fork
          url: repo.html_url

  load_user: (username) ->
    uri = "https://api.github.com/users/#{username}"
    HTTP.call "GET", uri, headers: {'User-Agent': 'Meteor'}, (error, result) ->
      user = EJSON.parse result.content
      Users.insert
        blog: user.blog
        company: user.company
        gravatar_id: user.gravatar_id
        followers: user.followers
        following: user.following
        login: user.login
        location: user.location
        name: user.name
        url: user.html_url

Meteor.autorun ->
  Meteor.call "create_repositories_if_not_exists", default_username
  Meteor.call "create_user_if_not_exists", default_username
