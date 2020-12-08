//: [Previous](@previous)

let individualsAnswersByGroup = loadPuzzleInput(separatedBy: "\n\n").map { $0.split(separator: "\n") }

do {
	let questionsAnsweredByAnyoneInGroupCount: [Int] = individualsAnswersByGroup.map { group in
		let uniqueAnswersForGroup = Set(group.flatMap { Array($0) })
		return uniqueAnswersForGroup.count
	}
	print("Part 1:", questionsAnsweredByAnyoneInGroupCount.reduce(0, +))
}

do {
	let questionsAnsweredByEveryoneInGroupCounts: [Int] = individualsAnswersByGroup.map { group in
		var groupRemaining = group
		let firstPersonAnswers = groupRemaining.removeFirst()
		return Array(firstPersonAnswers)
			.filter { answer in groupRemaining.first { !$0.contains(answer) } == nil }
			.count
	}
	print("Part 2:", questionsAnsweredByEveryoneInGroupCounts.reduce(0, +))
}

//: [Next](@next)
