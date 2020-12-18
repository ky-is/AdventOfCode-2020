//: [Previous](@previous)

let bitCount = 36

let input = loadPuzzleInput()
	.map { $0.components(separatedBy: " = ") }
	.map { (command: $0.first!, value: $0.last!) }

typealias Mask = (offset: Int, element: Character)

func parse(mask value: String) -> [Mask] {
	return Array(value)
		.enumerated()
		.map { $0 as Mask }
}

func getMemoryIndex(from command: String) -> Int {
	let indexString = command.dropFirst(4).dropLast()
	return Int(indexString)!
}

func apply(masks: [Mask], ignoring: Character, to value: Int) -> [Character] {
	var result = Array(String(value, radix: 2).leftPadding(toLength: bitCount, withPad: "0"))
	masks.forEach { (index, character) in
		if character == ignoring {
			return
		}
		result[index] = character
	}
	return result
}

func integer(fromBitArray bitArray: [Character]) -> Int{
	return bitArray
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
}

do {
	var addresses: [Int: Int] = [:]
	var masks: [Mask] = []
	for (command, value) in input {
		if command == "mask" {
			masks = parse(mask: value)
		} else {
			let memoryIndex = getMemoryIndex(from: command)
			let result = apply(masks: masks, ignoring: "X", to: Int(value)!)
			addresses[memoryIndex] = integer(fromBitArray: result)
		}
	}
	print("Part 1:", addresses.values.reduce(0, +))
}

//: [Next](@next)
