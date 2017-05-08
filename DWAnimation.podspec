Pod::Spec.new do |s|
s.name = 'DWAnimation'
s.version = '1.1.9'
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.summary = 'DWAnimation is an SDK for animation based on CoreAnimaiton.Help you to create Animation In DSL.这是一个基于CoreAnimation的SDK，让你享受以链式语法创建动画的快感~'
s.homepage = 'https://github.com/CodeWicky/DWAnimation'
s.authors = { 'codeWicky' => 'codewicky@163.com' }
s.social_media_url = 'http://www.jianshu.com/u/a56ec10f6603'
s.source = { :git => 'https://github.com/CodeWicky/DWAnimation.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'DWAnimation/*.{h,m}'
s.frameworks = 'UIKit'
end

