import Foundation

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
public func ^^ (radix: Int, power: Int) -> Int {
	return Int(pow(Double(radix), Double(power)))
}

public extension StringProtocol {
	var integerRepresentation: Int? { Int(self) }
}

public extension Collection {
	subscript(safe index: Index) -> Element? {
		guard index >= startIndex, index < endIndex else {
			return nil
		}
		return self[index]
	}
}

public extension URLSession {
	func synchronousDataTask(with request: URLRequest) -> (Data?, URLResponse?, Error?) {
		var data: Data?
		var response: URLResponse?
		var error: Error?
		let semaphore = DispatchSemaphore(value: 0)
		let task = dataTask(with: request) {
			data = $0
			response = $1
			error = $2
			semaphore.signal()
		}
		task.resume()
		_ = semaphore.wait(timeout: .distantFuture)
		return (data, response, error)
	}
}
