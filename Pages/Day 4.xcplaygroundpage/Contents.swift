//: [Previous](@previous)

let requiredFields = [
	"byr",
	"iyr",
	"eyr",
	"hgt",
	"hcl",
	"ecl",
	"pid",
//	"cid",
]

let passportFieldsEntries = getPuzzleInput(separatedBy: "\n\n")
	.map { $0.components(separatedBy: .whitespacesAndNewlines) }

func hasAllRequiredFields(passportFields: [String]) -> Bool {
	let missingFields = requiredFields.filter { requiredField in
		passportFields.first { $0.starts(with: requiredField) } == nil
	}
	if !missingFields.isEmpty {
		print(passportFields, missingFields)
	}
	return missingFields.isEmpty
}

let validPassports = passportFieldsEntries
	.filter(hasAllRequiredFields(passportFields:))
	.count
print(validPassports, "valid passports")

//: [Next](@next)
