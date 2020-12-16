let surroundingSeatDirections: [(Int, Int)] = {
	let rowSize = loadPuzzleInput()[0].count
	return [(1, 0), (1, -1), (0, -1), (-1, -1), (-1, 0), (-1, 1), (0, 1), (1, 1)]
}()

public enum Seat: Character {
	case floor = "."
	case empty = "L"
	case full = "#"
}

public func fillAndVacateSeats(seats: [[Seat]]) -> [[Seat]] {
	var newSeats = seats
	for (rowIndex, seatRow) in seats.enumerated() {
		for (colIndex, seat) in seatRow.enumerated() {
			switch seat  {
			case .empty:
				let occupiedSeat = surroundingSeatDirections.first { (x, y) in
					let surroundingSeat = seats[safe: rowIndex + x]?[safe: colIndex + y]
					return surroundingSeat == .full
				}
				if occupiedSeat == nil {
					newSeats[rowIndex][colIndex] = .full
				}
			case .full:
				var fullSurroudingSeatCount = 0
				for (x, y) in surroundingSeatDirections {
					let surroundingSeat = seats[safe: rowIndex + x]?[safe: colIndex + y]
					if surroundingSeat == .full {
						fullSurroudingSeatCount += 1
						if fullSurroudingSeatCount >= 4 {
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
