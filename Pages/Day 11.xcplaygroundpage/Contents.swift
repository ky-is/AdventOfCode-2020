//: [Previous](@previous)

let seats = loadPuzzleInput()
	.map { row in
		Array(row).map { Seat(rawValue: $0)! }
	}

do {
	var previousSeats = seats, newSeats = seats
	repeat {
		previousSeats = newSeats
		newSeats = fillAndVacateSeats(seats: previousSeats)
	} while (newSeats != previousSeats)

	let occupiedSeatCount = newSeats
		.flatMap { $0 }
		.filter { $0 == .full }
		.count
	print("Part 1:", occupiedSeatCount)
}

//: [Next](@next)
