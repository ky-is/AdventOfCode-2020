//: [Previous](@previous)

let individualsAnswersByGroup = getPuzzleInput(separatedBy: "\n\n").map { $0.split(separator: "\n") }

//MARK: Run

do {
	let questionsAnsweredByAnyoneInGroupCount: [Int] = individualsAnswersByGroup.map { group in
		let uniqueAnswersForGroup = Set(group.flatMap { Array($0) })
		return uniqueAnswersForGroup.count
	}
	print("Part 1:", questionsAnsweredByAnyoneInGroupCount.reduce(0, +))
}

do {
	let questionsAnsweredByEveryoneInGroupCount: [Int] = individualsAnswersByGroup.map { group in
		var groupRemaining = group
		let firstPersonAnswers = groupRemaining.removeFirst()
		var answersForAllInGroup = Array(firstPersonAnswers)
		groupRemaining.forEach { individualAnswers in
			answersForAllInGroup.removeAll { !individualAnswers.contains($0) }
		}
		return answersForAllInGroup.count
	}
	print("Part 2:", questionsAnsweredByEveryoneInGroupCount.reduce(0, +))
}

//: [Next](@next)
