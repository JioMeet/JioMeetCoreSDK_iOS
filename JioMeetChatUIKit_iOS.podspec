Pod::Spec.new do |spec|
    spec.name         = 'JioMeetChatUIKit_iOS'
    spec.version      = '2.2.0'
    spec.summary      = 'JioMeet Meeting Chat iOS UI SDK'
    spec.description  = 'iOS library for JioMeet A/V communication and data channel service.'
    spec.homepage     = 'https://jiomeetpro.jio.com'
    spec.license      = { :type => 'Copyright', :text => 'COPYRIGHT 2022 JIO PLATFORMS LIMITED. ALL RIGHTS RESERVED.\n' }
    spec.author       = { 'Rohit Kumar' => 'rohit41.kumar@ril.com', 'Rohit Sharma' => 'rohit61.sharma@ril.com', 'Apparao Mulpuri' => 'apparao.mulpuri@ril.com', 'Umesh Chandak' => 'umesh.chandak@ril.com' }
    spec.platform     = :ios, '13'
    spec.source       = { :http => 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/2_2_0/JioMeetChatUIKit.xcframework.zip' }
    spec.vendored_frameworks = 'JioMeetChatUIKit.xcframework'
    spec.dependency 'JioMeetCoreSDK_iOS', '2.2.0'
end