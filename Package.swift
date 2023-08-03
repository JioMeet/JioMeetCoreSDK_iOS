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
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_14/JioMeetCoreSDK.xcframework.zip",
            checksum: "e27f94842440a7e679f7c9ef63c2ac8ebbf79b2dbf4916b255aa4c30e37de556"
        ),
        .binaryTarget(
            name: "JioMeetWatchParty",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_14/JioMeetWatchParty.xcframework.zip",
            checksum: "f8216468906334621c156c0093440550a7c9d038b6f3303e47f11622fe0a506e"
        ),
        .binaryTarget(
            name: "FLAnimatedImage",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/internal/jv_watch_party/v1_1_14/FLAnimatedImage.xcframework.zip",
            checksum: "389a097071335b60963481cd313091803ff6cf7f4b8e87c1ff6289bf8733bc5d"
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