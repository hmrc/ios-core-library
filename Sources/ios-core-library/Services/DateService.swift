//
//  Copyright 2019 HM Revenue & Customs
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

public protocol DateService {
    var britishLocale: Locale { get }
    var usPosixLocale: Locale { get }
    var britishTimeZone: TimeZone { get }
    var currentDate: Date { get }
    var utcTimeZone: String { get }
    var currentTimeZone: TimeZone { get }
    var dMMMMFormatter: Foundation.DateFormatter { get }
    var yyyyMMddFormatter: Foundation.DateFormatter { get }
    var longMonthYearFormatter: Foundation.DateFormatter { get }
    var longDateFormatter: Foundation.DateFormatter { get }
    var longDateBritishTimeZoneFormatter: Foundation.DateFormatter { get }
    var longDateUTCDateFormatter: Foundation.DateFormatter { get }
    var timeFormatter: Foundation.DateFormatter { get }
    var relativeDateFormatter: Foundation.DateFormatter { get }
    var isoDateFormatter: Foundation.DateFormatter { get }
    var rfc3339DateTimeFormatter: Foundation.DateFormatter { get }
    var rfc3339DateFormatter: Foundation.DateFormatter { get }
    var yearAndMonthDateFormatter: Foundation.DateFormatter { get }
    var longMonthAndYearDateFormatter: Foundation.DateFormatter { get }
    var longDayAndMonthDateFormatter: Foundation.DateFormatter { get }
    var yearDateFormatter: Foundation.DateFormatter { get }
    var forwardSlashDateFormatter: Foundation.DateFormatter { get }
    var httpHeaderDateFormatter: Foundation.DateFormatter { get }
    var jsonISO8601DateFormatter: Foundation.DateFormatter { get }
    func yyyyMMddDateToDate(_ dateString: String) -> Date
    func relativeReadableDate(_ date: Date) -> String
    func isoDate(_ yyyyMMddDate: String) -> Date
    func epochDate(milliseconds: Double) -> Date
    func httpHeaderDate(_ dateString: String) -> Date?
    func dateAtTimeFormat(date: Date) -> String
}

extension MobileCore.Date {
    open class Service: DateService {

        public init() {}

        open var britishLocale: Locale = Constants.BritishLocale

        open var usPosixLocale: Locale = Constants.USPosixLocale
        
        open var britishTimeZone: TimeZone = Constants.BritishTimeZone

        open var currentDate: Date {
            return Date()
        }

        open var utcTimeZone: String {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "xxx"
            return formatter.string(from: currentDate)
        }

        open var currentTimeZone: TimeZone {
            if UnitTests.areRunning, let gmtTimeZone = Constants.BritishTimeZone {
                return gmtTimeZone
            }
            return TimeZone.current
        }

        /// Date formatter with template: "d MMMM"
        open var dMMMMFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Constants.BritishLocale
            formatter.dateFormat = "d MMMM"
            formatter.timeZone = Constants.BritishTimeZone
            return formatter
        }

