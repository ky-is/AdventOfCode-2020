//: [Previous](@previous)

let preambleCount = 25

let input = loadPuzzleInput().map { $0.integerRepresentation! }

func hasTwoNumbersAddingTo(number: Int, from numbers: [Int]) -> Bool {
	for i in 0..<numbers.count {
		for j in 0..<numbers.count {
			guard j != i else {
				continue
			}
			if numbers[i] + numbers[j] == number {
				return true
			}
		}
	}
	return false
}

do {
	var firstInvalidNumber: Int?
	for index in preambleCount..<input.count {
		let number = input[index]
		let previousNumbers = input[index-preambleCount..<index]
		if !hasTwoNumbersAddingTo(number: number, from: Array(previousNumbers)) {
			firstInvalidNumber = number
			break
		}
	}
	print("Part 1:", firstInvalidNumber!)
}

//: [Next](@next)
