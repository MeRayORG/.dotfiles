{ pkgs
, config
, mkHome
, ...
}:{
    environment.systemPackages = with pkgs; [
        libsecret
        gitFull
    ];

    programs.git.enable = true;
} // mkHome config {
    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "MeRay";
                email = "git@meray.org";
            };
            
            credential = {
                helper = "${pkgs.gitFull}/bin/git-credential-libsecret";
            };
            pull = {
                ff = "only";
                rebase = "true";
            };
            push = {
                autoSetupRemote = "true";
                default = "current";
            };
            init = {
                defaultBranch = "main";
            };
        
        };
    };
}

