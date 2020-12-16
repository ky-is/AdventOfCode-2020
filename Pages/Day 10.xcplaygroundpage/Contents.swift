//: [Previous](@previous)

let adapterJoltCompatibility = 1...3

let input: [Int] = loadPuzzleInput().compactMap(\.integerRepresentation)
let orderedAdapters = input.sorted()

do {
	var previousAdapterJolts = 0
	var joltDifferences1 = 0
	var joltDifferences3 = 1
	for adapterJolts in orderedAdapters {
		let distanceBetweenAdapters = adapterJolts - previousAdapterJolts
		if distanceBetweenAdapters > adapterJoltCompatibility.upperBound {
			fatalError("Jolt gap too large: \(adapterJolts) \(previousAdapterJolts)")
		}
		previousAdapterJolts = adapterJolts
		if distanceBetweenAdapters == 1 {
			joltDifferences1 += 1
		} else if distanceBetweenAdapters == adapterJoltCompatibility.upperBound {
			joltDifferences3 += 1
		}
	}
	print("Part 1:", joltDifferences1 * joltDifferences3)
}

do {
	var countsByAdapter = [0: 1]
	orderedAdapters.forEach { adapter in
		countsByAdapter[adapter] = adapterJoltCompatibility.reduce(0) { accumulator, joltDistance in
			accumulator + (countsByAdapter[adapter - joltDistance] ?? 0)
		}
	}
	print("Part 2:", countsByAdapter[orderedAdapters.last!]!)
}

//: [Next](@next)
