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
		)
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
			.branch("spm_custom_test_url")
		)
	],
	targets: [
		.binaryTarget(
			name: "JioMeetCoreSDK",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/JMMedia/dynamic/v_2_0_0_alpha_demo/test/JioMeetCoreSDK.xcframework.zip",
			checksum: "42cecad0253296e7fd7343cf8e2f3545387332848d8df27579c91a797646df36"
		),
		.target(
			name: "JioMeetCoreSDKTarget",
			dependencies: [
				.target(name: "JioMeetCoreSDK"),
				.product(name: "RTC", package: "JioMeetRtcEngine_iOS"),
				.product(name: "RTM", package: "JioMeetRtcEngine_iOS"),
				.product(name: "JioMeetMediaStackSDK", package: "JioMeetMediaStackSDK")
			],
			path: "SPMSource/CoreSDK",
			exclude: []
		)
	]
)
