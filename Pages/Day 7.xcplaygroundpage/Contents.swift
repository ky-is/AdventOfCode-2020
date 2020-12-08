//: [Previous](@previous)

var bagParentsChildrenByName: [String: ParentsChildren] = [:]

typealias ParentsChildren = (parents: [String], children: [BagContained])

struct BagContained {
	let name: String
	let count: Int
}

func getBagsContaining(name: String) -> [String] {
	guard let parents = bagParentsChildrenByName[name]?.parents else {
		return []
	}
	return parents + parents.flatMap(getBagsContaining)
}

func getChildCount(of name: String) -> Int {
	guard let children = bagParentsChildrenByName[name]?.children else {
		return 0
	}
	let childBagCount = children
		.map(\.count)
		.reduce(0, +)
	let descendentsBagCount = children.reduce(0) { accumulator, child in
		accumulator + getChildCount(of: child.name) * child.count
	}
	return childBagCount + descendentsBagCount
}

//MARK: Run

loadPuzzleInput().forEach { line in
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
	print("Part 1:", bags.count)
}

do {
	let bagsCount = getChildCount(of: "shiny gold")
	print("Part 2:", bagsCount)
}

//: [Next](@next)
