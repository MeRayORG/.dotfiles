{ ...
}:

{
  config.services = {
    open-webui.enable = true;
    ollama = {
      enable = true;
      loadModels = [ 
        "qwen3:4b"
      ];
    };
  };
}