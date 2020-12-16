//: [Previous](@previous)

let input = loadPuzzleInput()

enum Action: Character {
	case N = "N", S = "S", E = "E", W = "W"
	case L = "L", R = "R"
	case F = "F"
}

struct Ship {
	var x = 0
	var y = 0
	var heading = 0

	mutating func translate(x: Int = 0, y: Int = 0) {
		self.x += x
		self.y += y
	}
}

var ship = Ship()

do {
	for command in input {
		let action = Action(rawValue: command.first!)!
		let number = Int(command.dropFirst())!
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

	print("Part 1:", ship.x.magnitude + ship.y.magnitude)
}

//: [Next](@next)
