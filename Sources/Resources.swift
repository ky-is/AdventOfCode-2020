import Foundation

private func format(string: String) -> [String] {
	return string.components(separatedBy: .newlines).dropLast()
}

public func getPuzzleInput(forFilename filename: String = #filePath) -> [String] {
	let dayName = String(filename.split(separator: ".")[0])
	if let resourcePath = Bundle.main.path(forResource: dayName, ofType: "txt"), let localFile = try? String(contentsOfFile: resourcePath) {
		return format(string: localFile)
	}
	let dayNumber = dayName.split(separator: " ").last!
	var request = URLRequest(url: URL(string: "https://adventofcode.com/2020/day/\(dayNumber)/input")!)
	request.setValue("session=\(sessionToken)", forHTTPHeaderField: "Cookie")
	request.httpShouldHandleCookies = true
	let (data, _, error) = URLSession.shared.synchronousDataTask(with: request)
	if let error = error {
		fatalError(error.localizedDescription)
	}
	return format(string: String(data: data!, encoding: .utf8)!)
}
