Pod::Spec.new do |s|
  s.name         = "VZViewController"
  s.version      = "0.0.2"
  s.summary      = "ViewController"
  s.description  = "Present right pannig view controller"
  s.homepage     = "https://github.com/alekoleg/VZViewController"
  s.license      = 'MIT'
  s.author       = { "Oleg Alekseenko" => "alekoleg@gmail.com" }
  s.source       = { :git => "https://github.com/alekoleg/VZViewController.git", :tag => s.version.to_s}
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/*.{h,m}'

  s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation', 'UIKit'

end
