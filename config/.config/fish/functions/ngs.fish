function ngs --wraps='prime-run gamescope -W 2560 -H 1440 --prefer-vk-device 1002:1638 -f --force-grab-cursor -- ' --wraps='prime-run gamescope -W 2560 -H 1440 --prefer-vk-device 1002:1638 -f --force-grab-cursor -s 1.7 -- ' --description 'alias ngs prime-run gamescope -W 2560 -H 1440 --prefer-vk-device 1002:1638 -f --force-grab-cursor -s 1.7 -- '
  prime-run gamescope -W 2560 -H 1440 --prefer-vk-device 1002:1638 -f --force-grab-cursor -s 1.7 --  $argv
        
end
