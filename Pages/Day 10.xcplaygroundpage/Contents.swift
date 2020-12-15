//: [Previous](@previous)

let input = loadPuzzleInput().compactMap(\.integerRepresentation)

let orderedAdapters = input.sorted()

do {
	var previousAdapterJolts = 0
	var joltDifferences1 = 0
	var joltDifferences3 = 1
	for adapterJolts in orderedAdapters {
		let distanceBetweenAdapters = adapterJolts - previousAdapterJolts
		if distanceBetweenAdapters > 3 {
			fatalError("Jolt gap too large: \(adapterJolts) \(previousAdapterJolts)")
		}
		previousAdapterJolts = adapterJolts
		if distanceBetweenAdapters == 1 {
			joltDifferences1 += 1
		} else if distanceBetweenAdapters == 3 {
			joltDifferences3 += 1
		}
	}
	print("Part 1:", joltDifferences1 * joltDifferences3)
}

//: [Next](@next)
