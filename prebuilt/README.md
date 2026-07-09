# ScaleCloudDeps prebuilt

This directory contains the pre-built dynamic xcframeworks for the shared SPM
dependencies used across ScaleCloudKit, ScaleCloudRenew, and ScaleCloudApp.

Each package is built exactly once as a dynamic framework.  Consumers link
against it with `embed: false`; only ScaleCloudApp embeds the final copies
into the .app bundle.

Contents (populated by CI):
- Alamofire.xcframework
- SwiftyJSON.xcframework
- SwiftyXMLParser.xcframework
- KeychainAccess.xcframework
- Starscream.xcframework
- ZIPFoundation.xcframework
- Nuke.xcframework
- SemanticVersion.xcframework
