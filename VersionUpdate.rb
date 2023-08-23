specVersion = '2.3.0'

podsInfo = {
  JioMeetCoreSDK_iOS: 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/2_3_0/JioMeetCoreSDK.xcframework.zip',
  JioMeetUIFoundation_iOS: 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/2_3_0/JioMeetUIFoundation.xcframework.zip',
  JioMeetUIKit_iOS: 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/2_3_0/JioMeetUIKit.xcframework.zip',
  JioMeetChatUIKit_iOS: 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/2_3_0/JioMeetChatUIKit.xcframework.zip',
  JioMeetParticipantPanelSDK_iOS: 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/2_3_0/JioMeetParticipantPanelSDK.xcframework.zip',
  JioMeetVBGUIKit_iOS: 'https://storage.googleapis.com/cpass-sdk/libs/iOS/public/new_arch/2_3_0/JioMeetVBGUIKit.xcframework.zip'
}

# regexpUrl = /\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/?)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s\`!()\[\]{};:\'\".,<>?«»“”‘’]))/i
regexpUrl2 = /[\S]+/

podsInfo.each do | podspec, url |
  begin
    podspecName = podspec.to_s + ".podspec"
    podspecFileData = File.read(podspecName)
    versionFiltered_data = podspecFileData.gsub(/specVersion = '\d+\.\d+\.\d+'/, "specVersion = '#{specVersion}'")
    urlFiltered_data = versionFiltered_data.gsub(/frameworkSourceUrl = '#{regexpUrl2}'/, "frameworkSourceUrl = '#{url}'")
    finalModifiedData = urlFiltered_data
    File.open(podspecName, "w") do |file|
      file.write(finalModifiedData)
    end
  rescue => error
    puts error
  end
end