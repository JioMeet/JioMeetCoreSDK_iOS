// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JioMeetSDK",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "JVWatchPartySDK",
            targets: ["JioMeetWatchPartyTarget"]
        ),
    ],
    dependencies: [
        .package(
            name: "JioMeetRtcEngine_iOS",
            url: "https://github.com/JioMeet/JioMeet-rtc-engine-ios.git",
            "3.7.2"..<"3.7.3"
        )
    ],
    targets: [
        .binaryTarget(
            name: "JioMeetCoreSDK",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_12/JioMeetCoreSDK.xcframework.zip",
            checksum: "e35679c50ec166c6b47ee27b67365feab60f097aa41387dab1385027f54869be"
        ),
        .binaryTarget(
            name: "JioMeetWatchParty",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_12/JioMeetWatchParty.xcframework.zip",
            checksum: "2750004010201254494f0832cf08f5bf7509d783ee26f8e65c5d26e19aa8b88b"
        ),
        .binaryTarget(
            name: "FLAnimatedImage",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_12/FLAnimatedImage.xcframework.zip",
            checksum: "cd5a7a1962b46796389a64c16d0c008cd81d7ec52b14b028c0bdbb02e9c7e147"
        ),
        .target(
            name: "JioMeetWatchPartyTarget",
            dependencies: [
                .target(name: "JioMeetCoreSDK"),
                .target(name: "JioMeetWatchParty"),
                .target(name: "FLAnimatedImage"),
                .product(name: "RTC", package: "JioMeetRtcEngine_iOS"),
                .product(name: "RTM", package: "JioMeetRtcEngine_iOS")
            ],
            path: "Framework/Dependency",
            exclude: []
        ),
    ]
)