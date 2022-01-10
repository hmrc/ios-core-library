/*
 * Copyright 2021 HM Revenue & Customs
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

public struct StoragePath {
    public static var permanent: String {
        /*
         See: https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW1

         Use "Application Support" directory to store all app data files except those associated with the user’s documents.

         All content in "Application Support" directory should be placed in a custom subdirectory whose name is that of
         your app’s bundle identifier or your company.
         */
        let applicationSupportDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        let dataStorePath = applicationSupportDirectory.appendingPathComponent(Bundle.main.bundleIdentifier!)
        var isDirectory = ObjCBool(true)
        if !FileManager.default.fileExists(atPath: dataStorePath.path, isDirectory: &isDirectory) {
            // swiftlint:disable:next force_try
            try! FileManager.default.createDirectory(atPath: dataStorePath.path, withIntermediateDirectories: true, attributes: nil)
        }
        return dataStorePath.path
    }
}
