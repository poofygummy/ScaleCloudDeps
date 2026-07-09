// swift-tools-version:5.7
// SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
// SPDX-License-Identifier: GPL-2.0-or-later
//
// ScaleCloudDeps — pulls in all shared SPM dependencies so they can be built
// into prebuilt xcframeworks by CI.  The SCD* wrapper targets exist only to
// force package resolution; the CI workflow builds each upstream package scheme
// (Alamofire, SwiftyJSON, etc.) directly via:
//   xcodebuild -scheme <name> -package-path . ...
// Resulting xcframeworks are committed to prebuilt/ and consumed by
// ScaleCloudKit (embed:false), ScaleCloudRenew (embed:false), and
// ScaleCloudApp (embed:true — one copy in Frameworks/).

import PackageDescription

let package = Package(
    name: "ScaleCloudDeps",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "SCDAlamofire",       type: .dynamic, targets: ["SCDAlamofire"]),
        .library(name: "SCDSwiftyJSON",      type: .dynamic, targets: ["SCDSwiftyJSON"]),
        .library(name: "SCDSwiftyXMLParser", type: .dynamic, targets: ["SCDSwiftyXMLParser"]),
        .library(name: "SCDKeychainAccess",  type: .dynamic, targets: ["SCDKeychainAccess"]),
        .library(name: "SCDStarscream",      type: .dynamic, targets: ["SCDStarscream"]),
        .library(name: "SCDZIPFoundation",   type: .dynamic, targets: ["SCDZIPFoundation"]),
        .library(name: "SCDNuke",            type: .dynamic, targets: ["SCDNuke"]),
        .library(name: "SCDSemanticVersion", type: .dynamic, targets: ["SCDSemanticVersion"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git",                    from: "5.10.2"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git",                  from: "5.0.2"),
        .package(url: "https://github.com/yahoojapan/SwiftyXMLParser.git",             from: "5.6.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git",        from: "4.2.0"),
        .package(url: "https://github.com/daltoniam/Starscream.git",                   from: "4.0.0"),
        .package(url: "https://github.com/weichsel/ZIPFoundation.git",                 from: "0.9.0"),
        .package(url: "https://github.com/kean/Nuke.git",                              from: "10.0.0"),
        .package(url: "https://github.com/SwiftPackageIndex/SemanticVersion.git",      exact: "0.3.8"),
    ],
    targets: [
        .target(name: "SCDAlamofire",       dependencies: [.product(name: "Alamofire",       package: "Alamofire")],       path: "Sources/Alamofire"),
        .target(name: "SCDSwiftyJSON",      dependencies: [.product(name: "SwiftyJSON",      package: "SwiftyJSON")],      path: "Sources/SwiftyJSON"),
        .target(name: "SCDSwiftyXMLParser", dependencies: [.product(name: "SwiftyXMLParser", package: "SwiftyXMLParser")], path: "Sources/SwiftyXMLParser"),
        .target(name: "SCDKeychainAccess",  dependencies: [.product(name: "KeychainAccess",  package: "KeychainAccess")],  path: "Sources/KeychainAccess"),
        .target(name: "SCDStarscream",      dependencies: [.product(name: "Starscream",      package: "Starscream")],      path: "Sources/Starscream"),
        .target(name: "SCDZIPFoundation",   dependencies: [.product(name: "ZIPFoundation",   package: "ZIPFoundation")],   path: "Sources/ZIPFoundation"),
        .target(name: "SCDNuke",            dependencies: [.product(name: "Nuke",            package: "Nuke")],            path: "Sources/Nuke"),
        .target(name: "SCDSemanticVersion", dependencies: [.product(name: "SemanticVersion", package: "SemanticVersion")], path: "Sources/SemanticVersion"),
    ]
)
