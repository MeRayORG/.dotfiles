{ pkgs
, ...
}:
{
  config = {
    environment.systemPackages = with pkgs; [ 
      openssh
      ssh-agents
    ];
    programs.ssh.startAgent = true;

  };
}