if status is-interactive
    # Commands to run in interactive sessions can go here
end


function searchpl
    grep -w -i -o $argv ~/Projects/Archsystem/words_in_polish_lang
end

set -gx MANPAGER "nvim -c 'Man!' -o -"
set -gx DELTA_PAGER "nvim -c \"lua require('util').colorize()\""
set -gx PAGER "nvim -c \"lua require('util').colorize()\""
set -gx EDITOR nvim

function nvm
    bass source /usr/share/nvm/init-nvm.sh --no-use ';' nvm $argv
end


starship init fish | source
