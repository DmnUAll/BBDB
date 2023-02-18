import Foundation

extension DateFormatter {

    static let dateTimeDefaultFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY hh:mm"
        return dateFormatter
    }()

    static let dateDayDefaultFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY"
        return dateFormatter
    }()
}

extension Date {
    var dateTimeString: String { DateFormatter.dateTimeDefaultFormatter.string(from: self) }
    var dateDayString: String { DateFormatter.dateDayDefaultFormatter.string(from: self) }
}
