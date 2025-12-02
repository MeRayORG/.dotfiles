{ pkgs
, config
, mkHome
, ...
}:
let
  colors = config.mods.theme.catppuccin.colors;
in{
    environment.systemPackages = with pkgs; [
        wofi
    ];
} // mkHome config {
    xdg.configFile."wofi/style.css".text = ''
      * {
        font-family: 'Inconsolata Nerd Font', monospace;
        font-size: 14px;
      }

      /* Window */
      window {
        margin: 0px;
        padding: 10px;aa
        border-radius: 10px;
        background-color: ${builtins.replaceStrings ["rgb" ")"] ["rgba" ", 0.8f)"] colors.base-rgb};
        /* animation: slideIn 0.5s ease-in-out both; */
      }

      /* Slide In */
      @keyframes slideIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      /* Inner Box */
      #inner-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: ${colors.base};
        /* animation: fadeIn 0.5s ease-in-out both; */
      }

      /* Fade In */
      @keyframes fadeIn {
        0% {
           opacity: 0;
        }

        100% {
           opacity: 1;
        }
      }

      /* Outer Box */
      #outer-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: ${colors.base};
      }

      /* Scroll */
      #scroll {
        margin: 0px;
        padding: 10px;
        border: none;
        background-color: ${colors.base};
      }

      /* Input */
      #input {
        margin: 5px 20px;
        padding: 10px;
        border: 2px solid ${colors.lavender};
        border-radius: 10px;
        color: ${colors.text};
        background-color: ${colors.base};
        /* animation: fadeIn 0.5s ease-in-out both; */
      }

      #input image {
        border: none;
        color: ${colors.red};
      }

      #input * {
        outline: 4px solid ${colors.red}!important;
      }

      /* Text */
      #text {
        margin: 5px;
        border: none;
        color: ${colors.text};
        /* animation: fadeIn 0.5s ease-in-out both; */
      }

      #entry {
        background-color: ${colors.base};
      }

      #entry arrow {
        border: none;
        color: ${colors.lavender};
      }

      /* Selected Entry */
      #entry:selected arrow {
        overflow: hidden;
        color: ${colors.mauve};
      }

      #entry:selected {
        border: 1px solid ${colors.lavender};
        border-radius: 10px;
      }

      #entry:selected #text {
        color: ${colors.mauve};
      }

      #entry:drop(active) {
        background-color: ${colors.lavender}!important;
      }
    '';

}