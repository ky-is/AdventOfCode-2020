//: [Previous](@previous)

let input = loadPuzzleInput()
	.map { $0.components(separatedBy: " = ") }

var addresses: [Int: Int] = [:]

var maskLength = 0
var masks: [(offset: Int, element: Character)] = []

for commandAssignment in input {
	let command = commandAssignment[0]
	let value = commandAssignment[1]
	if command == "mask" {
		maskLength = value.count
		masks = Array(value)
			.enumerated()
			.filter { $0.element != "X" }
			.map { (offset: $0.offset, element: $0.element as Character) }
	} else {
		let indexString = command.dropFirst(4).dropLast()
		let index = Int(indexString)!
		var result = Array(String(Int(value)!, radix: 2).leftPadding(toLength: maskLength, withPad: "0"))
		masks.forEach { (index, character) in
			if character == "X" {
				return
			}
			result[index] = character
		}
		let value = result
			.map { String($0) }
			.joined(separator: "")
			.reversed()
			.enumerated()
			.reduce(0) { accumulator, indexString in
				guard indexString.element != "0" else {
					return accumulator
				}
				return accumulator + 2 ^^ indexString.offset
			}
		addresses[index] = value
	}
}

print("Part 1:", addresses.values.reduce(0, +))

//: [Next](@next)
