//: [Previous](@previous)

struct Instruction {
	var command: String
	let number: Int

	init(raw: String) {
		let split = raw.split(separator: " ")
		command = String(split.first!)
		number = Int(split.last!)!
	}
}

func accumulate(instructions: [Instruction]) -> (Int, Int) {
	var accumulator = 0
	var currentIndex = 0
	var visitedIndices: [Int] = []
	while currentIndex < instructions.count && !visitedIndices.contains(currentIndex) {
		visitedIndices.append(currentIndex)
		let instruction = instructions[currentIndex]
		switch instruction.command {
		case "nop":
			break
		case "acc":
			accumulator += instruction.number
		case "jmp":
			currentIndex += instruction.number
			continue
		default:
			fatalError(instruction.command)
		}
		currentIndex += 1
	}
	return (currentIndex, accumulator)
}

//MARK: Run

let instructions = loadPuzzleInput().map { Instruction(raw: $0) }

do {
	let (_, accumulator) = accumulate(instructions: instructions)
	print("Part 1:", accumulator)
}

do {
	var currentIndex = 0
	var accumulator = 0
	var modifyInstructionIndex = 0
	while currentIndex < instructions.count {
		var tempInstructions = instructions
		for index in modifyInstructionIndex..<tempInstructions.count {
			modifyInstructionIndex += 1
			let command = tempInstructions[index].command
			if command == "nop" {
				tempInstructions[index].command = "jmp"
				break
			}
			if command == "jmp" {
				tempInstructions[index].command = "nop"
				break
			}
		}
		(currentIndex, accumulator) = accumulate(instructions: tempInstructions)

	}
	print("Part 2:", accumulator)
}

//: [Next](@next)
