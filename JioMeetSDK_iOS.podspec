Pod::Spec.new do |spec|

    spec.name         = 'JioMeetSDK_iOS'
    spec.version      = '1.1.1'
    spec.summary      = 'JioMeet iOS UI SDK'
    spec.description  = 'iOS library for JioMeet A/V communication and data channel service.'
    spec.homepage     = 'https://jiomeetpro.jio.com'
    spec.license      = { :type => 'Copyright', :text => 'COPYRIGHT 2022 JIO PLATFORMS LIMITED. ALL RIGHTS RESERVED.\n' }
    spec.author       = { 'Rohit Kumar' => 'rohit41.kumar@ril.com', 'Rohit Sharma' => 'rohit61.sharma@ril.com', 'Apparao Mulpuri' => 'apparao.mulpuri@ril.com', 'Umesh Chandak' => 'umesh.chandak@ril.com' }
    spec.platform     = :ios, '10'
    spec.source       = { :http => 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/templates/contact_center/v1_1_1/JioMeetSDK_iOS_1_1_1.zip' }
    spec.vendored_frameworks = 'libs/JioMeetSDK.xcframework'
    spec.dependency 'JioMeetCore_iOS', '2.1.1'
  end
  