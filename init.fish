# SYNOPSIS
#   fcd
#   fh
#   fls

function init -a path --on-event init_fzf
    __fzf_init
end

function fcd -d "Fuzzily change directory"
  __fzf_cd
end

function fh -d "Fuzzily browse command history and return selection"
  __fzf_history
end

function fls -d "Fuzzily browse file listings and return selection"
  __fzf_files
end

function uninstall --on-event uninstall_fzf
end

function __fzf_init
  # Due to a bug of fish, we cannot use command substitution,
  # so we use temporary file instead
  if [ -z "$TMPDIR" ]
    set -g TMPDIR /tmp
  end

  function __fzf_escape
    while read item
      echo -n (echo -n "$item" | sed -E 's/([ "$~'\''([{<>})])/\\\\\\1/g')' '
    end
  end

  function __fzf_history
    history | eval (__fzfcmd) +s +m --tiebreak=index --toggle-sort=ctrl-r > $TMPDIR/fzf.result
    and commandline (cat $TMPDIR/fzf.result)
    commandline -f repaint
    rm -f $TMPDIR/fzf.result
  end

  function __fzf_files
    set -q FZF_CTRL_T_COMMAND; or set -l FZF_CTRL_T_COMMAND "
    command find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
      -o -type f -print \
      -o -type d -print \
      -o -type l -print 2> /dev/null | sed 1d | cut -b3-"
    eval "$FZF_CTRL_T_COMMAND | "(__fzfcmd)" -m > $TMPDIR/fzf.result"
    and commandline -i (cat $TMPDIR/fzf.result | __fzf_escape)
    commandline -f repaint
    rm -f $TMPDIR/fzf.result
  end

  function __fzf_cd
    # Fish hangs if the command before pipe redirects (2> /dev/null)
    command find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) \
      -prune -o -type d -print 2> /dev/null | sed 1d | cut -b3- | eval (__fzfcmd) +m > $TMPDIR/fzf.result
    [ (cat $TMPDIR/fzf.result | wc -l) -gt 0 ]
    and cd (cat $TMPDIR/fzf.result)
    commandline -f repaint
    rm -f $TMPDIR/fzf.result
  end

  function __fzfcmd
    set -q FZF_TMUX; or set FZF_TMUX 1
    if [ $FZF_TMUX -eq 1 ]
      if set -q FZF_TMUX_HEIGHT
        echo "fzf-tmux -d$FZF_TMUX_HEIGHT"
      else
        echo "fzf-tmux -d40%"
      end
    else
      echo "fzf"
    end
  end
end
