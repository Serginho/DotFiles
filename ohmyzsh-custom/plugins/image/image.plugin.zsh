# Image optimization
autoload -U convertpng

function convertpng() {
	if [ -z "$1" ]; then
		echo "Usage: $0 [filename]";
	else 
		imagemin --plugin.pngquant.quality={0.1,0.2} "$1.png"  > "$1-op.png";
		mv "$1-op.png" "$1.png";
		echo "Converted $1.png";
	fi
}

