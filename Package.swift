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
			name: "JioMeetMediaStackSDK",
			url: "https://github.com/JioMeet/JMMediaStackSDK_iOS.git",
			.upToNextMajor(from: "1.0.0")
		)
	],
	targets: [
		.binaryTarget(
			name: "JioMeetCoreSDK",
			url: "https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/4_0_4/JioMeetCoreSDK.xcframework.zip",
			checksum: "d4231405c582fd9e4e2bc3d45a0d1439f77357bccac2ac0be6d58104cf635b1d"
		),
		.target(
			name: "JioMeetCoreSDKTarget",
			dependencies: [
				.target(name: "JioMeetCoreSDK"),
				.product(name: "JioMeetMediaStackSDK", package: "JioMeetMediaStackSDK")
			],
			path: "Framework/Dependency",
			exclude: []
		),
	]
)
