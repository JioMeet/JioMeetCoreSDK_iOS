Pod::Spec.new do |spec|
    spec.name         = 'JioMeetCoreSDK_iOS'
    spec.version      = '2.0.0'
    spec.summary      = 'JioMeet iOS Core SDK'
    spec.description  = 'iOS library for JioMeet A/V communication and data channel service.'
    spec.homepage     = 'https://jiomeetpro.jio.com'
    spec.license      = { :type => 'Copyright', :text => 'COPYRIGHT 2022 JIO PLATFORMS LIMITED. ALL RIGHTS RESERVED.\n' }
    spec.author       = { 'Rohit Kumar' => 'rohit41.kumar@ril.com', 'Rohit Sharma' => 'rohit61.sharma@ril.com', 'Apparao Mulpuri' => 'apparao.mulpuri@ril.com', 'Umesh Chandak' => 'umesh.chandak@ril.com' }
    spec.platform     = :ios, '12'
    spec.source       = { :http => 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/2.0.0/JioMeetCoreSDK.xcframework.zip' }
    spec.vendored_frameworks = 'JioMeetCoreSDK.xcframework'
    spec.dependency 'JioMeetRtcEngine_iOS', '3.7.1.2'
    spec.dependency 'JioMeetRtmKit_iOS', '1.5.1.0'
    spec.dependency 'Starscream', '~> 4.0'
end