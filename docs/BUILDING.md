# Building Vs Brainy

## Dependencies
Windows Only - Microsoft Visual Studio Community 2022

First, make you have [git](https://git-scm.com/install/) and [Haxe](https://haxe.org/) (Latest version) installed. 

## Cloning
Now, you can just type in `git clone --recurse-submodules https://github.com/VsBrainy/VS-Brainy.git` in Command Line/Powershell/Terminal and it's cloned!

(If you don't want to clone assets with it, remove `--recurse-submodules` from the command, but the mod may not compile correctly.)

Now, run [this on Windows](/setup/windows.bat) or [this on Mac and Linux](/setup/unix.sh) to install dependencies.

Now, using the `cd` command, navigate to the repo's root directory, and then finally, type in any of these commands.

``` bash
lime build cpp # builds game without launching
lime test cpp # builds game and then launches it
lime build windows
lime build mac
lime build linux
#etc
```

Also, if you wanted to, you could fork this repository and run `main.yml`, but this unrecommended.
