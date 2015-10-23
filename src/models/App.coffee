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
    if !playerBusted
      dealerScore = _.min(@get('dealerHand').scores())
      playerScore = _.min(@get('playerHand').scores())
      while dealerScore < 17
        @get('dealerHand').hit()
        dealerScore = _.min(@get('dealerHand').scores())
        if dealerScore > 21
          break
    @set('winner', 'dealer')   

    
    @trigger 'winner', @


# if player > 21, dealer wins

# if dealer > 21, player wins

# if player < 21 && player > dealer, player wins

# if dealer < 21 && dealer > player, dealer wins
      
#
