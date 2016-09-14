Pod::Spec.new do |s|
  s.name         = "Moya-ObjectMapper"
  s.version      = "1.3.1"
  s.summary      = "ObjectMapper bindings for Moya"
  s.description  = <<-EOS
  [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) bindings for
  [Moya](https://github.com/Moya/Moya) for easier JSON serialization.
  Includes [RxSwift](https://github.com/ReactiveX/RxSwift/) bindings as well.
  Instructions on how to use it are in
  [the README](https://github.com/ivanbruel/Moya-ObjectMapper).
  EOS
  s.homepage     = "https://github.com/ivanbruel/Moya-ObjectMapper"
  s.license      = { :type => "MIT", :file => "License" }
  s.author             = { "Ivan Bruel" => "ivan.bruel@gmail.com" }
  s.social_media_url   = "http://twitter.com/ivanbruel"
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/ivanbruel/Moya-ObjectMapper.git", :tag => s.version }
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "Source/*.swift"
    ss.dependency "Moya", "~> 7.0"
    ss.dependency "ObjectMapper", "~> 1.3"
    ss.framework  = "Foundation"
  end

  s.subspec "RxSwift" do |ss|
    ss.source_files = "Source/RxSwift/*.swift"
    ss.dependency "Moya/RxSwift", "~> 7.0"
    ss.dependency "Moya-ObjectMapper/Core"
    ss.dependency "RxSwift", "~> 2.0"
  end

  s.subspec "ReactiveCocoa" do |ss|
    ss.source_files = "Source/ReactiveCocoa/*.swift"
    ss.dependency "Moya/ReactiveCocoa", "~> 7.0"
    ss.dependency "Moya-ObjectMapper/Core"
    ss.dependency "ReactiveCocoa", "~> 4.0"
  end
end
