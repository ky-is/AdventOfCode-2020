//: [Previous](@previous)

import Foundation

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
	let id = row * 8 + col
	return max(previousMax, id)
}

print("Part 1:", part1)

//: [Next](@next)
