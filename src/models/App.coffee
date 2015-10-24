# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on('busted', => @dealerPlay(true))
    @get('playerHand').on('stand', => @dealerPlay())
    @set('isPlaying', false)

  dealerPlay: (playerBusted) ->
    console.log('checking for winner')
    if playerBusted
      @set('winner', 'dealer')   
    else
      console.log('player not busted, checking scores')
      @get('dealerHand').at(0).flip()
      dealerScore = _.max(@get('dealerHand').scores())
      console.log(dealerScore);
      playerScore = _.max(@get('playerHand').scores())
      if playerScore > 21
        playerScore = _.min(@get('playerHand').scores())
      while dealerScore < 17

        @get('dealerHand').hit()
        dealerScore = _.max(@get('dealerHand').scores())
        if dealerScore > 21
          dealerScore = _.min(@get('dealerHand').scores())
      if dealerScore > 21
        @set('winner', 'player')
      else if playerScore > dealerScore
        @set('winner', 'player')
      else if dealerScore > playerScore
        @set('winner', 'dealer') 
      else if dealerScore == playerScore
        @set('winner', 'push')
    #@trigger 'winner', @

  reset: ->
    @get('playerHand').reset(@get('deck').dealPlayer().models);
    @get('dealerHand').reset(@get('deck').dealDealer().models);
    
