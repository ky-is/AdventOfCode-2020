import Foundation

public struct Point {
	public static let zero = Self(x: 0, y: 0)

	public var x: Int, y: Int

	public init (x: Int, y: Int) {
		self.x = x
		self.y = y
	}

	public mutating func translate(by translation: Self) {
		x += translation.x
		y += translation.y
	}
}

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
