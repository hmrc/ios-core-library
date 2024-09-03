/*
 * Copyright 2022 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

@testable import ios_core_library
import XCTest

class DateServiceTests: CoreUnitTestCase {

    var sut: MobileCore.Date.Service!

    override func setUp() {
        super.setUp()
        sut = .init()
    }

    func test_currentLocal_whenEnglish() {
        // When
        sut.shouldCurrentSceneDisplayWelshDates = false

        // Then
        XCTAssertEqual(sut.currentLocale.identifier, "en_GB")
    }

    func test_currentLocal_whenWelsh() {
        // When
        sut.shouldCurrentSceneDisplayWelshDates = true

        // Then
        XCTAssertEqual(sut.currentLocale.identifier, "cy")
    }

    func test_formattedDate_whenEnglish() {
        // Given
        sut.shouldCurrentSceneDisplayWelshDates = false
        let middayOn12thApril2017 = Date(timeIntervalSince1970: 1491998400)

        // When
        let string = sut.longDateFormatter.string(from: middayOn12thApril2017)

        // Then
        XCTAssertEqual(string, "12 April 2017")
    }

    func test_formattedDate_whenWelsh() {
        // Given
        sut.shouldCurrentSceneDisplayWelshDates = true
        let middayOn12thApril2017 = Date(timeIntervalSince1970: 1491998400)

        // When
        let string = sut.longDateFormatter.string(from: middayOn12thApril2017)

        // Then
        XCTAssertEqual(string, "12 Ebrill 2017")
    }
}
