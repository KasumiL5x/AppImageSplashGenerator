# App Image Splash Generator
> A basic script that generates splash screen image variants for both Android and iOS platforms.

### Requirements
This script requires at least Bash 4. If you are on macOS, you can upgrade Bash using [homebrew](https://formulae.brew.sh/formula/bash).

To check your Bash version, you can run the `bash --version` command.

You wil also need `imagemagick` to perform the image manipulations, which can also be obtained from [homebrew](https://formulae.brew.sh/formula/imagemagick).

### Usage
Download this repository and extract `convert.sh` to a convenient location.

If you like, you can make the script executable with `chmod +x convert.sh`.

Make a folder named `src` in the same location as the script.

Copy all of the images you wish to convert into this `src` folder. I recommend large square images.

Run `./convert.sh` and wait!

⚠️ Make sure you run the script with at least **Bash 4**! ⚠️

All of your converted images will be in `out/*/android/*` and `out/*/ios/*`.
