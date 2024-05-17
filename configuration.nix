# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # splashImage = ./streetlight.png;
      # theme = pkgs.nixos-grub2-theme;
      extraEntries = ''
        menuentry "Reboot" {
            reboot
        }
        menuentry "Poweroff" {
            halt
        }
      '';
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "latam";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.prot = {
    isNormalUser = true;
    description = "prot";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Variables de entorno
  environment.variables = {

    # Necesaria para ejecutar Wayfire e Hyprland (en una VM)
    # WLR_RENDERER_ALLOW_SOFTWARE = 1;
    # "QT_STYLE_OVERRIDE" = pkgs.lib.mkForce "Numix-SX-FullDark";
    # GTK_THEME="Carbon";
  };

  # Remueve los paquetes de las generaciones con 30 días de antigüedad cada semana
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    git
    nixfmt-rfc-style # Formateador de código nix para vscode
    numix-sx-gtk-theme
    # lounge-gtk-theme
    # kanagawa-gtk-theme
    # andromeda-gtk-theme
    tango-icon-theme
    # paper-icon-theme
    # elementary-xfce-icon-theme
    where-is-my-sddm-theme
    htop
    conky
    remind
    wlrctl
    neofetch
    terminator
    # pcmanfm
    lxqt.pcmanfm-qt
    kanshi
    mako
    libnotify
    remind
    swayidle
    swaylock
    swaybg
    swayidle
    wlopm
    # wlogout
    nwg-bar # Alternativa de wlogout
    networkmanagerapplet
    copyq
    waybar
    # sfwbar
    wofi
    # nwg-drawer  # Alternativa de wofi
    grim
    lxqt.lxqt-policykit
    xdg-user-dirs
    pwvucontrol
    pamixer
    galculator
    xfce.mousepad
    xfce.catfish
    abiword
    # gnome.file-roller
    xarchiver
    mate.eom
    mate.atril
    gimp
    gparted
    firefox
    vlc

    # Aplica un fondo a la pantalla de inicio de sesión en el tema predefinido
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = toString ./streetlight.png;
        backgroundMode = "fill";
      };
    })

    # Instala visual studio code junto con sus extensiones
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        ms-ceintl.vscode-language-pack-es
        brettm12345.nixfmt-vscode
        bbenoist.nix
      ];
    })
  ];

  # Habilitar tema por defecto para aplicaciones Qt
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "adwaita-dark";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.xserver.enable = true;

  # Cambia la resolución global de la pantalla (opción para display manager)
  # IMPORTANTE: Modificar el valor de output por el nombre del monitor principal
  services.xserver.xrandrHeads = [
    {
      output = "HDMI-A-1";
      monitorConfig = ''
        Option "PreferredMode" "1280x960"
      '';
    }
  ];

  # Habilita sddm display manager
  services.displayManager.sddm = {
    enable = true;
    theme = "where_is_my_sddm_theme";
    package = pkgs.kdePackages.sddm;
  };

  # Habilita Enlightenment
  # services.xserver.desktopManager.enlightenment.enable = true;

  # Servicio de enlightenment
  # services.acpid.enable = true;

  # Permite que la papelera se visualice correctamente en el escritorio
  services.gvfs.enable = true;

  # Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

  # Habilita el servicio pipewire (sonido del sistema)
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Habilita Hyprland (dynamic tiling wayland compositor)
  # programs.hyprland.enable = true;

  # Habilita Sway
  # programs.sway.enable = true;

  # Habilita labwc
  programs.labwc.enable = true;

  # Habilita Wayfire (no funciona con lightdm; se debe activar sddm display manager)
  # programs.wayfire = {
  #   enable = true;
  #   plugins = with pkgs.wayfirePlugins; [
  #     wcm
  #     wf-shell
  #     wayfire-plugins-extra
  #   ];
  # };

  # Necesario para habilitar gtk-themes en home-manager
  programs.dconf.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
