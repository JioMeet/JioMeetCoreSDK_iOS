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
        ),
        .package(
            name: "Lottie",
            url: "https://github.com/airbnb/lottie-spm.git", 
           "4.3.1"..<"4.3.1"
        )
    ],
    targets: [
        .binaryTarget(
            name: "JioMeetCoreSDK",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_16/JioMeetCoreSDK.xcframework.zip",
            checksum: "30afc11575cc8594e248919f2e0d8b1c9fbf06e58bec482d2be2b5c0f5b09362"
        ),
        .binaryTarget(
            name: "JioMeetWatchParty",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_16/JioMeetWatchParty.xcframework.zip",
            checksum: "b9af2ac30baa62a47ebc39c45f5c90451d0a2cd3848425a5951fc580f5d3a061"
        ),
        .binaryTarget(
            name: "FLAnimatedImage",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_16/FLAnimatedImage.xcframework.zip",
            checksum: "d73e2deed4f486264c4e1ee351c52552708f383ae03589ccd837b54cc0db584c"
        ),
        .target(
            name: "JioMeetWatchPartyTarget",
            dependencies: [
                .target(name: "JioMeetCoreSDK"),
                .target(name: "JioMeetWatchParty"),
                .target(name: "FLAnimatedImage"),
                .product(name: "RTC", package: "JioMeetRtcEngine_iOS"),
                .product(name: "RTM", package: "JioMeetRtcEngine_iOS"),
                .product(name: "Lottie", package: "Lottie"),
            ],
            path: "Framework/Dependency",
            exclude: []
        ),
    ]
)