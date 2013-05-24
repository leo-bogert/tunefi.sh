#!/bin/bash
if ! source "lib-bash-leo.sh" ; then
    echo 'lib-bash-leo.sh is missing in PATH!'
    exit 1
fi

INPUT_DIR_ABSOLUTE=''
OUTPUT_DIR_ABSOLUTE=''


main() {
	obtain_two_parameters_as_inputdir_output_dir "$@"

	stderr "WARNING: iTunes sucks and we do not recommend using it!"

	for release in "$INPUT_DIR_ABSOLUTE"/* ; do
		if [ ! -d "$release" ] ; then
			continue
		fi
		
		local release_name
		local out_dir
		release_name="$(basename "$release")"
		out_dir="$OUTPUT_DIR_ABSOLUTE/$release_name"

		
		stdout "Encoding $release_name ..."

		if [ -d "$out_dir" ] ; then
			stderr "ERROR: Output dir exists already: $out_dir"
			continue
		fi

		mkdir -p -- "$out_dir"
		set_working_directory_or_die "$out_dir"

		for flac in "$release"/*.flac ; do
			alac="$(basename "$flac" '.flac')"'.m4a'
			avconv -loglevel error -i "$flac" -codec alac "$out_dir/$alac"
		done

		set_working_directory_or_die "$release"
		for otherfile in * ; do
			case "$otherfile" in
				'Artwork'|'Cover.jpg'|'Proof of Quality'|'README.txt'|'TODO.txt')
					stdout "Copying $otherfile to output dir..."
					# Don't preserve ownership so this works on top of CIFS mounts. Don't preserve mode because the existing mode might be insecure with the default ownership.
					cp -ai --no-preserve=mode,ownership -- "$otherfile" "$OUTPUT_DIR_ABSOLUTE/$release_name"
					;;
				*.flac)
					;;
				*)
					stderr "ERROR: Unknown file in input directory: $otherfile"					;;
			esac
		done

		stdout ''
		stdout ''
	done
	
	exit 0 # SUCCESS
}

main "$@"
