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

import Foundation

public protocol LocalisationService {
    var shouldShowLanguageSwitcher: Bool { get set }
    var shouldShowContentInWelsh: Bool { get set }
    func string(_ key: String) -> String
    func string(_ key: String, language: MobileCore.Localisation.Language) -> String
}

extension MobileCore.Localisation {
    public enum Language: String {
        case english = "English"
        case welsh = "Welsh"
    }

    public enum Notifications: String {
        case shouldShowLanguageSwitcher
        case shouldShowContentInWelsh

        public func callAsFunction() -> Notification.Name {
            .init(self.rawValue)
        }
    }

    open class Service: LocalisationService, CoreConfigCacheInjected {
        private enum Keys: String {
            case shouldShowLanguageSwitcher = "shouldShowLanguageSwitcher"
            case shouldShowContentInWelsh = "shouldShowContentInWelsh"
            func callAsFunction() -> String {
                rawValue
            }
        }
        open var shouldShowLanguageSwitcher: Bool {
            get {
                coreConfigCache.object(forKey: Keys.shouldShowLanguageSwitcher()) as? Bool ?? false
            }
            set {
                coreConfigCache.setObject(newValue, forKey: Keys.shouldShowLanguageSwitcher())
                NotificationCenter.default.post(
                    name: MobileCore.Localisation.Notifications.shouldShowLanguageSwitcher(),
                    object: nil
                )

                // Turn off Welsh when language switcher disabled
                if !newValue && shouldShowContentInWelsh {
                    shouldShowContentInWelsh = false
                }
            }
        }
        open var shouldShowContentInWelsh: Bool {
            get {
                coreConfigCache.object(forKey: Keys.shouldShowContentInWelsh()) as? Bool ?? false
            }
            set {
                coreConfigCache.setObject(newValue, forKey: Keys.shouldShowContentInWelsh())
                NotificationCenter.default.post(
                    name: MobileCore.Localisation.Notifications.shouldShowContentInWelsh(),
                    object: nil
                )

                // Turn on language switcher when Welsh enabled
                if newValue && !shouldShowLanguageSwitcher {
                    shouldShowLanguageSwitcher = true
                }
            }
        }
        public init() {

        }
        open func string(_ key: String) -> String {
            return string(key, language: shouldShowContentInWelsh ? .welsh : .english)
        }
        open func string(_ key: String, language: MobileCore.Localisation.Language) -> String {
            return NSLocalizedString(
                key,
                tableName: language.rawValue,
                bundle: Bundle.main,
                comment: ""
            )
        }
    }
}
