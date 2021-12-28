Pod::Spec.new do |s|
  s.name         = "Moya-ObjectMapper"
  s.version      = "2.9"
  s.summary      = "ObjectMapper bindings for Moya"
  s.description  = <<-EOS
  [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) bindings for
  [Moya](https://github.com/Moya/Moya) for easier JSON serialization.
  Includes [RxSwift](https://github.com/ReactiveX/RxSwift/) bindings as well.
  Instructions on how to use it are in
  [the README](https://github.com/bmoliveira/Moya-ObjectMapper).
  EOS
  s.homepage     = "https://github.com/bmoliveira/Moya-ObjectMapper"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Ivan Bruel" => "ivan.bruel@gmail.com" }
  s.social_media_url   = "http://twitter.com/ivanbruel"
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.watchos.deployment_target = '3.0'
  s.tvos.deployment_target = '10.0'
  s.source       = { :git => "https://github.com/bmoliveira/Moya-ObjectMapper.git", :tag => s.version }
  s.default_subspec = "Core"
  s.swift_version = '5'

  s.subspec "Core" do |ss|
    ss.source_files  = "Source/Core/*.swift"
    ss.dependency "Moya"
    ss.dependency "ObjectMapper"
    ss.framework  = "Foundation"
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "Source/RxSwift/*.swift"
    ss.dependency "Moya-ObjectMapper/Core"
    ss.dependency "RxSwift"
    ss.dependency "Moya/RxSwift"
  end

  s.subspec "ReactiveSwift" do |ss|
    ss.source_files = "Source/ReactiveSwift/*.swift"
    ss.dependency "Moya-ObjectMapper/Core"
    ss.dependency "Moya/ReactiveSwift"
    ss.dependency "ReactiveSwift"
  end
end
