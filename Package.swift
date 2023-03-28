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
            from: "3.7.1"
        ),
        .package(
            name: "SDWebImageSwiftUI",
            url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git",
            from: "2.0.0"
        )
    ],
    targets: [
        .binaryTarget(
            name: "JioMeetCoreSDK",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_3/JioMeetCoreSDK.xcframework.zip",
            checksum: "799d7561e5af6c715c699a476d3b8f2cd165d157d95bc499dc78a64ff7137816"
        ),
        .binaryTarget(
            name: "JioMeetWatchParty",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_3/JioMeetWatchParty.xcframework.zip",
            checksum: "7e8b3b7a32474e11eaa1f4b6ec67f07cabb36e56bb5d2cd08f28c55c9cc80ac7"
        ),
        .target(
            name: "JioMeetWatchPartyTarget",
            dependencies: [
                .target(name: "JioMeetCoreSDK"),
                .target(name: "JioMeetWatchParty"),
                .product(name: "RTC", package: "JioMeetRtcEngine_iOS"),
                .product(name: "RTM", package: "JioMeetRtcEngine_iOS"),
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")
            ],
            path: "Framework/Dependency",
            exclude: []
        ),
    ]
)