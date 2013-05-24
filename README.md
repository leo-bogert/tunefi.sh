tunefi.sh
=========

A batch-transcoder script for converting FLAC files encoded with perfect-flac-batch-encode to ALAC.
Suitable for satisfying iTunes users who cannot playback FLAC because Apple decided to ignore open standards.

Installation
=============

# download code signing key of leo:
gpg --recv-key 15173ECBBC720C9EF4205805B26BE43E4B5EAD69

# install dependancy: ALAC encoder
apt-get install libav-tools

# install dependancy: shell-tools:
git clone https://github.com/leo-bogert/shell-tools ~/.bin/shell-tools
cd ~/.bin/shell-tools
# now we find out what the latest version is:
git tag --list
# we verify the gnupg tag of that version and check out that version:
git verify-tag <latest version tag>
git checkout <latest version tag>

# install tunefi.sh
git clone https://github.com/leo-bogert/tunefi.sh ~/.bin/tunefi.sh
cd ~/.bin/tunefi.sh
# now we find out what the latest version is:
git tag --list
# we verify the gnupg tag of that version and check out that version:
git verify-tag <latest version tag>
git checkout <latest version tag>

# add to $PATH so you can execute it from anywhere:
cp -ai .bashrc .bashrc.default
nano .bashrc
		# append to end of file:
		PATH="$PATH:$HOME/.bin/shell-tools:$HOME/.bin/tunefi.sh"

Usage
=====

tunefi.sh <input directory> <output directory>

Output
======
For each folder in the input directory, tunefish encodes all FLACs in that folder to a folder in the output directory.
The folder in the output dir will have the same name as the folder in the input dir.
Each folder typically represents a music album.

The following files/directories are copied over from the input directory if they exist:
- Artwork
- Cover.jpg
- Proof of Quality
- README.txt
- TODO.txt

Any files which are NOT in that list and are NOT *.flac result in an error message. The encoding will continue though.

Author
======

Leo Bogert <github@leo.bogert.de>


Version
=======

2

Donations
=========

[bitcoin:1CD7KErT3jNU2HukSNRobe53obzVaXH8Ei](bitcoin:1CD7KErT3jNU2HukSNRobe53obzVaXH8Ei)

