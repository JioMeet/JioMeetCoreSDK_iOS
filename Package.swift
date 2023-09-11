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
            from: "4.2.0"
        )
    ],
    targets: [
        .binaryTarget(
            name: "JioMeetCoreSDK",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_15/JioMeetCoreSDK.xcframework.zip",
            checksum: "527f0e166e1b1c7513a5182f1dcaf4534b033fb0a4b866aa29a9c56034f7570a"
        ),
        .binaryTarget(
            name: "JioMeetWatchParty",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_15/JioMeetWatchParty.xcframework.zip",
            checksum: "36c13b547e1932051abf4a683c4df3eea8bec6cc1e65646d24b1684ef448eb83"
        ),
        .binaryTarget(
            name: "FLAnimatedImage",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_15/FLAnimatedImage.xcframework.zip",
            checksum: "724c8b13ce5d0ab0981b1c51143f01b26387d269018d627ba80fbcefeb769252"
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