function puturifromplayerctlinplaylist --wraps='playerctl metadata | rg "url" | awk \'{print $3}\' | uridecode | sed "s&file:///home/bart/Music/&&g" >> lubiane042025.m3u' --description 'alias puturifromplayerctlinplaylist playerctl metadata | rg "url" | awk \'{print $3}\' | uridecode | sed "s&file:///home/bart/Music/&&g" >> lubiane042025.m3u'
  playerctl metadata | rg "url" | awk '{print $3}' | uridecode | sed "s&file:///home/bart/Music/&&g" >> lubiane042025.m3u $argv
        
end
