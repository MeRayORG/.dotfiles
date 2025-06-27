{ lib
, ...
}:{
    rounding = 8;
    active_opacity = 0.75;
    inactive_opacity = 0.7;

    blur = {
      enabled = true;
      size = 8;
      passes = 2;
    };

    shadow = {
      enabled = true;
      offset = "0 3";
      range = 25;
      render_power = 4;
      color = "rgba(0,0,0,0.4)";
    }; 
}