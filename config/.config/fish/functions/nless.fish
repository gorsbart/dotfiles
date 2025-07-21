function nless --wraps='nvim -c "lua require(\'util\').colorize()"' --description 'alias nless nvim -c "lua require(\'util\').colorize()"'
  nvim -c "lua require('util').colorize()" $argv
        
end
