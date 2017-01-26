# Description:
#   Responds with a derp gif
#
# Commands:
#   hubot herp - dndbot will derp when you herp!
#
# Author:
#   gkehoe

giphy =
  api_key: "dc6zaTOxFJmzC"
  api_url: "http://api.giphy.com"

  search: (msg, q, callback) ->
    endpoint = '/v1/gifs/search'
    url = "#{giphy.api_url}#{endpoint}"
    msg.http(url)
    .query
        api_key: giphy.api_key
        q: q
    .get() (err, res, body) ->
      res = JSON.parse(body)
      data = res?.data || []
      if data.length
        img_obj = msg.random data
        msg.send "derp " + (img_obj.images.original.url)
      else
        msg.send "No results found for #{q}"

module.exports = (robot) ->

  robot.hear /^herp$/i, (res) ->
    giphy.search res, "derp"
