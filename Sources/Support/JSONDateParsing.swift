import Foundation

func parseDate(_ value: String?) -> Date? {
    guard let value else {
        return nil
    }

    let fractionalFormatter = ISO8601DateFormatter()
    fractionalFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    if let date = fractionalFormatter.date(from: value) {
        return date
    }

    let internetFormatter = ISO8601DateFormatter()
    internetFormatter.formatOptions = [.withInternetDateTime]
    return internetFormatter.date(from: value)
}

extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}

extension String.SubSequence {
    var nilIfEmpty: String? {
        isEmpty ? nil : String(self)
    }
}
