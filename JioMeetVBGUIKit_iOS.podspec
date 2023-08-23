specVersion = '2.3.0'
frameworkSourceUrl = 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/2_3_0/JioMeetVBGUIKit.xcframework.zip'

specAuthors = {
    'Rohit Kumar' => 'rohit41.kumar@ril.com',
    'Rohit Sharma' => 'rohit61.sharma@ril.com',
    'Apparao Mulpuri' => 'apparao.mulpuri@ril.com',
    'Umesh Chandak' => 'umesh.chandak@ril.com',
    'Tarun Kumar' => 'tarun58.kumar@ril.com',
    'Mani Baratam' => 'mani.baratam@ril.com',
    'Shivam Tripathi' => 'shivam.tripathi@ril.com',
    'Ramakrishna M' => 'ramakrishna1.m@ril.com'
}

licenseInfo = {
    :type => 'Copyright',
    :text => 'COPYRIGHT 2023 JIO PLATFORMS LIMITED. ALL RIGHTS RESERVED.\n'
}

Pod::Spec.new do |spec|
    spec.name         = 'JioMeetVBGUIKit_iOS'
    spec.version      = specVersion
    spec.summary      = 'JioMeet iOS Participant Panel UI SDK'
    spec.description  = 'iOS library for JioMeet A/V communication and data channel service.'
    spec.homepage     = 'https://jiomeetpro.jio.com'
    spec.license      = { :type => 'Copyright', :text => 'COPYRIGHT 2022 JIO PLATFORMS LIMITED. ALL RIGHTS RESERVED.\n' }
    spec.author       = specAuthors
    spec.platform     = :ios, '13'
    spec.source       = { :http => frameworkSourceUrl }
    spec.vendored_frameworks = 'JioMeetVBGUIKit.xcframework'
    spec.dependency 'JioMeetCoreSDK_iOS', specVersion
    spec.dependency 'JioMeetUIFoundation_iOS', specVersion
end