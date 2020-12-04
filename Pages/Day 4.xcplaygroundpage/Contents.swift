//: [Previous](@previous)

enum RequiredField: String, CaseIterable {
	case byr, iyr, eyr, hgt, hcl, ecl, pid //, cid
}

func hasField(requiredField: RequiredField, passportFields: [String]) -> Bool {
	return passportFields.first { $0.starts(with: requiredField.rawValue) } != nil
}

func hasAllRequiredFields(passportFields: [String]) -> Bool {
	return RequiredField.allCases.first { !hasField(requiredField: $0, passportFields: passportFields) } == nil
}

let passportFieldsEntries = getPuzzleInput(separatedBy: "\n\n")
	.map { $0.components(separatedBy: .whitespacesAndNewlines) }

let validPassports = passportFieldsEntries
	.filter(hasAllRequiredFields(passportFields:))
	.count
print(validPassports, "valid passports")

//: [Next](@next)
