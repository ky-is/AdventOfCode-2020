//: [Previous](@previous)

var bagContainerNames: [String: [String]] = [:]

getPuzzleInput().forEach { line in
	let split = line.components(separatedBy: " contain ")
	let parent = split.first!.split(separator: " ").dropLast().joined(separator: " ")
	let children = split.last!.components(separatedBy: ", ")
	children.forEach { numberAndNameLine in
		var numberAndName = numberAndNameLine.split(separator: " ")
		guard let _ = Int(numberAndName.removeFirst()) else {
			return
		}
		let name = numberAndName.dropLast().joined(separator: " ")
		if bagContainerNames[name] == nil {
			bagContainerNames[name] = []
		}
		bagContainerNames[name]!.append(parent)
	}
}

func getBagsContaining(name: String) -> [String] {
	guard let containing = bagContainerNames[name] else {
		return []
	}
	return containing + containing.flatMap(getBagsContaining)
}

do {
	let bags = Set(getBagsContaining(name: "shiny gold"))
	print("Part 1:", bags.count, bags)
}

//: [Next](@next)
