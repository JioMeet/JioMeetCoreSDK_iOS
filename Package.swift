// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JioMeetSDK",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "JioMeetWatchParty",
            targets: ["JioMeetWatchPartyTarget"]
        ),
    ],
    dependencies: [
        .package(
            name: "JioMeetRtcEngine_iOS",
            url: "https://github.com/JioMeet/JioMeet-rtc-engine-ios.git",
            from: "3.7.1"
        )
    ],
    targets: [
        .binaryTarget(
            name: "JioMeetLogger",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_1/JioMeetLogger.xcframework.zip",
            checksum: "a258d128f8eefbf0c7da8d031f28af36b50791f2ca5866a9e11b99338f25cdff"
        ),
        .binaryTarget(
            name: "JioMeetManager",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_1/JioMeetManager.xcframework.zip",
            checksum: "d26bf0c2f6ea81bc23b8b4f820f639379245ca59e4792a84c0cd7f4216fc7835"
        ),
        .binaryTarget(
            name: "JioMeetNetwork",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_1/JioMeetNetwork.xcframework.zip",
            checksum: "2c3da082739a65544e5c12528fba6d27f5446d7180acb25b57848f0d7e87659a"
        ),
        .binaryTarget(
            name: "JioMeetRTC",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_1/JioMeetRTC.xcframework.zip",
            checksum: "f4c65d45fd6e93943e8226246b87be933c6533cb073e77891c0e4ee1e1ea52e6"
        ),
        .binaryTarget(
            name: "JioMeetWatchParty",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_1/JioMeetWatchParty.xcframework.zip",
            checksum: "540c74a0093d46f884f3eaa74f68d6999aa78882257973c1b34cdd6a2ec14b7b"
        ),
        .binaryTarget(
            name: "FLAnimatedImage",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_1/FLAnimatedImage.xcframework.zip",
            checksum: "6d626ca8bf1d1cd4d07592c396303e7c25f68cf12821f04a5cecf26e3332f082"
        ),
        .target(
            name: "JioMeetWatchPartyTarget",
            dependencies: [
                .target(name: "JioMeetLogger"),
                .target(name: "JioMeetManager"),
                .target(name: "JioMeetNetwork"),
                .target(name: "JioMeetRTC"),
                .target(name: "JioMeetWatchParty"),
                .target(name: "FLAnimatedImage"),
                .product(name: "RtcBasic", package: "JioMeetRtcEngine_iOS"),
                .product(name: "AINS", package: "JioMeetRtcEngine_iOS"),
                .product(name: "ContentInspect", package: "JioMeetRtcEngine_iOS"),
                .product(name: "VideoPreprocess", package: "JioMeetRtcEngine_iOS"),
                .product(name: "VirtualBackground", package: "JioMeetRtcEngine_iOS"),
            ],
            path: "Framework/Dependency",
            exclude: []
        ),
    ]
)