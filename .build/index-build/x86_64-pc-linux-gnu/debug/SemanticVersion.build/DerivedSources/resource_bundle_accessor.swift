import Foundation

extension Foundation.Bundle {
    static let module: Bundle = {
        let mainPath = Bundle.main.bundleURL.appendingPathComponent("SemanticVersion_SemanticVersion.resources").path
        let buildPath = "/home/cvt/scalecloud-ios/ScaleCloudDeps/.build/index-build/x86_64-pc-linux-gnu/debug/SemanticVersion_SemanticVersion.resources"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle ?? Bundle(path: buildPath) else {
            // Users can write a function called fatalError themselves, we should be resilient against that.
            Swift.fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}