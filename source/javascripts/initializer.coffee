$ ->

  # Responsive images
  # $('img.resp').responsiveImages()

  # Twitter
  if $('body').hasClass 'index'
    new TwitterFeed 'eurucamp', $('#tweets')