        /// Date formatter with template: "yyyy-MM-dd"
        open var yyyyMMddFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Constants.USPosixLocale
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            return formatter
        }

        /**
             Reusable date formatter which will take a date and format it using the
             template: "MMMM,yyyy". Examples: "July,2016", "December,2017"
         */
        open var longMonthYearFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.timeStyle = .none
            formatter.locale = Constants.BritishLocale
            formatter.dateFormat = "MMMM,yyyy"
            return formatter
        }

        /// Long-style date formatter (eg. "15 September 2015"), using current time zone
        open var longDateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            formatter.locale = Constants.BritishLocale
            formatter.timeZone = currentTimeZone
            return formatter
        }

        /// Long-style date formatter (eg. "15 September 2015"), using British time zone
        open var longDateBritishTimeZoneFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            formatter.locale = Constants.BritishLocale
            formatter.timeZone = Constants.BritishTimeZone
            return formatter
        }

        /// Long-style date formatter (eg. "15 September 2015"), using UTC time zone
        open var longDateUTCDateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .none
            formatter.locale = Constants.BritishLocale
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            return formatter
        }

        /// Time formatter with template: "hh:mma"
        open var timeFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.timeStyle = .none
            formatter.locale = Constants.BritishLocale
            formatter.dateFormat = "hh:mma"
            return formatter
        }

        /// Medium-style date formatter that returns relative dates (eg. "Today")
        open var relativeDateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.locale = Constants.BritishLocale
            formatter.timeZone = Constants.BritishTimeZone
            formatter.doesRelativeDateFormatting = true
            return formatter
        }

        /// Used by the Form Tracker, the JSON for which has dates of the form yyyyMMdd
        open var isoDateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.timeStyle = .none
            formatter.locale = Constants.USPosixLocale
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyyMMdd"
            return formatter
        }

        // RFC3339 date time handling/formatting, needed for Atom feed
        open var rfc3339DateTimeFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Constants.USPosixLocale
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            // "2016-05-20T15:08:51+01:00"
            formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssXXXXX"
            return formatter
        }

        // RFC3339 date handling/formatting, needed for help to save
        open var rfc3339DateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Constants.USPosixLocale
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            // "2016-05-20"
            formatter.dateFormat = "yyyy'-'MM'-'dd'"
            return formatter
        }

        // Year-month formatter
        open var yearAndMonthDateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Constants.USPosixLocale
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            // "2016-05"
            formatter.dateFormat = "yyyy'-'MM'"
            return formatter
        }

        // Long month and year formatter
        open var longMonthAndYearDateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Constants.USPosixLocale
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            // "January 2018"
            formatter.dateFormat = "MMMM yyyy"
            return formatter
        }

        // Long month formatter
        open var longDayAndMonthDateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Constants.USPosixLocale
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            // "January 2018"
            formatter.dateFormat = "dd MMMM"
            return formatter
        }

        // Year only formatter
        open var yearDateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Constants.BritishLocale
            formatter.dateFormat = "yyyy"
            return formatter
        }

        // Slash date converter
        open var forwardSlashDateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Constants.BritishLocale
            formatter.dateFormat = "d/MM/yyyy"
            return formatter
        }

        // HTTP header formatter
        open var httpHeaderDateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Constants.BritishLocale
            formatter.dateFormat = "E, dd MMM yyyy HH:mm:ssZ"
            return formatter
        }

        // Common JSON ISO 8601 formatter
        open var jsonISO8601DateFormatter: Foundation.DateFormatter {
            let formatter = Foundation.DateFormatter()
            formatter.locale = Constants.USPosixLocale
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            // "2017-09-12T08:35:49.345Z"
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            return formatter
        }

        /**
             Convert a date of the form "yyyy-MM-DD" to an Date
         */
        open func yyyyMMddDateToDate(_ dateString: String) -> Date {
            let yyyyMMddDateFormatter = yyyyMMddFormatter
            if let date = yyyyMMddDateFormatter.date(from: dateString) {
                return date
            } else {
                return Date(timeIntervalSince1970: 0.0)
            }
        }

        /**
             Convert a date such as "2016-05-03" to the form "Today", or
             "Saturday", or "4 Jun 2016"
         */
        open func relativeReadableDate(_ date: Date) -> String {
            let dateFormatter = relativeDateFormatter
            return dateFormatter.string(from: date)
        }

        /**
            Form Tracker date format - convert yyyyMMdd to an Date, e.g. convert
            "20160116" to "1 January 2016".  This date format is used by the Form
            Tracking JSON.
         */
        open func isoDate(_ yyyyMMddDate: String) -> Date {
            let dateFormatter = isoDateFormatter
            if let date = dateFormatter.date(from: yyyyMMddDate) {
                return date
            } else {
                return Date(timeIntervalSince1970: 0.0)
            }
        }

        /**
            Convert a datestamp such as 1499209200000 to a Date
         */
        open func epochDate(milliseconds: Double) -> Date {
            let seconds = milliseconds / 1000
            return Date(timeIntervalSince1970: TimeInterval(seconds))
        }

        /**
         HTTP header date format - convert E, dd MMM yyyy HH:mm:ssZ to a Date,
         e.g. convert "Wed, 02 Aug 2017 10:22:22 GMT"
         */
        open func httpHeaderDate(_ dateString: String) -> Date? {
            let dateFormatter = httpHeaderDateFormatter
            return dateFormatter.date(from: dateString)
        }

        // 21 June 2020 at 2:37pm
        open func dateAtTimeFormat(date: Date) -> String {
            "\(longDateBritishTimeZoneFormatter.string(from: date)) at \(timeFormatter.string(from: date))"
        }

        private struct Constants {
            static let BritishLocale = Locale(identifier: "en_GB")
            static let USPosixLocale = Locale(identifier: "en_US_POSIX")
            static let BritishTimeZone = TimeZone(identifier: "BST")
        }
    }
}
