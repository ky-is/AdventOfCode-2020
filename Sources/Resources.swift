import Foundation

private func normalize(string: String) -> String {
	return string.trimmingCharacters(in: .whitespacesAndNewlines)
}

public func getRawPuzzleInput(forFilename filename: String = #filePath) -> String {
	let dayName = String(filename.split(separator: ".")[0])
	if let resourcePath = Bundle.main.path(forResource: dayName, ofType: "txt"), let localFile = try? String(contentsOfFile: resourcePath) {
		return normalize(string: localFile)
	}
	let dayNumber = dayName.split(separator: " ").last!
	var request = URLRequest(url: URL(string: "https://adventofcode.com/2020/day/\(dayNumber)/input")!)
	request.setValue("session=\(sessionToken)", forHTTPHeaderField: "Cookie")
	request.httpShouldHandleCookies = true
	let (data, _, error) = URLSession.shared.synchronousDataTask(with: request)
	if let error = error {
		fatalError(error.localizedDescription)
	}
	return normalize(string: String(data: data!, encoding: .utf8)!)
}

public func getPuzzleInput(forFilename filename: String = #filePath, separatedBy separator: String = "\n") -> [String] {
	return getRawPuzzleInput(forFilename: filename).components(separatedBy: separator)
}
