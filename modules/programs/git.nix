set @ { 
    mkHome,
    pkgs, 
    ... 
}: {
    environment.systemPackages = with pkgs; [
        libsecret
        gitFull
    ];

    programs.git.enable = true;
} // mkHome set {
    programs.git = {
        enable = true;
        userName = "MeRay";
        userEmail = "git@meray.org";

        extraConfig = {
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

