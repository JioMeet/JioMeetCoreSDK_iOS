Pod::Spec.new do |spec|
    spec.name         = 'JioMeetUIKit_iOS'
    spec.version      = '2.2.0'
    spec.summary      = 'JioMeet iOS UI SDK'
    spec.description  = 'iOS library for JioMeet A/V communication and data channel service.'
    spec.homepage     = 'https://jiomeetpro.jio.com'
    spec.license      = { :type => 'Copyright', :text => 'COPYRIGHT 2022 JIO PLATFORMS LIMITED. ALL RIGHTS RESERVED.\n' }
    spec.author       = { 'Rohit Kumar' => 'rohit41.kumar@ril.com', 'Rohit Sharma' => 'rohit61.sharma@ril.com', 'Apparao Mulpuri' => 'apparao.mulpuri@ril.com', 'Umesh Chandak' => 'umesh.chandak@ril.com' }
    spec.platform     = :ios, '13'
    spec.source       = { :http => 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/2_2_0/JioMeetUIKit.xcframework.zip' }
    spec.vendored_frameworks = 'JioMeetUIKit.xcframework'
    spec.dependency 'JioMeetCoreSDK_iOS', '2.2.0'
    spec.dependency 'JioMeetChatUIKit_iOS', '2.2.0'
    spec.dependency 'JioMeetParticipantPanelSDK_iOS', '2.2.0'
end