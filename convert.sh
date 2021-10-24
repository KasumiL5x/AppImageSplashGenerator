#!/usr/local/bin/bash

out_path=./out

# [folder:size]
declare -A android_sizes
android_sizes["drawable"]=480x800
android_sizes["drawable-hdpi"]=480x800
android_sizes["drawable-land"]=800x480
android_sizes["drawable-land-hdpi"]=800x480
android_sizes["drawable-land-ldpi"]=320x200
android_sizes["drawable-land-mdpi"]=480x320
android_sizes["drawable-land-xhdpi"]=1280x720
android_sizes["drawable-land-xxhdpi"]=1600x960
android_sizes["drawable-land-xxxhdpi"]=1920x1280
android_sizes["drawable-ldpi"]=200x320
android_sizes["drawable-mdpi"]=320x480
android_sizes["drawable-xhdpi"]=720x1280
android_sizes["drawable-xxhdpi"]=960x1600
android_sizes["drawable-xxxhdpi"]=1280x1920

# [file:size]
declare -A ios_sizes
ios_sizes["LaunchImage-568h@2x~iphone_640x1136"]=640x1136
ios_sizes["LaunchImage-750@2x~iphone6-landscape_1334x750"]=1334x750
ios_sizes["LaunchImage-750@2x~iphone6-portrait_750x1334"]=750x1334
ios_sizes["LaunchImage-828@2x~iphoneXr-portrait_828x1792"]=828x1792
ios_sizes["LaunchImage-1125@3x~iphoneX-portrait_1125x2436"]=1125x2436
ios_sizes["LaunchImage-1242@3x~iphone6s-landscape_2208x1242"]=2208x1242
ios_sizes["LaunchImage-1242@3x~iphone6s-portrait_1242x2208"]=1242x2208
ios_sizes["LaunchImage-1242@3x~iphoneXsMax-portrait_1242x2688"]=1242x2688
ios_sizes["LaunchImage-1792@2x~iphoneXr-landscape_1792x828"]=1792x828
ios_sizes["LaunchImage-2436@3x~iphoneX-landscape_2436x1125"]=2436x1125
ios_sizes["LaunchImage-2688@3x~iphoneXsMax-landscape_2688x1242"]=2688x1242
ios_sizes["LaunchImage-Landscape@2x~ipad_2048x1496"]=2048x1496
ios_sizes["LaunchImage-Landscape@2x~ipad_2048x1536"]=2048x1536
ios_sizes["LaunchImage-Landscape@2x~ipad_2224x1668"]=2224x1668
ios_sizes["LaunchImage-Landscape@2x~ipad_2732x2048"]=2732x2048
ios_sizes["LaunchImage-Landscape~ipad_1024x748"]=1024x748
ios_sizes["LaunchImage-Landscape~ipad_1024x768"]=1024x768
ios_sizes["LaunchImage-Portrait@2x~ipad_1536x2008"]=1536x2008
ios_sizes["LaunchImage-Portrait@2x~ipad_1536x2048"]=1536x2048
ios_sizes["LaunchImage-Portrait@2x~ipad_1668x2224"]=1668x2224
ios_sizes["LaunchImage-Portrait@2x~ipad_2048x2732"]=2048x2732
ios_sizes["LaunchImage-Portrait~ipad_768x1024"]=768x1024
ios_sizes["LaunchImage"]=768x1004
ios_sizes["LaunchImage~ipad"]=1536x2008
ios_sizes["LaunchImage~iphone_640x960"]=640x960
ios_sizes["LaunchImage~iphone-320x480"]=320x480

for src_filepath in src/*; do
	# Extract filename and extension (https://stackoverflow.com/a/965072).
	src_filename=$(basename -- "$src_filepath")
	src_filename="${src_filename%.*}"
	src_fileext="${src_filepath##*.}"
	echo Processing $src_filename.$src_fileext

	# Get pixel color at 0,0 to be used as the background.
	bg_color=\#`magick $src_filepath -format "%[hex:p{0,0}]" info:`
	echo -e '  'Using background color $bg_color

	# Process Android files.
	echo -e "  Generating Android files..."
	out_android=$out_path/$src_filename/android
	for android_key in ${!android_sizes[@]}; do
		echo -e -n '    '$android_key...

		# Make the folder before we run imagemagick.
		mkdir -p $out_android/$android_key

		output_file=$out_android/$android_key/screen.png
		output_size=${android_sizes[${android_key}]}

		magick convert $src_filepath -resize $output_size -gravity center -background $bg_color -extent $output_size $output_file
		echo "done!"
	done
	echo -e "  Finished generating Android files."

	# Process iOS files.
	echo -e "  Generating iOS files..."
	out_ios=$out_path/$src_filename/ios
	mkdir -p $out_ios
	for ios_key in ${!ios_sizes[@]}; do
		echo -e -n '    '$ios_key...

		output_file=$out_ios/$ios_key.png
		output_size=${ios_sizes[${ios_key}]}

		magick convert $src_filepath -resize $output_size -gravity center -background $bg_color -extent $output_size $output_file

		echo "done!"
	done
	echo -e "  Finished generating iOS files."
done

echo "Finished!"