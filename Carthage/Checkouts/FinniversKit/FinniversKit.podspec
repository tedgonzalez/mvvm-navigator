Pod::Spec.new do |s|
  s.name         = 'FinniversKit'
  s.version      = '0.3.1'
  s.summary      = "FINN's iOS Components"
  s.author       = 'FINN.no'
  s.homepage     = 'https://schibsted.frontify.com/d/oCLrx0cypXJM/design-system'
  s.social_media_url   = 'https://twitter.com/search?q=FINN.no'
  s.description  = <<-DESC
  FinniversKit is the iOS native implementation of FINN's design system.
                   DESC

  s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
  }

  s.platform      = :ios, '9.0'
  s.swift_version = '4.0'
  s.source        = { :git => "https://github.com/finn-no/FinniversKit.git", :tag => s.version }
  s.requires_arc  = true

  s.source_files  = 'Sources/', 'Sources/Extensions/Foundation', 'Sources/Extensions/UIKit/', 'Sources/Components/**/*.swift', 'Sources/Fullscreen/**/*.swift', 'Sources/DNA/**/*.swift', 'Sources/Protocols/'
  s.resources     = 'Sources/Resources/Fonts/*.ttf', 'Sources/Resources/*.xcassets'
  s.resource_bundles = {
      'FinniversKit' => ['Sources/Resources/*.xcassets', 'Sources/Resources/Fonts/*.ttf']
    }
  s.exclude_files = 'Sources/Components/**/*DemoView.swift', 'Sources/Components/**/Demo/', '*DemoView.swift', 'Sources/Components/**/**/Demo/*.swift', '*Helpers.swift', 'Sources/DNA/**/Demo/*.swift'


  s.subspec 'DNA' do |sp|
  sp.source_files  = 'Sources', 'Sources/DNA/Color/Color.swift', 'Sources/DNA/Font/Font.swift', 'Sources/DNA/Spacing/Spacing.swift'
  sp.resources     = 'Sources/Resources/Fonts/*.ttf', 'Sources/Resources/*.xcassets'
  sp.requires_arc = true
 end
end
