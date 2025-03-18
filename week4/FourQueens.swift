import Foundation

// logic to solve a 4 queen problem using backtracking

func solveNQueens(n: Int) -> [[Int]] {
    var solutions: [[Int]] = []
    // board representation where index is row and value is the column position of the queen
    var board: [Int] = Array(repeating: -1, count: n)
    
    func isValid(row: Int, col: Int) -> Bool {
        // check if placing a queen is valid by comparing with previous rows
        for i in 0..<row {
            if board[i] == col || abs(board[i] - col) == row - i {
                return false
            }
        }
        return true
    }
    
    func placeQueen(row: Int) {
        // if all queens are placed, record the solution
        if row == n {
            solutions.append(board)
            return
        }
        for col in 0..<n {
            if isValid(row: row, col: col) {
                board[row] = col
                placeQueen(row: row + 1)
                board[row] = -1 // backtrack
            }
        }
    }
    
    placeQueen(row: 0)
    return solutions
}

// sample usage for 4 queen problem
let solutions = solveNQueens(n: 4)
print("solutions for 4 queen problem:")
for solution in solutions {
    print(solution)
}
