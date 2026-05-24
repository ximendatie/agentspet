import Foundation

enum Formatters {
    static func tokens(_ value: Int) -> String {
        if value >= 1_000 {
            let abbreviated = Double(value) / 1_000
            return String(format: "%.1fk", abbreviated)
        }

        return "\(value)"
    }
}

