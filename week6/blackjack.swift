import Foundation

// enum representing the four suits in a deck of cards
enum Suit: String {
    case hearts, diamonds, clubs, spades
}

// enum representing card ranks, with values assigned for numerical ranks and face cards
enum Rank: String {
    case two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9", ten = "10"
    case jack = "J", queen = "Q", king = "K", ace = "A"

    // returns the blackjack value of a given rank
    func value() -> Int {
        switch self {
        case .jack, .queen, .king:
            return 10
        case .ace:
            return 11  // ace initially counts as 11, but it can be adjusted later
        default:
            return Int(self.rawValue) ?? 0
        }
    }
}

// struct representing a playing card with a rank and a suit
struct Card {
    let rank: Rank
    let suit: Suit

    // formatted string representation of the card
    func description() -> String {
        return "\(rank.rawValue) of \(suit.rawValue)"
    }
}

// class representing a deck of 52 shuffled cards
class Deck {
    private var cards: [Card] = []

    init() {
        // generate all possible cards in a standard deck
        for suit in [Suit.hearts, Suit.diamonds, Suit.clubs, Suit.spades] {
            for rank in [Rank.two, Rank.three, Rank.four, Rank.five, Rank.six, Rank.seven, Rank.eight, Rank.nine, Rank.ten, Rank.jack, Rank.queen, Rank.king, Rank.ace] {
                cards.append(Card(rank: rank, suit: suit))
            }
        }
        shuffle()
    }

    // shuffle the deck to randomize card order
    func shuffle() {
        cards.shuffle()
    }

    // draw a card from the deck, removing it from the available cards
    func drawCard() -> Card? {
        return cards.isEmpty ? nil : cards.removeFirst()
    }
}

// class representing a blackjack player, including the dealer
class Player {
    let name: String
    var hand: [Card] = []

    init(name: String) {
        self.name = name
    }

    // adds a drawn card to the player's hand
    func receiveCard(_ card: Card) {
        hand.append(card)
    }

    // calculates the total value of the player's hand, adjusting for aces if needed
    func handValue() -> Int {
        var total = 0
        var aceCount = 0

        for card in hand {
            total += card.rank.value()
            if card.rank == .ace {
                aceCount += 1
            }
        }

        // adjust aces from 11 to 1 if needed to prevent busting
        while total > 21 && aceCount > 0 {
            total -= 10
            aceCount -= 1
        }

        return total
    }

    // displays the player's hand as a formatted string
    func handDescription() -> String {
        return hand.map { $0.description() }.joined(separator: ", ")
    }

    // checks if the player has blackjack (21 with two cards)
    func hasBlackjack() -> Bool {
        return hand.count == 2 && handValue() == 21
    }

    // checks if the player has busted (hand value over 21)
    func isBusted() -> Bool {
        return handValue() > 21
    }
}

// function to play a simple round of blackjack
func playBlackjack() {
    let deck = Deck()
    let player = Player(name: "player")
    let dealer = Player(name: "dealer")

    // deal two cards to each player
    player.receiveCard(deck.drawCard()!)
    player.receiveCard(deck.drawCard()!)
    dealer.receiveCard(deck.drawCard()!)
    dealer.receiveCard(deck.drawCard()!)

    // show player’s hand and one of the dealer’s cards
    print("your hand: \(player.handDescription()) (value: \(player.handValue()))")
    print("dealer’s visible card: \(dealer.hand[0].description())")

    // check for blackjack
    if player.hasBlackjack() {
        print("blackjack! you win!")
        return
    }

    // player's turn: choose to hit or stand
    while player.handValue() < 21 {
        print("hit or stand? (h/s)")
        if let choice = readLine()?.lowercased(), choice == "h" {
            if let newCard = deck.drawCard() {
                player.receiveCard(newCard)
                print("you drew: \(newCard.description())")
                print("your hand: \(player.handDescription()) (value: \(player.handValue()))")
            }
            if player.isBusted() {
                print("busted! dealer wins.")
                return
            }
        } else {
            break
        }
    }

    // dealer's turn (hits until 17 or more)
    print("dealer’s hand: \(dealer.handDescription()) (value: \(dealer.handValue()))")
    while dealer.handValue() < 17 {
        if let newCard = deck.drawCard() {
            dealer.receiveCard(newCard)
            print("dealer draws: \(newCard.description())")
        }
    }

    // determine the outcome
    print("final hands:")
    print("your hand: \(player.handDescription()) (value: \(player.handValue()))")
    print("dealer’s hand: \(dealer.handDescription()) (value: \(dealer.handValue()))")

    if dealer.isBusted() || player.handValue() > dealer.handValue() {
        print("you win!")
    } else if player.handValue() < dealer.handValue() {
        print("dealer wins.")
    } else {
        print("it's a tie.")
    }
}

// start the blackjack game
playBlackjack()
