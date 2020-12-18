//: [Previous](@previous)

let input = loadPuzzleInput()

let timestamp = Int(input.first!)!
let busIDs = input.last!
	.split(separator: ",")
	.map(\.integerRepresentation)

do {
	let activeBusIDs = busIDs.compactMap { $0 }
	let busTimestamps = activeBusIDs.map { id in id - (timestamp % id) }
	let minMinsToWait = busTimestamps.min()!
	let bestActiveBusIndex = busTimestamps.firstIndex(of: minMinsToWait)!
	print("Part 1:", activeBusIDs[bestActiveBusIndex] * minMinsToWait)
}

do {
	var trackedBusIndicesIDs = busIDs
		.enumerated()
		.compactMap { (offset, element) in
			element != nil ? (offset, element!) : nil
		}
	var earliestDepartureInSeries = 0
	var increment = trackedBusIndicesIDs.removeFirst().1
	for (busIndex, busID) in trackedBusIndicesIDs {
		while (earliestDepartureInSeries + busIndex) % busID != 0 {
			earliestDepartureInSeries += increment
		}
		increment *= busID
	}
	print("Part 2:", earliestDepartureInSeries)
}

//: [Next](@next)
