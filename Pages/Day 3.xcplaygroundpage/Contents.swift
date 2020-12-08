//: [Previous](@previous)

import PlaygroundSupport
import SwiftUI

let inputMap = Array(getRawPuzzleInput())
let mapWidth = inputMap.firstIndex(of: "\n")!

final class SlopeViewModel: ObservableObject {
	@Published var slope: Point
	@Published var mapDisplay: [String] = []
	@Published var treeCollisions = 0
	@Published var currentPosition: Point = .zero
	@Published var animated = false

	private let openSquare: Character = "."
	private let treeSquare: Character = "#"
	private let markedOpenSquare = "O"
	private let markedTreeSquare = "X"

	init(slope: Point) {
		self.slope = slope
		reset()
	}

	private func reset() {
		mapDisplay = inputMap.map { String($0) }
		treeCollisions = 0
		currentPosition = .zero
	}

	func display() {
		reset()
		markAndMoveDisplayLoop()
	}

	func calculate() -> Int {
		if let trees = markAndMoveStep() {
			return trees
		}
		return calculate()
	}

	private func markAndMoveDisplayLoop() {
		if animated {
			DispatchQueue.main.async(execute: _markAndMoveDisplayLoop)
		} else {
			_markAndMoveDisplayLoop()
		}
	}
	private func _markAndMoveDisplayLoop() {
		if let trees = markAndMoveStep() {
			return print("Hit", trees, "trees")
		}
		markAndMoveDisplayLoop()
	}

	private func markAndMoveStep() -> Int? {
		let index = (currentPosition.x % mapWidth) + currentPosition.y * (mapWidth + 1)
		guard let visitingSquare = inputMap[safe: index] else {
			return treeCollisions
		}
		switch visitingSquare {
		case openSquare:
			mapDisplay[index] = markedOpenSquare
		case treeSquare:
			mapDisplay[index] = markedTreeSquare
			treeCollisions += 1
		default:
			fatalError("Unknown map square \(visitingSquare)")
		}
		currentPosition.translate(by: slope)
		return nil
	}
}

//MARK: Live

struct Slope: View {
	@StateObject private var viewModel = SlopeViewModel(slope: Point(x: 3, y: 1))

	var body: some View {
		VStack {
			Input(title: "Slope X", initialValue: viewModel.slope.x) { number in
				viewModel.slope.x = number
			}
			Input(title: "Slope Y", initialValue: viewModel.slope.y) { number in
				viewModel.slope.y = number
			}
			HStack {
				Toggle("Animated", isOn: $viewModel.animated)
				Button("Go") {
					viewModel.display()
				}
					.disabled(viewModel.slope.x <= 0 || viewModel.slope.y <= 0)
				if viewModel.treeCollisions > 0 {
					Text("\(viewModel.treeCollisions) trees")
				}
			}
		}
		Text(viewModel.mapDisplay.joined(separator: ""))
			.font(.system(.body, design: .monospaced))
	}
}

PlaygroundPage.current.setLiveView(
	Slope()
		.padding(.vertical)
)

//MARK: Run

do {
	let slope = SlopeViewModel(slope: Point(x: 3, y: 1))
	print("Part 1:", slope.calculate())
}

do {
	let combinedSlopes = [
		Point(x: 1, y: 1),
		Point(x: 3, y: 1),
		Point(x: 5, y: 1),
		Point(x: 7, y: 1),
		Point(x: 1, y: 2),
	]
		.map { SlopeViewModel(slope: $0).calculate() }
	print("Part 2:", combinedSlopes.reduce(1, *))
}

//: [Next](@next)
