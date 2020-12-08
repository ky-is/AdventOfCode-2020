//: [Previous](@previous)

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

//MARK: Live

let goal = 2020

PlaygroundPage.current.setLiveView(
	Input(title: "Numbers to sum to \(goal)", initialValue: 2) { number in
		if number < 2 || number > 5 {
			return print("Number must be between 2 and 5")
		}
		let answer = multiplyNumbersAddingTo(goal: goal, numberCount: number, entries: loadPuzzleInput().compactMap(\.integerRepresentation))
		print(answer)
	}
		.padding(.vertical)
)

//: [Next](@next)
