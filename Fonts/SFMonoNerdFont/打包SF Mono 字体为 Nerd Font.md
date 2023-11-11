## 打包SF Mono 字体为 Nerd Font
Apple 的新字体已经换成了 SF（旧金山） 字体家族，但 SF Mono 由于 Apple 版权原因，Nerd Font 肯定不能公然发布的，所以只能自己使用 Nerd Font 提供的 Script 来手动 Patch。  
实际上系统已经安装了``SF Mono``字体。只是位置比较隐秘，在字体册中是看不到的。其实际位置在:
``/Applications/Utilities/Terminal.app/Contents/Resources/Fonts``  
拷贝``SF Mono``字体到指定目录下，比如``~/Downloads/Fonts``
```
brew install fontforge
git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
fontforge -script ./font-patcher -s -c ~/Downloads/Fonts/SFMono-Medium.otf -out ~/Downloads/Fonts/SFMonoNF
```
稍等片刻后，在``SFMonoNF``目录下就能看到生成好的字体了