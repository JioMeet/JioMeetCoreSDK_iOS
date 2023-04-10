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
            name: "SDWebImage",
            url: "https://github.com/SDWebImage/SDWebImage.git",
            from: "5.10.0"
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
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_5/JioMeetCoreSDK.xcframework.zip",
            checksum: "01776ef6b907562bede1842939f5a95cab6351afc5fbec35e88766f321d2b17c"
        ),
        .binaryTarget(
            name: "JioMeetWatchParty",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_5/JioMeetWatchParty.xcframework.zip",
            checksum: "2ec80a6014796c47dc2654f369f72348d061e7228d312acdcafb137f16ecad2a"
        ),
        .target(
            name: "JioMeetWatchPartyTarget",
            dependencies: [
                .target(name: "JioMeetCoreSDK"),
                .target(name: "JioMeetWatchParty"),
                .product(name: "RTC", package: "JioMeetRtcEngine_iOS"),
                .product(name: "RTM", package: "JioMeetRtcEngine_iOS"),
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
                .product(name: "SDWebImage", package: "SDWebImage")
            ],
            path: "Framework/Dependency",
            exclude: []
        ),
    ]
)