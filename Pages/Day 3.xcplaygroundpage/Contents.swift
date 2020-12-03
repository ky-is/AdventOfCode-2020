//: [Previous](@previous)

import PlaygroundSupport
import SwiftUI

let inputMap = Array(getPuzzleInput().joined(separator: "\n"))
let mapWidth = inputMap.firstIndex(of: "\n")!

struct Slope: View {
	@State private var slope = Point(x: 3, y: 1)
	@State private var mapDisplay = inputMap.map { String($0) }
	@State private var currentPosition: Point = .zero
	@State private var treeCollisions = 0
	@State private var animated = false

	private let openSquare: Character = "."
	private let treeSquare: Character = "#"
	private let markedOpenSquare = "O"
	private let markedTreeSquare = "X"

	private func markAndMoveAnimated() {
		if animated {
			DispatchQueue.main.async(execute: _markAndMove)
		} else {
			_markAndMove()
		}
	}

	private func _markAndMove() {
		let index = (currentPosition.x % (mapWidth)) + currentPosition.y * (mapWidth + 1)
		guard let visitingSquare = inputMap[safe: index] else {
			return print("Hit", treeCollisions, "trees")
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
		markAndMoveAnimated()
	}

	var body: some View {
		VStack {
			Input<Int>(title: "Slope X", initialValue: slope.x) { number in
				slope.x = number
			}
			Input<Int>(title: "Slope Y", initialValue: slope.y) { number in
				slope.y = number
			}
			HStack {
				Toggle("Animated", isOn: $animated)
				Button("Go") {
					markAndMoveAnimated()
				}
					.disabled(slope.x <= 0 || slope.y <= 0)
			}
		}
		Text(mapDisplay.joined(separator: ""))
			.font(.system(.body, design: .monospaced))
	}
}

PlaygroundPage.current.setLiveView(
	Slope()
		.padding(.vertical)
)

//: [Next](@next)
