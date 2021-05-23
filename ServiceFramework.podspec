Pod::Spec.new do |s|
  s.name         = 'ServiceFramework'
  s.version      = "0.0.7"
  s.summary      = 'ServiceFramework.'
  s.description  = 'ServiceFramework library.'
  s.license      = { :type => 'CUSTOM' }
  s.source       = { :git => 'https://github.com/next-solution/ServiceFramework.git', :tag => s.version.to_s }
  s.author       = { 'Marcin Makurat' => 'mm@next-solution.pl' }
  s.homepage     = "http://www.next-solution.pl"

  s.platform     = :ios, "12.0"
  s.requires_arc = true
  s.swift_version = "5.0"
  s.source_files = [
    "ServiceFramework/**.{swift}",
    "ServiceFramework/**/*.{swift}"
  ]

  #Dependencies
  s.dependency 'Swinject'
  s.dependency 'Alamofire'
  s.dependency 'AlamofireImage'
  s.dependency 'CocoaLumberjack'
end
