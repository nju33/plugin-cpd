function cpd --description 'Change to parent-sibling directory'
  if test (count $argv) -eq 0
    printf ( _ "%s: Required target directory name\n") cpd
    return 1
  end

  set -l target_dir $argv[1]
  set -l current_dir (pwd)
  set -l wd $current_dir
  set -l found false

  while test "$wd" != '/' -a $found = false
    cd ..
    set wd (pwd)

    set -l dirs (ls -F | grep / | tr -d '/')
    for dir in $dirs
      if test "$target_dir" = "$dir"
        set found true
        break
      end
    end
  end

  if test $found = false
    printf ( _ "%s: Target directory not found\n") cpd
    cd $current_dir
    return 1
  end

  if test "$wd" != "/"
    set wd {$wd}/
  end
  set -l dir_path {$wd}{$target_dir}
  cd $dir_path
end
