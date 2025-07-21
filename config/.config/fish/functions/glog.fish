function glog --wraps='git --no-pager log' --description 'alias glog git --no-pager log'
  git --no-pager log $argv
        
end
