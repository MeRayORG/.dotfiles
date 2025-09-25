{ ...
}:
{
  networking = {
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          ips = [
            "10.100.10.21/32"
          ];
          peers = [
            {
              name = "TX";
              persistentKeepalive = 25;
              allowedIPs = [
                "10.0.0.0/16"
                "10.10.0.0/16"
                "10.100.0.10/32"
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