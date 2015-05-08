Pod::Spec.new do |s|
  s.name = 'UIStoryboardSegue+M5LinkedStoryboard'
  s.version = '1.1.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Make segues (including embeds) work cross-storyboard.'
  s.description = 'Make segues (including embeds) work cross-storyboard. Segue identifiers should be in the form TARGET_SCENE_IDENTIFIER@TARGET_STORYBOARD_NAME.'
  s.homepage = 'https://github.com/mhuusko5/UIStoryboardSegue-M5LinkedStoryboard'
  s.social_media_url = 'https://twitter.com/mhuusko5'
  s.authors = { 'Mathew Huusko V' => 'mhuusko5@gmail.com' }
  s.source = { :git => 'https://github.com/mhuusko5/UIStoryboardSegue-M5LinkedStoryboard.git', :tag => s.version.to_s }

  s.platform = :ios
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.frameworks = 'UIKit'
  
  s.source_files = '*.{h,m}'
end