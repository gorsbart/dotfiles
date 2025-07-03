function uridecode --wraps="awk -niord '{printf RT?(0xsubstr(RT,2)):}' RS=%.." --wraps='awk -niord \'{printf RT?("0x"substr(RT,2)):}\' RS=%..' --wraps='awk -niord \'{printf RT?$0chr("0x"substr(RT,2)):$0}\' RS=%..' --description 'alias uridecode awk -niord \'{printf RT?$0chr("0x"substr(RT,2)):$0}\' RS=%..'
  awk -niord '{printf RT?$0chr("0x"substr(RT,2)):$0}' RS=%.. $argv
        
end
