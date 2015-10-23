class window.CardView extends Backbone.View
  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'
  template: _.template '<img src="img/cards/<%- rankName %>-<%- suitName %>.png"></img>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    if !@model.get 'revealed' 
      @$el[0].firstChild.src = 'img/card-back.png'
