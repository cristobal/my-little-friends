#! /usr/bin/env bash

# by torstein.k.johansen@gmail.com

src_dir=$HOME/put_the_new_pictures_in_here
target_dir=/var/gallery
error_dir=$HOME/picture-import/error
log_file=$HOME/picture-import/log/$(basename $0 .sh).log

if [ $(which identify 2>/dev/null | wc -l) -eq 0 ]; then
  echo "You need imagemagick installed to use $(basename $0) :-("
  exit 1
fi

function print_and_log() {
  echo "$@" >> $log_file
  echo $@
}

function create_dir_for_picture() {
  if [ $(file $1 | cut -d':' -f2 | grep empty | wc -l) -gt 0 ]; then
    print_and_log "The file" $1 "is empty :-( moving it to $error_dir"
    mv $1 $error_dir
    return 1
  fi
  
  local date_dir=$(identify -format "%[EXIF:DateTimeOriginal]" $1 | \
    cut -d' ' -f1 | \
    sed 's#:#/#g')

  local picture_dir=$target_dir/$date_dir

  if [ ! -d $picture_dir ]; then
    mkdir -p $picture_dir
  fi

  print_and_log "Moving $1 -> $picture_dir ..."
  mv $1 $picture_dir/
}


find $src_dir -iname "*.jpg" | while read f; do
  create_dir_for_picture $f
done