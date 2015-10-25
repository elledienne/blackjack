class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button" disabled>Hit</button> 
    <button class="stand-button" disabled>Stand</button>
    <input class="bet-input" type="text"/>
    <button class="bet-button">Place bet</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    #'click .next-button': -> 
      #@toggleButtons()
    #  @callReset()
    'click .bet-button': -> 
      @placeBet()

  initialize: ->
    @render()
    @listenTo(@model, 'change:winner', @winner)
    @listenTo(@model, 'change:isPlaying', @toggleButtons)

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  winner: ->
    console.log('winner method')
    @model.set('isPlaying', false)
    if confirm(@model.get('winner') + ' wins')
      #@stopListening(@model, 'change:winner')
      @model.unset('winner', {silent: true})
      #@listenTo(@model, 'change:winner', @winner) 
      #@$el.find('.bet-button').prop('disabled', false)
      @callReset()

  callReset: ->
    @$el.find('.bet-button').prop('disabled', false)
    @model.reset()


  toggleButtons: ->
    $buttons = @$el.find('.hit-button, .stand-button')
    if $buttons.prop('disabled') 
      $buttons.prop('disabled', false)
    else 
      $buttons.prop('disabled', true)

  placeBet: ->
    @$el.find('.bet-button').prop('disabled', true)
    @model.set('isPlaying', true)
    @model.set('currentBet', @$el.find('.bet-input').val())
    @model.get('playerHand').each((card) ->
      card.flip()
    )
    @model.get('dealerHand').at(1).flip()
