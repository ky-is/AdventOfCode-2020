//: [Previous](@previous)

import PlaygroundSupport
import SwiftUI

struct BinarySeat {
	let row, col: Int

	var id: Int {
		row * 8 + col
	}

	init(row: Int, col: Int) {
		self.row = row
		self.col = col
	}

	init(binaryString: String) {
		row = getNumberFromBinary(characters: Array(binaryString.prefix(7)), lower: "B", upper: "F")
		col = getNumberFromBinary(characters: Array(binaryString.suffix(3)), lower: "R", upper: "L")
	}
}

func getNumberFromBinary(characters: [Character], lower: Character, upper: Character) -> Int {
	let rangeSize = 2 ^^ characters.count
	var min = 0, max = rangeSize - 1
	characters.forEach { character in
		let halfDistance = (max - min) / 2 + 1
		switch character {
		case lower:
			min += halfDistance
		case upper:
			max -= halfDistance
		default:
			fatalError("Unknown input \(character)")
		}
	}
	return min
}

let input = getPuzzleInput().map { BinarySeat(binaryString: $0) }

let part1 = input.reduce(0) { previousMax, seat in
	return max(previousMax, seat.id)
}
print("Part 1:", part1)

var occupiedSeats: [[Bool]] = Array(repeating: Array(repeating: false, count: 8), count: 128)
input.forEach { seat in
	occupiedSeats[seat.row][seat.col] = true
}

var foundFullRow = false
var part2: BinarySeat?
for (row, rowOccupants) in occupiedSeats.enumerated() {
	let emptySeatCol = rowOccupants.firstIndex(of: false)
	if foundFullRow {
		if let col = emptySeatCol {
			part2 = BinarySeat(row: row, col: col)
			break
		}
	} else if emptySeatCol == nil {
		foundFullRow = true
	}
}
if let part2 = part2 {
	print("Part 2:", part2.id, part2)
} else {
	print("No empty seat found")
}

let seatDiagram = occupiedSeats.map { row in
	row.map { $0 ? "X" : "O" }.joined(separator: "")
}
PlaygroundPage.current.setLiveView(
	Text(seatDiagram.joined(separator: "\n"))
		.font(.system(.body, design: .monospaced))
)

//: [Next](@next)
