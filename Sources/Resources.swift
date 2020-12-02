import Foundation

public func getPuzzleInput(forFilename filename: String = #filePath) -> [String] {
	let resourcePath = Bundle.main.path(forResource: String(filename.split(separator: ".")[0]), ofType: "txt")!
	return try! String(contentsOfFile: resourcePath).components(separatedBy: .newlines).dropLast()
}
