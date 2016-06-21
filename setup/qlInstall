#! /bin/bash
# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if [ ! -d "$HOME/Library/QuickLook" ]; then
	mkdir -p "$HOME/Library/QuickLook"
fi
echo Installing Quick Look-plugins from Homebrew

# Checking if Homebrew is installed
if ! type -p brew > /dev/null ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# All Quick Look-plugins from homebrew
brew cask install betterzipql
brew cask install provisionql 
brew cask install invisorql
brew cask install qlcolorcode 
brew cask install qlimagesize 
brew cask install qlmarkdown 
brew cask install qlprettypatch 
brew cask install quicklook-csv 
brew cask install quicklook-json 
brew cask install quicknfo scriptql 
brew cask install suspicious-package 
brew cask install webpquicklook

# All Quick Look-plugins that aren't in homebrew
echo Installing/Downloading Quick Look-plugins that are not from Homebrew 
echo THEY MIGHT BE OUTDATED
curl -o "$HOME/Library/QuickLook/QLStephen.qlgenerator" https://raw.github.com/Croxed/osx-init/master/extras/QLStephen.qlgenerator

# Downloading the plugins
curl -o "$HOME/Library/QuickLook/1.zip" http://repo.whine.fr/qlmoviepreview.qlgenerator-10.9.zip
curl -o "$HOME/Library/QuickLook/2.zip" http://ipaql.com/site/assets/files/1006/ipaql_1-3-0.zip
curl -o "$HOME/Library/QuickLook/3.zip" http://blog.timac.org/post-images/StringsFileQuickLook/StringsFile.qlgenerator.zip

# Moving into QuickLook-folder to extract the .zip's
# Failsafe if cd doesn't work
cd "$HOME/Library/QuickLook" || exit
for filename in ./*.zip; do
	unzip -q "$filename"
done

# Removing all .zip-archives
rm -rf ./*.zip
echo Restarting Quick Look-manager
qlmanage -r