import Foundation

// models and logic for splitwise

struct User: Hashable {
    let name: String
}

struct Expense {
    let payer: User
    let amount: Double
    let participants: [User]
}

struct Transaction {
    let from: User
    let to: User
    let amount: Double
}

func settleDebts(expenses: [Expense]) -> [Transaction] {
    var netBalances: [User: Double] = [:]
    for expense in expenses {
        let share = expense.amount / Double(expense.participants.count)
        for participant in expense.participants {
            netBalances[participant, default: 0.0] -= share
        }
        netBalances[expense.payer, default: 0.0] += expense.amount
    }
    
    var creditors: [(user: User, amount: Double)] = []
    var debtors: [(user: User, amount: Double)] = []
    
    for (user, balance) in netBalances {
        if balance > 0 {
            creditors.append((user, balance))
        } else if balance < 0 {
            debtors.append((user, -balance))
        }
    }
    
    creditors.sort { $0.amount > $1.amount }
    debtors.sort { $0.amount > $1.amount }
    
    var transactions: [Transaction] = []
    var i = 0, j = 0
    while i < debtors.count && j < creditors.count {
        let debtor = debtors[i]
        let creditor = creditors[j]
        let minAmount = min(debtor.amount, creditor.amount)
        transactions.append(Transaction(from: debtor.user, to: creditor.user, amount: minAmount))
        debtors[i].amount -= minAmount
        creditors[j].amount -= minAmount
        if debtors[i].amount == 0 { i += 1 }
        if creditors[j].amount == 0 { j += 1 }
    }
    return transactions
}

// sample usage

let alice = User(name: "alice")
let bob = User(name: "bob")
let charlie = User(name: "charlie")

let expense1 = Expense(payer: alice, amount: 120, participants: [alice, bob, charlie])
let expense2 = Expense(payer: bob, amount: 60, participants: [alice, bob])
let expense3 = Expense(payer: charlie, amount: 150, participants: [bob, charlie])

let expenses = [expense1, expense2, expense3]
let transactions = settleDebts(expenses: expenses)

for transaction in transactions {
    print("\(transaction.from.name) pays \(transaction.to.name): \(String(format: "%.2f", transaction.amount))")
}
