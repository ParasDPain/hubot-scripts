# Description:
#   Get free advice from http://adviceslip.com/
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot what should I do about (.*)
#   hubot what do you think about (.*)
#   hubot how do you handle (.*)
#   hubot I need some advice
#
# Author:
#   pengwynn
#
getAdvice = (msg, query) ->
  msg.http("http://api.adviceslip.com/advice/search/#{query}")
    .get() (err, res, body) ->
      results = JSON.parse body
      if results.message? then randomAdvice(msg) else msg.send(msg.random(results.slips).advice)

randomAdvice = (msg) ->
  msg.http("http://api.adviceslip.com/advice")
    .get() (err, res, body) ->
      results = JSON.parse body
      advice = if err then "You're on your own, bud" else results.slip.advice
      msg.send advice


module.exports = (robot) ->
  robot.respond /(.*)/i, (msg) ->
    randomAdvice(msg)
