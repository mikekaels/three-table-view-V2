# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def alamofire
 pod 'Alamofire', '5.5'
end

def kingfisher
 pod 'Kingfisher', '7.0'
end

def rx_swift
    pod 'RxSwift', '6.5.0'
end

def rx_cocoa
    pod 'RxCocoa', '6.5.0'
end

def rx_dataSource
  pod 'RxDataSources'
end

def lottie
  pod 'lottie-ios'
end

def kingfisher
  pod 'Kingfisher', '~> 7.0'
end

def test_pods
    pod 'RxTest', '6.5.0'
    pod 'RxBlocking', '6.5.0'
    pod 'Nimble'
end


target 'TokopediaMiniProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TokopediaMiniProject
  alamofire

  target 'TokopediaMiniProjectTests' do
   # inherit! :search_paths
    # Pods for testing
  end

end

target 'CommonUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Pods for CommonUI
  rx_swift
  rx_cocoa
  rx_dataSource
  lottie
  kingfisher
  target 'CommonUITests' do
    # Pods for testing
  end

end

target 'Core' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Core
  rx_swift
  rx_cocoa
  rx_dataSource
  target 'CoreTests' do
    # Pods for testing
  end

end

target 'NetworkInfrastructure' do
  use_frameworks!
  
  rx_swift
  rx_cocoa
  alamofire
  target 'NetworkInfrastructureTests' do
  
  end

end
