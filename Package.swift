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
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/PLDT/2_0_0/JioMeetCoreSDK.xcframework.zip",
            checksum: "db9be64c39ac6ce540f61af308c2ea9e1fa2eb6f6dbde4f761676bbf9ab59d19"
        ),
        .binaryTarget(
            name: "JioMeetWatchParty",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/PLDT/2_0_0/JioMeetWatchParty.xcframework.zip",
            checksum: "39713b2008132a67281874d853e3c99f371dadbccbe25203642bd8ba0ea552fe"
        ),
        .binaryTarget(
            name: "FLAnimatedImage",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/PLDT/2_0_0/FLAnimatedImage.xcframework.zip",
            checksum: "f4f579836509729db788c05c054ac32852265a0992229830c43969fc99c785c0"
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