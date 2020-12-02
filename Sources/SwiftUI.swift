import SwiftUI

private var lastInput = ""

public struct TextInput: View {
	public let title: String
	public let placeholder: String
	public let action: (String) -> Void

	public init(title: String, placeholder: String, action: @escaping (String) -> Void) {
		self.title = title
		self.placeholder = placeholder
		self.action = action
	}

	@State private var input = ""

	public var body: some View {
		Label {
			TextField(placeholder, text: $input, onCommit: {
				let text = input.trimmingCharacters(in: .whitespacesAndNewlines)
				guard text != lastInput else {
					return
				}
				lastInput = text
				action(text)
			})
		} icon: {
			Text("\(title):")
		}
			.frame(minWidth: 320)
			.padding(.vertical)
	}
}
