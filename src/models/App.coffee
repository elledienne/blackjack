# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on('busted', => @dealerPlay(true))
    @get('playerHand').on('stand', => @dealerPlay())

  dealerPlay: (playerBusted) ->
    if playerBusted
      @set('winner', 'dealer')   
    else
      @get('dealerHand').at(0).flip()
      dealerScore = _.min(@get('dealerHand').scores())
      playerScore = _.min(@get('playerHand').scores())
      while dealerScore < 17
        @get('dealerHand').hit()
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
    @get('playerHand').reset();
    @get('dealerHand').reset();
    @set('playerHand', @get('deck').dealPlayer())
    @set('dealerHand', @get('deck').dealDealer())