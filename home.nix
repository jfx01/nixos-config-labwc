{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "prot";
  home.homeDirectory = "/home/prot";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    font.name = "unifont 12";
    theme = {
      name = "Carbon";
      # name = "Numix-SX-FullDark";
      # package = pkgs.numix-sx-gtk-theme;

      # name = "Lounge-night-compact";
      # package = pkgs.lounge-gtk-theme;

      # name = "Kanagawa-BL";
      # package = pkgs.kanagawa-gtk-theme;

      # name = "Andromeda";
      # package = pkgs.andromeda-gtk-theme;
    };

    iconTheme = {
      name = "CBPP";
      # name = "elementary-xfce-darker";
      # package = pkgs.elementary-xfce-icon-theme;

      # name = "Paper";
      # package = pkgs.paper-icon-theme;

      # name = "Tango";
      # package = pkgs.tango-icon-theme;
    };
  };

  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "browser.startup.homepage" = "about:home";
            "browser.search.defaultenginename" = "Google";
            "browser.search.order.1" = "Google";
            "ui.systemUsesDarkTheme" = true;
            "browser.newtabpage.enabled" = true;
            "browser.newtabpage.activity-stream.topSitesRows" = 2;
            "browser.newtabpage.pinned" = [
              {
                "label" = "NixOS Packages";
                "url" = "https://search.nixos.org/packages";
              }
              {
                "label" = "NixOS Options";
                "url" = "https://search.nixos.org/options";
              }
              {
                "label" = "Home Manager Options";
                "url" = "https://nix-community.github.io/home-manager/options.xhtml";
              }
              {
                "label" = "NixOS & Flakes Book";
                "url" = "https://nixos-and-flakes.thiscute.world/";
              }
            ];
          };
          search = {
            force = true;
            default = "Google";
            order = [
              "Google"
              "Duckduckgo"
            ];
          };
        };
      };
    };
  };

  # Enlaces simbólicos de archivos de configuración desde /etc/nixos/config hacia ~/.config
  # (Recarga en caliente: no es necesario re-empaquetar el sistema; simplemente se debe
  # modificar el archivo en cuestión)
  home = {
    # labwc configs files
    file = {
      ".config/labwc" = {
        source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/labwc;
        recursive = true;
      };
    };

    # kanshi configs files
    file = {
      ".config/kanshi" = {
        source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/kanshi;
        recursive = true;
      };
    };

    # waybar configs files
    file = {
      ".config/waybar" = {
        source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/waybar;
        recursive = true;
      };
    };

    # terminator configs files
    file = {
      ".config/terminator" = {
        source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/terminator;
        recursive = true;
      };
    };

    # pcmanfm-qt configs files
    file = {
      ".config/pcmanfm-qt" = {
        source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/pcmanfm-qt;
        recursive = true;
      };
    };

    # mako configs files
    file = {
      ".config/mako" = {
        source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/mako;
        recursive = true;
      };
    };

    # conky configs files
    file = {
      ".config/conky" = {
        source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/conky;
        recursive = true;
      };
    };

    # remind configs files
    file = {
      ".config/remind" = {
        source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/remind;
        recursive = true;
      };
    };

    # mousepad configs files
    file = {
      ".config/mousepad" = {
        source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/mousepad;
        recursive = true;
      };
    };
  };
}
