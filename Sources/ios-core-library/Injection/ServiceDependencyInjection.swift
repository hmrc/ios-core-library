/*
 * Copyright 2019 HM Revenue & Customs
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
import PINCache

//Copy and paste boiler plate
//protocol <#ProtocolName#>Injected {}
//extension <#ProtocolName#>Injected {
//    var <#injectedName#>: <#ProtocolName#> { return MobileCore.Injection.Service.<#SomePath#>.injectedObject() }
//}

public protocol JourneyServiceInjected {}
extension JourneyServiceInjected {
    public var journeyService: JourneyService { MobileCore.Injection.Service.journey.injectedObject() }
}

public protocol ApplicationStateServiceInjected {}
extension ApplicationStateServiceInjected {
    public var applicationState: ApplicationStateService { MobileCore.Injection.Service.applicationState.injectedObject() }
}

public protocol CoreNetworkServiceInjected {}
extension CoreNetworkServiceInjected {
    public var coreNetworkService: CoreNetworkService { MobileCore.Injection.Service.network.injectedObject() }
}

public protocol DeviceInfoServiceInjected {}
extension DeviceInfoServiceInjected {
    public var deviceInfo: DeviceInfoService { MobileCore.Injection.Service.deviceInfo.injectedObject() }
}

public protocol CoreHTTPServiceInjected {}
extension CoreHTTPServiceInjected {
    public var coreHTTPService: CoreHTTPService { MobileCore.Injection.Service.http.injectedObject() }
}

public protocol InfoPListServiceInjected {}
extension InfoPListServiceInjected {
    public var infoPlist: InfoPListService { MobileCore.Injection.Service.infoPlist.injectedObject() }
}

public protocol AppInfoServiceInjected {}
extension AppInfoServiceInjected {
    public var appInfo: AppInfoService { MobileCore.Injection.Service.appInfo.injectedObject() }
}

public protocol DateServiceInjected {}
extension DateServiceInjected {
    public var dateService: DateService { MobileCore.Injection.Service.date.injectedObject() }
}

public protocol FraudPreventionServiceInjected {}
extension FraudPreventionServiceInjected {
    public var fraudPrevention: FraudPreventionService { MobileCore.Injection.Service.fraudPrevention.injectedObject() }
}

public protocol NetworkSpinnerInjected {}
extension NetworkSpinnerInjected {
    public var networkSpinner: NetworkSpinner { MobileCore.Injection.Service.networkSpinner.injectedObject() }
}

public protocol NetworkSpinnerPolicyInjected {}
extension NetworkSpinnerPolicyInjected {
    public var networkSpinnerPolicy: NetworkSpinnerPolicy { MobileCore.Injection.Service.networkSpinnerPolicy.injectedObject() }
}

public protocol CertificatePinningInjected {}
extension CertificatePinningInjected {
    public var certificatePinningService: CertificatePinningService { MobileCore.Injection.Service.certificatePinning.injectedObject() }
}

public protocol CoreConfigCacheInjected {}
extension CoreConfigCacheInjected {
    public var coreConfigCache: PINCache { MobileCore.Injection.Service.coreConfig.injectedObject() }
}

public protocol LocalisationServiceInjected {}
extension LocalisationServiceInjected {
    public var localisationService: LocalisationService { MobileCore.Injection.Service.localisation.injectedObject() }
}

extension MobileCore.Injection {
    //public static let <#name#> = Injector { return MobileCore.<#Real Class#>.Service() }

    public struct Service {
        public static let http = Injector("HTTPService") { MobileCore.HTTP.Service() }
        public static let network = Injector("NetworkService") { MobileCore.Network.Service() }
        public static let journey = Injector("JourneyService") { MobileCore.Journey.Service() }
        public static let deviceInfo = Injector("DeviceInfoService") { MobileCore.Device.Info.Service.standard() }
        public static let applicationState = Injector("ApplicationStateService") { MobileCore.Application.State.Service() }
        public static let infoPlist = Injector("InfoPlistService") { MobileCore.InfoPList.Service() }
        public static let appInfo = Injector("AppInfoService") { MobileCore.AppInfo.Service() }
        public static let date = Injector("DateService") { MobileCore.Date.Service() }
        public static let fraudPrevention = Injector("FraudPreventionService") { MobileCore.FraudPrevention.Service() }
        public static let networkSpinner = Injector("HTTPService") { MobileCore.Network.Spinner.Empty() }
        public static let networkSpinnerPolicy = Injector("NetworkSpinnerService") { MobileCore.Network.Spinner.Policy() }
        public static let certificatePinning = Injector("CertificatePinningService") { MobileCore.HTTP.CertificatePinning() }
        public static let coreConfig = Injector("CoreConfigCache") {
            return PINCache(name: "CoreConfigCache", rootPath: StoragePath.permanent)
        }
        public static let localisation = Injector("LocalisationService") { MobileCore.Localisation.Service() }
    }
}
