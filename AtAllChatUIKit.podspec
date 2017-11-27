#
# Be sure to run `pod lib lint AtAllChatUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AtAllChatUIKit'
  s.version          = '1.0.4'
  s.summary          = 'This a AtAllChatUIKit for Swift 4.0+.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
这是一个即时通信UI组件，实现类似微信的即时通信聊天功能
                       DESC

  s.homepage         = 'https://github.com/zhiquan911/AtAllChatUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chance' => 'zhiquan911@qq.com' }
  s.source           = { :git => 'https://github.com/zhiquan911/AtAllChatUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'AtAllChatUIKit/AtAllChatUIKit/Classes/**/*'
  
  s.resource_bundles = {
    'AtAllChatUIKit' => [
        'AtAllChatUIKit/AtAllChatUIKit/Assets/*.{png,xcassets}',
        'AtAllChatUIKit/AtAllChatUIKit/Localizations/*.{lproj,strings}'
    ]
  }

  s.dependency 'Texture/IGListKit'
  s.dependency 'Texture/PINRemoteImage'

end

#提交命令：pod trunk push AtAllChatUIKit.podspec
