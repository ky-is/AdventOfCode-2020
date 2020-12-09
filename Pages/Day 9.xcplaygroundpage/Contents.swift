//: [Previous](@previous)

let preambleCount = 25

let input = loadPuzzleInput().map { $0.integerRepresentation! }

func hasTwoNumbers(addingTo goalNumber: Int, from numbers: ArraySlice<Int>) -> Bool {
	for i in numbers.indices {
		for j in numbers.indices {
			guard j != i else {
				continue
			}
			if numbers[i] + numbers[j] == goalNumber {
				return true
			}
		}
	}
	return false
}

func findContiguousNumbers(addingTo goalNumber: Int, from numbers: ArraySlice<Int>) -> [Int]? {
	var testNumbers = numbers
	var total = testNumbers.removeFirst()
	var contiguousNumbers: [Int] = [total]
	for testNumber in testNumbers {
		guard total < goalNumber else {
			break
		}
		total += testNumber
		contiguousNumbers.append(testNumber)
		if total == goalNumber {
			return contiguousNumbers
		}
	}
	return nil
}

//MARK: Run

var firstInvalidNumber: Int!
do {
	for index in preambleCount..<input.count {
		let number = input[index]
		let previousNumbers = input[index-preambleCount..<index]
		if !hasTwoNumbers(addingTo: number, from: previousNumbers) {
			firstInvalidNumber = number
			break
		}
	}
	print("Part 1:", firstInvalidNumber!)
}

do {
	var contiguousNumbers: [Int]?
	for index in 0..<input.count {
		guard let numbers = findContiguousNumbers(addingTo: firstInvalidNumber, from: input[index..<input.count]) else {
			continue
		}
		contiguousNumbers = numbers
		break
	}
	guard let numbers = contiguousNumbers else {
		fatalError("No contiguous numbers equaling first invalid number found.")
	}
	let maxNumber = numbers.reduce(0, max)
	let minNumber = numbers.reduce(maxNumber, min)
	print("Part 2:", minNumber + maxNumber)
}

//: [Next](@next)
