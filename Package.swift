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
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_2/JioMeetLogger.xcframework.zip",
            checksum: "c427bf65e0ce4d6454eec42b6fbd6358a56f94f3db336325a21215834242dca2"
        ),
        .binaryTarget(
            name: "JioMeetManager",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_2/JioMeetManager.xcframework.zip",
            checksum: "569afb2023560ace6113f3129d981c6d799705ea46058cd2527fbbe6930d3033"
        ),
        .binaryTarget(
            name: "JioMeetNetwork",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_2/JioMeetNetwork.xcframework.zip",
            checksum: "d2c446cd3cd7802db02d0c1d02c0bdc72613169fe078ba6d5af7fa40e2fe428f"
        ),
        .binaryTarget(
            name: "JioMeetRTC",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_2/JioMeetRTC.xcframework.zip",
            checksum: "086a858d83102f844ab30a2eca059c886a66e250f5206ea844c4a1ff4f2b9124"
        ),
        .binaryTarget(
            name: "JVWatchPartySDK",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_2/JVWatchPartySDK.xcframework.zip",
            checksum: "f73fdc7539e0f70076c875ff3a23af08686397ece32fd500a679f6d7aaf656d0"
        ),
        .target(
            name: "JioMeetWatchPartyTarget",
            dependencies: [
                .target(name: "JioMeetLogger"),
                .target(name: "JioMeetManager"),
                .target(name: "JioMeetNetwork"),
                .target(name: "JioMeetRTC"),
                .target(name: "JVWatchPartySDK"),
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