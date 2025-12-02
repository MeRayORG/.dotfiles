{...}:
[

", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
", XF86AudioMute       , exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

", XF86MonBrightnessUp  , exec, brightnessctl +10"
", XF86MonBrightnessDown, exec, brightnessctl 10-"
]
