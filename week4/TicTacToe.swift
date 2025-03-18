import Foundation

// structures and classes for the tic tac toe game

enum Player: String {
    case x = "x"
    case o = "o"
    
    func next() -> Player {
        return self == .x ? .o : .x
    }
}

class TicTacToeGame {
    var board: [[String]]
    var currentPlayer: Player
    
    init() {
        // initialize a 3x3 board with empty spaces
        board = Array(repeating: Array(repeating: " ", count: 3), count: 3)
        currentPlayer = .x
    }
    
    func play(row: Int, col: Int) -> Bool {
        // check valid position and if the cell is empty
        guard row >= 0 && row < 3 && col >= 0 && col < 3 else {
            print("invalid position")
            return false
        }
        
        if board[row][col] == " " {
            board[row][col] = currentPlayer.rawValue
            return true
        } else {
            print("position already taken")
            return false
        }
    }
    
    func checkWinner() -> String? {
        // check rows for a win
        for i in 0..<3 {
            if board[i][0] != " " && board[i][0] == board[i][1] && board[i][1] == board[i][2] {
                return board[i][0]
            }
        }
        
        // check columns for a win
        for j in 0..<3 {
            if board[0][j] != " " && board[0][j] == board[1][j] && board[1][j] == board[2][j] {
                return board[0][j]
            }
        }
        
        // check diagonals for a win
        if board[0][0] != " " && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            return board[0][0]
        }
        if board[0][2] != " " && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            return board[0][2]
        }
        
        return nil
    }
    
    func isBoardFull() -> Bool {
        // check if board has any empty cell
        return !board.joined().contains(" ")
    }
    
    func switchPlayer() {
        // change turn to the next player
        currentPlayer = currentPlayer.next()
    }
    
    func printBoard() {
        // print board row by row
        for row in board {
            print(row)
        }
    }
}

// sample usage

let game = TicTacToeGame()

// sample moves
if game.play(row: 0, col: 0) { game.switchPlayer() }
if game.play(row: 1, col: 1) { game.switchPlayer() }
if game.play(row: 0, col: 1) { game.switchPlayer() }
if game.play(row: 1, col: 2) { game.switchPlayer() }
if game.play(row: 0, col: 2) { game.switchPlayer() }

game.printBoard()
if let winner = game.checkWinner() {
    print("winner: \(winner)")
} else {
    print("no winner")
}
