// swift-tools-version:5.7
// SPDX-FileCopyrightText: 2026 Nextcloud GmbH and Nextcloud contributors
// SPDX-License-Identifier: GPL-2.0-or-later
//
// ScaleCloudDeps — re-exports every shared SPM dependency as a single
// dynamic xcframework.  Built once in CI; linked (embed:false) by
// ScaleCloudKit and ScaleCloudRenew, embedded (embed:true) only by
// ScaleCloudApp — so exactly one copy of each dylib lives in the bundle.

import PackageDescription

let package = Package(
    name: "ScaleCloudDeps",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Alamofire",       type: .dynamic, targets: ["SCD_Alamofire"]),
        .library(name: "SwiftyJSON",      type: .dynamic, targets: ["SCD_SwiftyJSON"]),
        .library(name: "SwiftyXMLParser", type: .dynamic, targets: ["SCD_SwiftyXMLParser"]),
        .library(name: "KeychainAccess",  type: .dynamic, targets: ["SCD_KeychainAccess"]),
        .library(name: "Starscream",      type: .dynamic, targets: ["SCD_Starscream"]),
        .library(name: "ZIPFoundation",   type: .dynamic, targets: ["SCD_ZIPFoundation"]),
        .library(name: "Nuke",            type: .dynamic, targets: ["SCD_Nuke"]),
        .library(name: "SemanticVersion", type: .dynamic, targets: ["SCD_SemanticVersion"]),
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
        .target(name: "SCD_Alamofire",       dependencies: [.product(name: "Alamofire",       package: "Alamofire")],       path: "Sources/Alamofire"),
        .target(name: "SCD_SwiftyJSON",      dependencies: [.product(name: "SwiftyJSON",      package: "SwiftyJSON")],      path: "Sources/SwiftyJSON"),
        .target(name: "SCD_SwiftyXMLParser", dependencies: [.product(name: "SwiftyXMLParser", package: "SwiftyXMLParser")], path: "Sources/SwiftyXMLParser"),
        .target(name: "SCD_KeychainAccess",  dependencies: [.product(name: "KeychainAccess",  package: "KeychainAccess")],  path: "Sources/KeychainAccess"),
        .target(name: "SCD_Starscream",      dependencies: [.product(name: "Starscream",      package: "Starscream")],      path: "Sources/Starscream"),
        .target(name: "SCD_ZIPFoundation",   dependencies: [.product(name: "ZIPFoundation",   package: "ZIPFoundation")],   path: "Sources/ZIPFoundation"),
        .target(name: "SCD_Nuke",            dependencies: [.product(name: "Nuke",            package: "Nuke")],            path: "Sources/Nuke"),
        .target(name: "SCD_SemanticVersion", dependencies: [.product(name: "SemanticVersion", package: "SemanticVersion")], path: "Sources/SemanticVersion"),
    ]
)
