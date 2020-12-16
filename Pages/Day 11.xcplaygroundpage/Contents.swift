//: [Previous](@previous)

let seats = loadPuzzleInput()
	.map { row in
		Array(row).map { Seat(rawValue: $0)! }
	}

func countOccupiedSeatsAfterFollowingRules(inLineOfSight: Bool, minToVacate: Int) -> Int {
	var previousSeats = seats, newSeats = seats
	repeat {
		previousSeats = newSeats
		newSeats = fillAndVacateSeats(seats: previousSeats, inLineOfSight: inLineOfSight, minToVacate: minToVacate)
	} while (newSeats != previousSeats)
	return newSeats
		.flatMap { $0 }
		.filter { $0 == .full }
		.count
}

do {
	let occupiedSeatCount = countOccupiedSeatsAfterFollowingRules(inLineOfSight: false, minToVacate: 4)
	print("Part 1:", occupiedSeatCount)
}

do {
	let occupiedSeatCount = countOccupiedSeatsAfterFollowingRules(inLineOfSight: true, minToVacate: 5)
	print("Part 2:", occupiedSeatCount)
}

//: [Next](@next)
