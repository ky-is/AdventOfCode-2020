//: [Previous](@previous)

let input = loadPuzzleInput(separatedBy: ",")
	.compactMap(\.integerRepresentation)

do {
	let goalIndex = 2020
	var spokenNumbers = input
	var currentNumber = spokenNumbers.last!
	var previouslySpoken = spokenNumbers.dropLast()
	for turnIndex in input.count..<goalIndex {
		let previousNumber = currentNumber
		if previouslySpoken.contains(currentNumber) {
			let previousIndex = previouslySpoken.lastIndex(of: currentNumber)!
			currentNumber = turnIndex - previousIndex - 1
		} else {
			currentNumber = 0
		}
		spokenNumbers.append(currentNumber)
		previouslySpoken.append(previousNumber)
	}
	print("Part 1:", currentNumber)
}

//: [Next](@next)
