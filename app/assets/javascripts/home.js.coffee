# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  
  $('.help-box').popover({})
  
  $(window).resize ->
    if (!Modernizr.mq("(max-width: 979px)"))
      $('.touch-help').hide()
    else
      $('.help-box').popover 'hide'
  
  popup = null
  $('.help-box').on "mouseenter", ->
    if (!Modernizr.mq("(max-width: 979px)"))
      $(this).popover 'show'
      popup = this
  $('.help-box').on "mouseleave", ->
    if (!Modernizr.mq("(max-width: 979px)"))
      $(this).popover 'hide'
      popup = null
  
  $('.help-box').click ->
    if (Modernizr.mq("(max-width: 979px)"))
      $(this).parent().parent().parent().find('.touch-help').slideToggle()
    
    return false
  $('.external').on "click", ->
    trackOutboundLink(this, 'Outbound Links', $(this).attr('href'))
    
trackOutboundLink = (link, category, action) ->
  try
    _gaq.push(['_trackEvent', category , action])
  
  setTimeout(->
    document.location.href = link.href
  , 100)
