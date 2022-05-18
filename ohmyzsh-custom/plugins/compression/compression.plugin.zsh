# Compress files
function compress(){
	directory=$1
	tar c $directory | pv | pixz -p 12 -0 > $directory.tar.xz
}