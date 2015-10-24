class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    
    console.log(@collection.scores())
    if @collection.hasAce() and !@collection.isDealer
      score1 = @collection.scores()[0]
      score2 = @collection.scores()[1]

      if score2 <= 21
        @$('.score').text "#{score1} or #{score2}"
      else
        @$('.score').text "#{score1}"
    else
      @$('.score').text @collection.scores()[0]
        
