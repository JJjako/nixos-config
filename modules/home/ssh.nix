{ ... }:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "1h";
    controlMaster = "auto";
    controlPath = "~/.ssh/control-%r@%h:%p";
    controlPersist = "10m";
    matchBlocks = {
      "*" = {
        addKeysToAgent = "1h";

        controlMaster = "auto";
        controlPath = "~/.ssh/control-%r@%h:%p";
        controlPersist = "10m";

        forwardAgent = false;
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };

      github = {
        host = "github.com";
        hostname = "ssh.github.com";
        user = "git";
        port = 443;
        identityFile = "~/.ssh/id_github";
        identitiesOnly = true;
      };
      JAP = {
        host = "JAP";
        hostname = "192.168.178.194";
        user = "wro";
        identityFile = "~/.ssh/id_jap";
        identitiesOnly = true;
      };
    };
  };
  services.ssh-agent.enable = true;
}