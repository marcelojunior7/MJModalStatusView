Pod::Spec.new do |s|
  s.name             = 'MJModalStatusView'
  s.version          = '0.1.1'
  s.summary          = 'By far the most fantastic modal status view I have seen in my entire life.'
 
  s.description      = <<-DESC
This fantastic modal status view makes your app look fantastic, it is a simple and fancy modal to show any time!
                       DESC
 
  s.homepage         = 'https://github.com/marcelojunior7/MJModalStatusView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Marcelo Jr' => 'marcelo_junior07@hotmail.com' }
  s.source           = { :git => 'https://github.com/marcelojunior7/MJModalStatusView.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '9.1'
  s.source_files = 'MJModalStatusView/*'
 
end