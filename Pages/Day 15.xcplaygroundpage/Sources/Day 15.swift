public func findGameNumber(atTurn goal: Int, for input: [Int]) -> Int {
	var spokenNumbers = input
	var currentNumber = spokenNumbers.last!
	var previouslySpoken = spokenNumbers.dropLast()
	for turnIndex in input.count..<goal {
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
	return currentNumber
}
