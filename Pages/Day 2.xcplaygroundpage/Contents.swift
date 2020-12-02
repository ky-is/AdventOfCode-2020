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
}

let policiesAndPasswords = getPuzzleInput()

let validPasswords = policiesAndPasswords.filter { passwordLine in
	let policyAndPassword = passwordLine.components(separatedBy: ": ")
	let policy = PasswordPolicy(fromString: policyAndPassword.first!)
	let password = policyAndPassword.last!
	let countOfValidationCharacter = Array(password).filter({ $0 == policy.letter }).count
	return policy.countRange.contains(countOfValidationCharacter)
}

print(validPasswords.count, "of", policiesAndPasswords.count, "valid")

//: [Next](@next)
