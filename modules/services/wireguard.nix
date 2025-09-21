{ ...
}:
{
  networking = {
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          ips = [
            "100.0.0.21/32"
          ];
          peers = [
            {
              allowedIPs = [
                "10.0.0.0/24"
                "10.10.0.0/24"
              ];
              endpoint = "meray.org:51820";
              publicKey = "uN8kGaqv7Yb6NByTeMGy2a582nPnEA4ZAA3AiLEWaQs=";
            }
          ];
          privateKeyFile = "/opt/secrets/wireguard/privatekey";  
        };
      };
    };
  };
}