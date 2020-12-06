//: [Previous](@previous)

let individualsAnswersByGroup = getPuzzleInput(separatedBy: "\n\n").map { $0.split(separator: "\n") }

let questionsAnsweredByAnyoneInGroupCount: [Int] = individualsAnswersByGroup.map { group in
	let uniqueAnswersForGroup = Set(group.flatMap { Array($0) })
	return uniqueAnswersForGroup.count
}
print("Part 1:", questionsAnsweredByAnyoneInGroupCount.reduce(0, +))

//: [Next](@next)
