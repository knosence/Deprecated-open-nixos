# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = "PaulineSeays_NixLT"; # Define your hostname.

    # useDHCP = false;
    interfaces.enp1s0.useDHCP = true;
    # wireless.enable = false;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "mononoki";
    keyMap = "us";
  };

  # Enable the Plasma 5 Desktop Environment.
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbOptions = "eurosign:e";

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # Video Drivers for intel
    videoDrivers = [ "modesetting" ];
    useGlamor = true;
    # videoDrivers = [ "intel" ];
    # deviceSection = ''
    # Option "DPI" "2"
    # Option "TearFree" "true"
    # '';

    # Video Drivers for Nvidia
    # videoDrivers = [ "nvidia" ];
  };

  services = {
    tlp.enable = true;
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
    mononoki
];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.PaulineSeays = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # Allow packages with non-free licenses.
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    firefox
    neovim
    git
    brave
    nodejs
    python3
    etcher
    tree
    gimp
    networkmanager
    xclip
    vlc
    alacritty
    libreoffice-qt
    thunderbird
    fish
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    fish.enable = true;
    mtr.enable = true;
  };

  # List services that you want to enable:

 nix = {
  gc = {
    options = "--delete-older-than 8d";
    automatic = true;
  };
  optimise.automatic = true;
 };

 


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    stateVersion = "unstable"; # Did you read the comment?
    autoUpgrade = {
      enable = true;
      allowReboot = true;
    };
  };
}
