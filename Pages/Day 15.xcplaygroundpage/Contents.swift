//: [Previous](@previous)

let input = loadPuzzleInput(separatedBy: ",")
	.compactMap(\.integerRepresentation)

do {
	let numberAtGoal = findGameNumber(atTurn: 2020, for: input)
	print("Part 1:", numberAtGoal)
}

do {
	let numberAtGoal = findGameNumber(atTurn: 30000000, for: input)
	print("Part 2:", numberAtGoal)
}

//: [Next](@next)
