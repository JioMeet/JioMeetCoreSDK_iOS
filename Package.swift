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
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/v_3_0_0_alpha_4/JioMeetCoreSDK.xcframework.zip",
			checksum: "c32834eb3e4d42ac53af6030cf7a30f30ff2f3dcc473d891b1cbaa107435296d"
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
