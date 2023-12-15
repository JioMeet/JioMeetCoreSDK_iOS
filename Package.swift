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
            url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/spm/v_3_0_0_alpha_4/JioMeetCoreSDK.xcframework.zip",
            checksum: "0532559fa16c488dd2055e3c86cb775fb6efca65a1b15dce819c7d2a0544887b"
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
