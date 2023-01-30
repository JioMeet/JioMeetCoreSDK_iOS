Pod::Spec.new do |spec|

    spec.name         = 'JioMeetCore_iOS'
    spec.version      = '2.1.1'
    spec.summary      = 'JioMeet Core SDKs'
    spec.description  = 'iOS library for JioMeet A/V communication and data channel service.'
    spec.homepage     = 'https://jiomeetpro.jio.com'
    spec.license      = { :type => 'Copyright', :text => 'COPYRIGHT 2022 JIO PLATFORMS LIMITED. ALL RIGHTS RESERVED.\n' }
    spec.author       = { 'Rohit Kumar' => 'rohit41.kumar@ril.com', 'Rohit Sharma' => 'rohit61.sharma@ril.com', 'Apparao Mulpuri' => 'apparao.mulpuri@ril.com', 'Umesh Chandak' => 'umesh.chandak@ril.com' }
    spec.platform     = :ios, '10'
    spec.source       = { :http => 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/core/v2_1_1/JioMeetCore_iOS_2_1_1.zip' }
    spec.subspec 'Logger' do |logger|
        logger.vendored_frameworks = 'libs/JioMeetLogger.xcframework'
    end

    spec.subspec 'Network' do |network|
        network.dependency 'JioMeetCore_iOS/Logger'
        network.vendored_frameworks = 'libs/JioMeetNetwork.xcframework'
    end

    spec.subspec 'RtcManager' do |rtc|
        rtc.dependency 'JioMeetCore_iOS/Logger'
        rtc.dependency 'JioMeetRtcEngine_iOS', '3.7.1.2'
        rtc.vendored_frameworks = 'libs/JioMeetRTC.xcframework'
    end
    
    spec.subspec 'Manager' do |manager|
        manager.dependency 'JioMeetCore_iOS/Logger'
        manager.dependency 'JioMeetCore_iOS/Network'
        manager.dependency 'JioMeetCore_iOS/RtcManager'
        manager.vendored_frameworks = 'libs/JioMeetManager.xcframework'
    end
  end
  