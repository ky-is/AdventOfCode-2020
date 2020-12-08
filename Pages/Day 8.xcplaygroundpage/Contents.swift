//: [Previous](@previous)

let input = getPuzzleInput().map { $0.split(separator: " ") }

func accumulate(input: [[String.SubSequence]]) -> Int {
	var accumulator = 0
	var currentIndex = 0
	var visitedIndices: [Int] = []
	while currentIndex < input.count && !visitedIndices.contains(currentIndex) {
		visitedIndices.append(currentIndex)
		let line = input[currentIndex]
		let instruction = line.first!
		let number = Int(line.last!)!
		switch instruction {
		case "nop":
			break
		case "acc":
			accumulator += number
		case "jmp":
			currentIndex += number
			continue
		default:
			fatalError(String(instruction))
		}
		currentIndex += 1
	}
	return accumulator
}

do {
	let accumulator = accumulate(input: input)
	print("Part 1:", accumulator)
}

//: [Next](@next)
