//: [Previous](@previous)

import Foundation

let input = loadPuzzleInput(separatedBy: "\n\n")
	.map { $0.components(separatedBy: .newlines) }

let validators = input[0]
	.map { $0.components(separatedBy: ": ").last! }
	.flatMap { $0.components(separatedBy: " or ") }
	.map { $0.split(separator: "-") }
	.map { ClosedRange(uncheckedBounds: (Int($0[0])!, Int($0[1])!)) }

do {
	let invalidFields = input.last!
		.dropFirst()
		.map { $0.split(separator: ",") }
		.compactMap { ticketFields -> [Int]? in
			let invalidFields = ticketFields
				.compactMap(\.integerRepresentation)
				.filter { field in
//					return true
					validators.first { $0.contains(field) } == nil
				}
			return invalidFields.isEmpty ? nil : invalidFields
		}
		.flatMap { $0 }
	print("Part 1:", invalidFields.reduce(0, +))
}

//: [Next](@next)
