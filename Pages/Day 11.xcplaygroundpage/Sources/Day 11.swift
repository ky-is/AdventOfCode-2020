private let surroundingSeatDirections = [(1, 0), (1, -1), (0, -1), (-1, -1), (-1, 0), (-1, 1), (0, 1), (1, 1)]

public enum Seat: Character {
	case floor = "."
	case empty = "L"
	case full = "#"
}

private func seatAt(seats: [[Seat]], rowIndex: Int, colIndex: Int) -> Seat? {
	return seats[safe: rowIndex]?[safe: colIndex]
}

private func isSeatFullInDirection(seats: [[Seat]], row: Int, col: Int, direction: (Int, Int), inLineOfSight: Bool) -> Bool {
	if !inLineOfSight {
		return seatAt(seats: seats, rowIndex: row + direction.1, colIndex: col + direction.0) == .full
	}
	let maxIterations = inLineOfSight ? .max : 2
	for distance in 1..<maxIterations {
		guard let surroundingSeat = seatAt(seats: seats, rowIndex: row + direction.1 * distance, colIndex: col + direction.0 * distance) else {
			break
		}
		switch surroundingSeat {
		case .full:
			return true
		case .empty:
			return false
		case .floor:
			continue
		}
	}
	return false
}

public func fillAndVacateSeats(seats: [[Seat]], inLineOfSight: Bool, minToVacate: Int) -> [[Seat]] {
	var newSeats = seats
	for (rowIndex, seatRow) in seats.enumerated() {
		for (colIndex, seat) in seatRow.enumerated() {
			switch seat {
			case .empty:
				let occupiedSeat = surroundingSeatDirections.first { direction in
					isSeatFullInDirection(seats: seats, row: rowIndex, col: colIndex, direction: direction, inLineOfSight: inLineOfSight)
				}
				if occupiedSeat == nil {
					newSeats[rowIndex][colIndex] = .full
				}
			case .full:
				var fullSeatsSurroundingSeatCount = 0
				for direction in surroundingSeatDirections {
					if isSeatFullInDirection(seats: seats, row: rowIndex, col: colIndex, direction: direction, inLineOfSight: inLineOfSight) {
						fullSeatsSurroundingSeatCount += 1
						if fullSeatsSurroundingSeatCount >= minToVacate {
							newSeats[rowIndex][colIndex] = .empty
							break
						}
					}
				}
			case .floor:
				continue
			}
		}
	}
	return newSeats
}
