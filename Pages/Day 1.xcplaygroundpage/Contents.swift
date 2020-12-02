//: [Previous](@previous)

let goal = 2020

import PlaygroundSupport

func multiplyNumbersAddingTo(goal: Int, numberCount: Int, entries: [Int]) -> Int {
	let firstEntry = entries.first!
	let entryCount = entries.count
	var indexesToGoal = Array(repeating: 0, count: numberCount)
	var testingEntriesToGoal = Array(repeating: firstEntry, count: numberCount)
	for _ in 0..<(entryCount ^^ numberCount) {
		for (columnIndex, columnAtIndex) in indexesToGoal.enumerated().reversed() {
			if columnAtIndex < entryCount - 1 {
				indexesToGoal[columnIndex] += 1
				testingEntriesToGoal[columnIndex] = entries[indexesToGoal[columnIndex]]
				break
			}
			indexesToGoal[columnIndex] = 0
			testingEntriesToGoal[columnIndex] = firstEntry
		}
		if testingEntriesToGoal.reduce(0, +) == goal {
			return testingEntriesToGoal.reduce(1, *)
		}
	}
	fatalError("No \(numberCount) numbers add to \(goal) in \(entryCount) entries.")
}

PlaygroundPage.current.setLiveView(
	TextInput(title: "Numbers to sum to 2020", placeholder: "Number") { numberText in
		guard let number = Int(numberText) else {
			return print("Please input a valid integer")
		}
		let answer = multiplyNumbersAddingTo(goal: goal, numberCount: number, entries: getPuzzleInput().compactMap(\.integerRepresentation))
		print(answer)
	}
)

//: [Next](@next)
