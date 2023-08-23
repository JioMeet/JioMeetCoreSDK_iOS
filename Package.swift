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
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/PLDT/2_0_1/JioMeetCoreSDK.xcframework.zip",
            checksum: "52db7af9eb56bdd6f9f1ea10e21da51e1d36496243e3a6b62c210d377019ba32"
        ),
        .binaryTarget(
            name: "JioMeetWatchParty",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/PLDT/2_0_1/JioMeetWatchParty.xcframework.zip",
            checksum: "1f2d46cc497356dcbd67674a1c1a7bdf799b5773f14fd165fe1ddd2e50b27537"
        ),
        .binaryTarget(
            name: "FLAnimatedImage",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/PLDT/2_0_1/FLAnimatedImage.xcframework.zip",
            checksum: "c9d653e3913af7805f7e5139768e7461c09c9d6f76fddf5a367aaae70f52f97d"
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