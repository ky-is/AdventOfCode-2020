//: [Previous](@previous)

private func validateLength(_ value: String, length: Int) -> Bool {
	return value.count == length
}

private func validateNumber(_ value: Int, min: Int, max: Int) -> Bool {
	return value >= min && value <= max
}

private func validateLength(_ value: String, min: Int, max: Int) -> Bool {
	return validateNumber(value.count, min: min, max: max)
}

private func validateYear(_ value: String, min: Int, max: Int) -> Bool {
	guard validateLength(value, length: 4) else { return false }
	guard let year = Int(value) else { return false }
	return validateNumber(year, min: min, max: max)
}

private enum EyeColor: String {
	case amb, blu, brn, gry, grn, hzl, oth
}

private enum RequiredField: String, CaseIterable {
	case byr, iyr, eyr, hgt, hcl, ecl, pid //, cid

	func validate(_ value: String) -> Bool {
		switch self {
		case .byr:
			return validateYear(value, min: 1920, max: 2002)
		case .iyr:
			return validateYear(value, min: 2010, max: 2020)
		case .eyr:
			return validateYear(value, min: 2020, max: 2030)
		case .hgt:
			guard validateLength(value, min: 4, max: 5) else { return false }
			guard let number = Int(value.prefix(value.count - 2)) else { return false }
			let min, max: Int
			switch value.suffix(2) {
			case "cm":
				min = 150
				max = 193
			case "in":
				min = 59
				max = 76
			default:
				return false
			}
			return validateNumber(number, min: min, max: max)
		case .hcl:
			return validateLength(value, length: 7)
		case .ecl:
			return EyeColor(rawValue: value) != nil
		case .pid:
			return validateLength(value, length: 9) && Int(value) != nil
		}
	}
}

typealias PassportField = (key: String, value: String)

private func hasField(requiredField: RequiredField, passportFields: [PassportField]) -> Bool {
	return passportFields.first { $0.key == requiredField.rawValue } != nil
}

private func hasValidField(requiredField: RequiredField, passportFields: [PassportField]) -> Bool {
	guard let passportField = passportFields.first(where: { $0.key == requiredField.rawValue }) else { return false }
	return requiredField.validate(passportField.value)
}

private func hasAllRequiredFields(passportFields: [PassportField]) -> Bool {
	return RequiredField.allCases.first { !hasField(requiredField: $0, passportFields: passportFields) } == nil
}

private func hasAllRequiredValidFields(passportFields: [PassportField]) -> Bool {
	return RequiredField.allCases.first { !hasValidField(requiredField: $0, passportFields: passportFields) } == nil
}

// Run

let passportFieldsEntries: [[PassportField]] = getPuzzleInput(separatedBy: "\n\n")
	.map { passportLine in
		return passportLine
			.components(separatedBy: .whitespacesAndNewlines)
			.compactMap { passportFieldString in
				let keyValue = passportFieldString.split(separator: ":")
				guard keyValue.count == 2 else { return nil }
				return PassportField(key: String(keyValue[0]), value: String(keyValue[1]))
			}
	}

let validPassportsPart1 = passportFieldsEntries
	.filter(hasAllRequiredFields)
	.count
print("Part 1:", validPassportsPart1, "valid passports")

let validPassportsPart2 = passportFieldsEntries
	.filter(hasAllRequiredValidFields)
	.count
print("Part 2:", validPassportsPart2, "valid passports")

//: [Next](@next)
