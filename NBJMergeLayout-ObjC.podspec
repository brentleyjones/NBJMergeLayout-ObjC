
Pod::Spec.new do |s|

  s.name         = "NBJMergeLayout-ObjC"
  s.version      = "1.0.1"
  s.summary      = "Remove unnecessary views from Nib view hierarchies"
  s.homepage     = "https://github.com/BrentleyJones/NBJMergeLayout-ObjC"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brentley Jones" => "contact@brentleyjones.com" }
  s.social_media_url   = "http://twitter.com/BrentleyJones"
  s.ios.deployment_target = "6.0"
  s.osx.deployment_target = "10.7"
  s.source       = { :git => "https://github.com/BrentleyJones/NBJMergeLayout-ObjC.git", :tag => "1.0.1" }
  s.source_files = "NBJMergeLayout/**/*.{h,m}"
  s.requires_arc = false

end
