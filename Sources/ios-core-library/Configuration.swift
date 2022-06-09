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

extension MobileCore {
    public class Configuration {

        public var hashedUserIdentifier: String?

        public struct AppConfig {
            public let appKeychain: KeychainAccess

            public init(appKeychainID: String) {
                appKeychain = KeychainAccess(account: appKeychainID)
            }
        }

        open class UnitTests {
            public let areRunning: Bool
            public init(areRunning: Bool) {
                self.areRunning = areRunning
            }
        }

        open class UITests {
            public let areRunning: Bool
            public let useRealIDs: Bool

            public init(areRunning: Bool, useRealIDs: Bool = false) {
                self.areRunning = areRunning
                self.useRealIDs = useRealIDs
            }
        }

        public var unitTests: UnitTests
        public var uiTests: UITests
        public var appConfig: AppConfig

        public init(appConfig: AppConfig) {
            unitTests = UnitTests(areRunning: false)
            uiTests = UITests(areRunning: false)
            self.appConfig = appConfig
            Injection.initialise()
        }
    }
}
