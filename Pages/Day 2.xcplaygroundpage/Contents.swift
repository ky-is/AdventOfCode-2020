//: [Previous](@previous)

struct PasswordPolicy {
	let letter: Character
	let countRange: ClosedRange<Int>

	init(fromString policy: String) {
		let rangeAndCharacter = policy.split(separator: " ")
		let range = rangeAndCharacter.first!.split(separator: "-")
		let characterString = rangeAndCharacter.last!
		letter = characterString.first!
		countRange = ClosedRange(uncheckedBounds: (range.first!.integerRepresentation!, range.last!.integerRepresentation!))
	}

	var arrayOfBoundsIndicies: [Int] {
		return [countRange.lowerBound - 1, countRange.upperBound - 1]
	}
}

//MARK: Run

let policiesAndPasswords: [(PasswordPolicy, String)] = getPuzzleInput().map {
	let policyAndPassword = $0.components(separatedBy: ": ")
	let policy = PasswordPolicy(fromString: policyAndPassword.first!)
	let password = policyAndPassword.last!
	return (policy, password)
}

do {
	let validPasswords = policiesAndPasswords.filter { (policy, password) in
		let countOfValidationCharacter = Array(password)
			.filter { $0 == policy.letter }
			.count
		return policy.countRange.contains(countOfValidationCharacter)
	}
	print("Part 1:", validPasswords.count, "of", policiesAndPasswords.count, "valid")
}

do {
	let validPasswords = policiesAndPasswords.filter { (policy, password) in
		let passwordCharacters = Array(password)
		let countOfMatchingCharactersAtBoundsIndicies = policy.arrayOfBoundsIndicies.filter { passwordCharacters[safe: $0] == policy.letter }
		return countOfMatchingCharactersAtBoundsIndicies.count == 1
	}
	print("Part 2:", validPasswords.count, "of", policiesAndPasswords.count, "valid")
}

//: [Next](@next)
