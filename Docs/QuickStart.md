# QuickStart Guide to Configure Core SDK inside your app

In this documentation, we'll guide you through the process of installation. Let's get started on your journey to creating seamless communication experiences with JioMeet Core SDK!

## Install the SDK

You can install JioMeet Core SDK via Cocoapods.

### Install Via Cocoapods

Please add `JioMeetCoreSDK_iOS` pod to your podfile and run `pod install --repo-update` command.

```ruby
target 'Your_App_Name' do
  use_frameworks!
  # Other Pods
  pod 'JioMeetCoreSDK_iOS', '~> 2.7'
end
```

## Project Settings

### Info.plist Changes

Please add below permissions keys to your `Info.plist` file with proper description.

```swift
<key>NSCameraUsageDescription</key>
<string>Allow access to camera for meetings</string>
<key>NSMicrophoneUsageDescription</key>
<string>Allow access to mic for meetings</string>
```

### Enable Background Mode

Please enable `Background Modes` in your project `Signing & Capibilities` tab. After enabling please check box with option `Audio, Airplay, and Pictures in Pictures`. If you don't enables this setting, your mic will be muted when your app goes to background.
