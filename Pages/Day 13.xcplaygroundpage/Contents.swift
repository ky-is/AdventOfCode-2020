//: [Previous](@previous)

let input = loadPuzzleInput()

let timestamp = Int(input.first!)!
let busIDs = input.last!
	.split(separator: ",")
	.compactMap(\.integerRepresentation)

do {
	let busTimestamps = busIDs
		.map { id in id - (timestamp % id) }
	let minMinsToWait = busTimestamps.min()!
	let bestBusIndex = busTimestamps
		.firstIndex(of: minMinsToWait)!
	print("Part 1:", busIDs[bestBusIndex] * minMinsToWait)
}

//: [Next](@next)
