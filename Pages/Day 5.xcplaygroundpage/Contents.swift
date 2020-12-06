//: [Previous](@previous)

import PlaygroundSupport
import SwiftUI

func getSeatID(row: Int, col: Int) -> Int {
	return row * 8 + col
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

let input = getPuzzleInput()

let part1 = input.reduce(0) { previousMax, binaryData in
	let row = getNumberFromBinary(characters: Array(binaryData.prefix(7)), lower: "B", upper: "F")
	let col = getNumberFromBinary(characters: Array(binaryData.suffix(3)), lower: "R", upper: "L")
	return max(previousMax, getSeatID(row: row, col: col))
}
print("Part 1:", part1)

var occupiedSeats: [[Bool]] = Array(repeating: Array(repeating: false, count: 8), count: 128)
input.forEach { binaryData in
	let row = getNumberFromBinary(characters: Array(binaryData.prefix(7)), lower: "B", upper: "F")
	let col = getNumberFromBinary(characters: Array(binaryData.suffix(3)), lower: "R", upper: "L")
	occupiedSeats[row][col] = true
}

var foundFullRow = false
var part2 = 0
for (row, rowOccupants) in occupiedSeats.enumerated() {
	let emptySeatCol = rowOccupants.firstIndex(of: false)
	if foundFullRow {
		if let col = emptySeatCol {
			print(row, col)
			part2 = getSeatID(row: row, col: col)
			break
		}
	} else if emptySeatCol == nil {
		foundFullRow = true
	}
}
print("Part 2:", part2)

let seatDiagram = occupiedSeats.map { row in
	row.map { $0 ? "X" : "O" }.joined(separator: "")
}
PlaygroundPage.current.setLiveView(
	Text(seatDiagram.joined(separator: "\n"))
		.font(.system(.body, design: .monospaced))
)

//: [Next](@next)
