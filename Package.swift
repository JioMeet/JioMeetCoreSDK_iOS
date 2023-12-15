// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JioMeetCoreSDK",
    defaultLocalization: "en",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "JioMeetCoreSDK",
            targets: ["JioMeetCoreSDKTarget"]
        ),
    ],
    dependencies: [
        .package(
			name: "JioMeetRtcEngine_iOS",
			url: "https://github.com/JioMeet/JioMeet-rtc-engine-ios.git",
			.exact("3.7.2")
		),
        .package(
            name: "JioMeetMediaStackSDK",
            url: "https://github.com/JioMeet/JMMediaStackSDK_iOS.git", 
           .upToNextMajor(from: "1.0.0")
        )
    ],
    targets: [
        .binaryTarget(
            name: "JioMeetCoreSDK",
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/JMMedia/dynamic/v_1_0_1_alpha_2/JMMediaStackSDK.xcframework.zip",
            checksum: "fec554bfb94c23bd119fe505140faf78ab49d69b753222873208b24c7d7a23b8"
        ),
        .target(
            name: "JioMeetCoreSDKTarget",
            dependencies: [
                .target(name: "JioMeetCoreSDK"),
                .product(name: "RTC", package: "JioMeetRtcEngine_iOS"),
				.product(name: "RTM", package: "JioMeetRtcEngine_iOS"),
                .product(name: "JioMeetMediaStackSDK", package: "JioMeetMediaStackSDK")
            ],
            path: "Framework/Dependency",
            exclude: []
        ),
    ]
)
