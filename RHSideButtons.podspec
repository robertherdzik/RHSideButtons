Pod::Spec.new do |s|
s.name         = "RHSideButtons"
s.version      = "1.1.0"
s.summary      = "Library provides easy to implement variation of Android (Material Design) Floating Action Button for iOS. You can use it as your app small side menu."
s.description  = "Library provides easy to implement variation of Android (Material Design) Floating Action Button for iOS. You can use it as your app small side menu."
s.homepage     = "https://github.com/robertherdzik/RHSideButtons"

# ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
s.license = { :type => "MIT", :file => "LICENSE" }

# ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
s.author             = { "Robert Herdzik" => "robert.herdzik@yahoo.com" }

# ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
s.source = {
:git => "https://github.com/robertherdzik/RHSideButtons.git",
:tag => s.version.to_s
}

s.ios.deployment_target = '8.0'
s.requires_arc = true

# ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
s.ios.source_files  = "RHSideButtons/**/*.{swift}"

end
