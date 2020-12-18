//: [Previous](@previous)

let nauticalActions = loadPuzzleInput()
	.map(parse)

enum Action: Character {
	case N = "N", S = "S", E = "E", W = "W"
	case L = "L", R = "R"
	case F = "F"
}

struct NauticalUnit {
	var position: Point
	var heading = 0

	mutating func translate(x: Int = 0, y: Int = 0) {
		self.position.translate(by: Point(x: x, y: y))
	}

	func distance(to unit: NauticalUnit) -> Point {
		return Point(x: position.x - unit.position.x, y: position.y - unit.position.y)
	}

	init(x: Int, y: Int) {
		position = Point(x: x, y: y)
	}

	mutating func rotate(around centerUnit: NauticalUnit, by degrees: Int, clockwise: Bool) {
		var distanceVector = distance(to: centerUnit)
		var rotateDistance = distanceVector
		if !clockwise {
			rotateDistance.multiply(by: -1)
		}
		position = centerUnit.position
		let rotation: Point
		switch degrees {
		case 90:
			rotation = Point(x: rotateDistance.y, y: -rotateDistance.x)
		case 180:
			distanceVector.multiply(by: -1)
			rotation = distanceVector
		case 270:
			rotation = Point(x: -rotateDistance.y, y: rotateDistance.x)
		default:
			fatalError("Unknown degrees \(degrees)")
		}
		position.translate(by: rotation)
	}
}

func parse(command: String) -> (action: Action, number: Int) {
	let action = Action(rawValue: command.first!)!
	let number = Int(command.dropFirst())!
	return (action, number)
}

do {
	var ship = NauticalUnit(x: 0, y: 0)
	for (action, number) in nauticalActions {
		switch action {
		case .N:
			ship.translate(y: number)
		case .S:
			ship.translate(y: -number)
		case .E:
			ship.translate(x: number)
		case .W:
			ship.translate(x: -number)
		case .L:
			ship.heading += number
		case .R:
			ship.heading -= number
		case .F:
			let degrees = ship.heading % 360
			switch degrees {
			case 0:
				ship.translate(x: number)
			case 90, -270:
				ship.translate(y: number)
			case 180, -180:
				ship.translate(x: -number)
			case 270, -90:
				ship.translate(y: -number)
			default:
				fatalError("Unknown degrees \(degrees)")
			}
		}
	}
	print("Part 1:", ship.position.manhattanDistance)
}

do {
	var ship = NauticalUnit(x: 0, y: 0)
	var waypoint = NauticalUnit(x: 10, y: 1)
	for (action, number) in nauticalActions {
		switch action {
		case .N:
			waypoint.translate(y: number)
		case .S:
			waypoint.translate(y: -number)
		case .E:
			waypoint.translate(x: number)
		case .W:
			waypoint.translate(x: -number)
		case .L:
			waypoint.rotate(around: ship, by: number, clockwise: false)
		case .R:
			waypoint.rotate(around: ship, by: number, clockwise: true)
		case .F:
			var vector = waypoint.distance(to: ship)
			vector.multiply(by: number)
			ship.position.translate(by: vector)
			waypoint.position.translate(by: vector)
		}
	}
	print("Part 2:", ship.position.manhattanDistance)
}

//: [Next](@next)
