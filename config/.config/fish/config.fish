if status is-interactive
    # Commands to run in interactive sessions can go here
end


function searchpl
    grep -w -i -o $argv ~/Projects/Archsystem/words_in_polish_lang
end

set -x MANPAGER "nvim -c 'Man!' -o -"
set -x DELTA_PAGER "nvim -c \"lua require('util').colorize()\""
set -x PAGER "nvim -c \"lua require('util').colorize()\""

function nvm
    bass source /usr/share/nvm/init-nvm.sh --no-use ';' nvm $argv
end
