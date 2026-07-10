# ScaleCloudDeps

Pre-built dynamic xcframeworks for the SPM packages shared across
**ScaleCloudKit**, **ScaleCloudRenew**, and **ScaleCloudApp**.

## Why this exists

Each of those three targets previously resolved and compiled Alamofire,
SwiftyJSON, etc. independently. At runtime the ObjC runtime found 2–3 copies
of every class → duplicate-class warnings → SIGKILL on launch.

The fix: build each shared package **exactly once** here, ship it as a
dynamic xcframework, and have every consumer link against the same binary.

## How it is built

CI workflow: `.github/workflows/testbuildSCDeps.yml`

1. `swift package resolve` — fetches all 8 upstream packages into `.build/checkouts/`
2. For each package, `pushd` into its checkout and run `xcodebuild build -scheme <name> -sdk iphoneos BUILD_LIBRARY_FOR_DISTRIBUTION=YES`
3. Wrap the resulting `.framework` into an `.xcframework` with `xcodebuild -create-xcframework`
4. Commit `prebuilt/` back to this repo; update the monorepo submodule pointer

## Packages

| xcframework | Upstream | Scheme used |
|---|---|---|
| Alamofire.xcframework | github.com/Alamofire/Alamofire ≥ 5.10.2 | `Alamofire iOS` |
| SwiftyJSON.xcframework | github.com/SwiftyJSON/SwiftyJSON ≥ 5.0.2 | `SwiftyJSON iOS` |
| SwiftyXMLParser.xcframework | github.com/yahoojapan/SwiftyXMLParser ≥ 5.6.0 | `SwiftyXMLParser` |
| KeychainAccess.xcframework | github.com/kishikawakatsumi/KeychainAccess ≥ 4.2.0 | `KeychainAccess` |
| Starscream.xcframework | github.com/daltoniam/Starscream ≥ 4.0.0 | `Starscream` |
| ZIPFoundation.xcframework | github.com/weichsel/ZIPFoundation ≥ 0.9.0 | `ZIPFoundation` |
| Nuke.xcframework | github.com/kean/Nuke ≥ 10.0.0 | `Nuke` |
| SemanticVersion.xcframework | github.com/SwiftPackageIndex/SemanticVersion = 0.3.8 | `SemanticVersion` |

## How consumers use these

- **ScaleCloudKit** and **ScaleCloudRenew**: link with `embed: false` — compile-time access, no copy baked in
- **ScaleCloudApp**: link and embed with `embed: true` — the one physical copy in `Nextcloud.app/Frameworks/`

`dyld` resolves all three consumers' `@rpath/Alamofire.framework/Alamofire` to the
single copy in the app bundle. One binary, loaded once, no duplicate classes.
