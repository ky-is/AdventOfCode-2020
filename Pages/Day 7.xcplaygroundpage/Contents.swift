//: [Previous](@previous)

var bagParentsChildrenByName: [String: ParentsChildren] = [:]

typealias ParentsChildren = (parents: [String], children: [BagContained])

struct BagContained {
	let name: String
	let count: Int
}

func getBagsContaining(name: String) -> [String] {
	guard let parentsChildren = bagParentsChildrenByName[name] else {
		return []
	}
	let parents = parentsChildren.parents
	return parents + parents.flatMap(getBagsContaining)
}

getPuzzleInput().forEach { line in
	let split = line.components(separatedBy: " contain ")
	let parent = split.first!.split(separator: " ").dropLast().joined(separator: " ")
	let children = split.last!.components(separatedBy: ", ")
	if bagParentsChildrenByName[parent] == nil {
		bagParentsChildrenByName[parent] = (parents: [], children: [])
	}
	children.forEach { numberAndNameLine in
		var numberAndName = numberAndNameLine.split(separator: " ")
		guard let count = Int(numberAndName.removeFirst()) else {
			return
		}
		let child = numberAndName.dropLast().joined(separator: " ")
		if bagParentsChildrenByName[child] == nil {
			bagParentsChildrenByName[child] = (parents: [], children: [])
		}
		bagParentsChildrenByName[child]!.parents.append(parent)
		bagParentsChildrenByName[parent]!.children.append(BagContained(name: child, count: count))
	}
}

do {
	let bags = Set(getBagsContaining(name: "shiny gold"))
	print("Part 1:", bags.count, bags)
}

//: [Next](@next)
