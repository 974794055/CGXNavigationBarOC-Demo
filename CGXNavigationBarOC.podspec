Pod::Spec.new do |s|
  s.name         = "CGXNavigationBarOC"    #存储库名称
  s.version      = "0.4"      #版本号，与tag值一致
  s.summary      = "导航条按钮封装"  #简介
  s.description  = "方便快捷的导航条按钮封装"  #描述
  s.homepage     = "https://github.com/974794055/CGXNavigationBarOC-Demo"      #项目主页，不是git地址
  s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
  s.author             = { "974794055" => "974794055@qq.com" }  #作者
  s.platform     = :ios, "7.0"                  #支持的平台和版本号
  s.source       = { :git => "https://github.com/974794055/CGXNavigationBarOC-Demo.git", :tag => s.version }         #存储库的git地址，以及tag值


  s.requires_arc = true #是否支持ARC
 s.resources    = "CGXNavigationBarOC/*.{png,xib,nib,bundle,json}"



#需要托管的源代码路径
s.source_files = 'CGXNavigationBarOC/CGXNavigationBarOC.h'
#开源库头文件
s.public_header_files = 'CGXNavigationBarOC/CGXNavigationBarOC.h'


s.subspec 'CGXBarCustom' do |ss|
    ss.source_files = 'CGXNavigationBarOC/CGXBarCustom/**/*.{h,m}'
end

s.subspec 'CGXBarFixSpace' do |ss|
    ss.source_files = 'CGXNavigationBarOC/CGXBarFixSpace/**/*.{h,m}'
end

s.subspec 'CGXNavigationBar' do |ss|
   ss.source_files = 'CGXNavigationBarOC/CGXNavigationBar/**/*.{h,m}'
   ss.dependency 'CGXNavigationBarOC/CGXBarCustom'
   ss.dependency 'CGXNavigationBarOC/CGXBarFixSpace'
end



end
