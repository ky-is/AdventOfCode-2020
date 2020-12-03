import SwiftUI

public struct Input<Result: Equatable>: View {
	public let title: String
	public let placeholder: String
	public let formatter: Formatter?
	public let action: (Result) -> Void

	@State private var input: Result
	@State private var lastInput: Result?

	public init(title: String, placeholder: String, initialValue: Result, formatter: Formatter, action: @escaping (Result) -> Void) {
		self.title = title
		self.placeholder = placeholder
		self.action = action
		self._input = State(initialValue: initialValue)
		self.formatter = formatter
	}

	public init(title: String, placeholder: String = "String", initialValue: Result = "", action: @escaping (Result) -> Void) where Result == String {
		self.title = title
		self.placeholder = placeholder
		self.action = action
		self._input = State(initialValue: initialValue)
		if initialValue.isEmpty {
			self._lastInput = State(initialValue: initialValue)
		}
		self.formatter = nil
	}

	public init(title: String, placeholder: String = "Number", initialValue: Result, action: @escaping (Result) -> Void) where Result == Int {
		self.title = title
		self.placeholder = placeholder
		self.action = action
		self._input = State(initialValue: initialValue)
		self.formatter = NumberFormatter()
	}

	public var body: some View {
		Label {
			TextField(placeholder, value: $input, formatter: formatter ?? Formatter(), onCommit: {
				let value: Result
				if let text = input as? String {
					value = text.trimmingCharacters(in: .whitespacesAndNewlines) as! Result
				} else {
					value = input
				}
				guard value != lastInput else {
					return
				}
				action(value)
				lastInput = value
			})
		} icon: {
			Text("\(title):")
		}
			.frame(minWidth: 320)
	}
}
