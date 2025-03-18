{ inputs, config, pkgs, ... }:
let
  user = config.hostUser;
  secretspath = builtins.toString inputs.nix-secrets;
in
{
  users.users."${user}" = {
    home = /Users/${user};
    shell = pkgs.fish;
    description = "${user}";
    uid = 501;
  };
  users.knownUsers = [ "${user}" ];

  # darwin linux builder
  nix.linux-builder = {
    enable = true;
    ephemeral = true;
    maxJobs = 4;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 6 * 1024;
        };
        cores = 4;
      };
    };
  };
  nix.settings.trusted-users = [ "@admin" ];
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # TODO: Move out
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  # programs
  programs = {
    fish = {
      enable = true;
      vendor.completions.enable = true;
      vendor.config.enable = true;
      vendor.functions.enable = true;
    };
  };

  # home manager
  home-manager.useGlobalPkgs = true;
  home-manager.users."${user}" = import ./home.nix;

  # system packages - TODO: Move out
  environment.systemPackages = with pkgs; [
    # GUI
    # CMD
    just
    home-manager
    neovim
    discordo
  ];

  # homebrew
  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    caskArgs = {
      no_quarantine = true;
      # require_sha = true;
    };

    brews = [
      "mas"
    ];
    casks = [
      "alfred"
      "audio-hijack"
      "balenaetcher"
      "batfi"
      "bettertouchtool"
      "bitwarden"
      "cameracontroller"
      "crystalfetch"
      "deskpad"
      "figma"
      "font-sf-pro"
      "ghostty"
      "ia-presenter"
      "iina"
      "jordanbaird-ice"
      "libreoffice"
      "logi-options+"
      "mac-mouse-fix"
      "moonlight"
      "microsoft-edge"
      "miro"
      "neovide"
      "obs"
      "obsidian"
      "pearcleaner"
      "rawtherapee"
      "screen-studio"
      "sf-symbols"
      "the-unarchiver"
      "alex313031-thorium" # Thorium browser
      "utm"
#      "vimcal"
      "viscosity"
      "vscodium"
      "zen-browser"
    ];
    masApps = {
      A4Obsidian = 1659667937;
      Cursor = 1447043133;
      Dato = 1470584107;
      Drafts = 1435957248;
      FolderHub = 6473019059;
      Infuse = 1136220934;
      Photomator = 1444636541;
      Pixelmator = 1289583905;
      Xcode = 497799835;
    };
    taps = [];
  };

  fonts.packages = [];

  # firewall
  system.defaults.alf = {
    globalstate = 2;
    stealthenabled = 1;
  };

  # networking
  networking = {
    hostName = config.hostMachineName;
    computerName = config.networking.hostName;
    localHostName = config.networking.hostName;
    knownNetworkServices = [
      "Wi-Fi"
      "Thunderbolt Bridge"
    ];
    dns = [
      "9.9.9.9"
      "1.1.1.1"
    ];
  };
  system.defaults.smb = {
    NetBIOSName = config.networking.hostName;
    ServerDescription = config.networking.hostName;
  };

  # power
  power = {
    restartAfterFreeze = true;
    sleep.computer = 2; # Screensaver
    sleep.display = 6; # Display
    sleep.harddisk = 10;
  };
  # screen lock settings
  system.defaults.CustomUserPreferences."com.apple.screensaver" = {
    askForPassword = 1;
    askForPasswordDelay = 0;
  };
  # control center
  system.defaults.controlcenter = {
    BatteryShowPercentage = true;
    FocusModes = true;
  };
  # defaults - dock
  system.defaults.dock = {
    autohide = true;
    autohide-delay = 0.1;
    autohide-time-modifier = 0.1;
    enable-spring-load-actions-on-all-items = false;
    expose-animation-duration = 0.1;
    mineffect = "scale";
    minimize-to-application = true;
    mru-spaces = false;
    orientation = "bottom";
    persistent-apps = [
      "/System/Applications/Mail.app"
      "/Applications/Zen.app"
      "/Applications/Microsoft Edge.app"
      "/Applications/Thorium.app"
      "/Applications/Ghostty.app"
      "/System/Applications/Reminders.app"
      "/Applications/Obsidian.app"
      "/Applications/Miro.app"
      "/System/Applications/Photos.app"
      "/Applications/Photomator.app"
      "/Applications/Pixelmator Pro.app"
      
      "/Applications/Neovide.app"
    ];
    scroll-to-open = true;
    show-recents = false;
    showhidden = true;
    tilesize = 48;
    wvous-br-corner = 5; # bottom-right corner starts screensaver
    wvous-tr-corner = 2; # top-right corner show windows
  };
  # defaults - finder
  system.defaults.finder = {
    _FXShowPosixPathInTitle = true;
    _FXSortFoldersFirst = true;
    _FXSortFoldersFirstOnDesktop = true;
    AppleShowAllExtensions = true;
    FXDefaultSearchScope = "SCcf"; # scope search to current folder
    FXEnableExtensionChangeWarning = false;
    FXPreferredViewStyle = "clmv"; # column view
    FXRemoveOldTrashItems = true;
    ShowExternalHardDrivesOnDesktop = false;
    ShowHardDrivesOnDesktop = false;
    ShowPathbar = true;
    ShowRemovableMediaOnDesktop = true;
    ShowStatusBar = true;
  };
  # finder - user options
  system.defaults.CustomUserPreferences."com.apple.finder" = {
    _FXSortFoldersFirst = true;
    _FXSortFoldersFirstOnDesktop = true;
    FinderSpawnTab = true;
    FXDefaultSearchScope = "SCcf";
    NewWindowTarget = "PfHm"; # new windows open in home dir
    NewWindowTargetPath = "file:///Users/${user}/";
    WarnOnEmptyTrash = false;
  };
  # system defaults
  system.defaults.NSGlobalDomain = {
    # Repeat character while key held instead of showing character accents menu
    ApplePressAndHoldEnabled = false;
    InitialKeyRepeat = 15;
    KeyRepeat = 2;
    "com.apple.sound.beep.feedback" = 0;
    # "com.apple.sound.beep.volume" = 0.5;
    AppleFontSmoothing = 0;
    AppleInterfaceStyle = "Dark";
    AppleKeyboardUIMode = 3;
    AppleScrollerPagingBehavior = true;
    AppleShowAllExtensions = true;
    AppleShowScrollBars = "WhenScrolling";
    NSNavPanelExpandedStateForSaveMode = true;
    # AppleActionOnDoubleClick = "Maximize"; # TODO
    "com.apple.trackpad.enableSecondaryClick" = true;
    NSTableViewDefaultSizeMode = 3; # large finder sidebar icons
    NSWindowResizeTime = 0.001; # faster window resizing
  };
  # defaults - trackpad
  system.defaults.trackpad = {
    TrackpadRightClick = true;
    Clicking = true;
    TrackpadThreeFingerDrag = true;
  };
  system.defaults.CustomUserPreferences."com.apple.AppleMultitouchTrackpad".DragLock = true;
  # defaults - screencapture
  system.defaults.screencapture = {
    location = "Clipboard";
    disable-shadow = true;
  };
  # defaults - activity monitor
  system.defaults.ActivityMonitor = {
    IconType = 6; # CPU history in dock icon
    SortColumn = "CPUUsage";
    SortDirection = 0; # descending
  };

  # prevent creation of .DS_Store files
  system.defaults.CustomUserPreferences."com.apple.desktopservices" = {
    DSDontWriteNetworkStores = true;
    DSDontWriteUSBStores = true;
  };

  # ads
  system.defaults.CustomUserPreferences."com.apple.AdLib" = {
    allowApplePersonalizedAdvertising = false;
    allowIdentifierForAdvertising = false;
  };

  # disable Time Machine new disk prompts
  system.defaults.CustomUserPreferences."com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;

  # disable window tiling margins
  system.defaults.CustomUserPreferences."com.apple.WindowManager".EnableTiledWindowMargins = 0;

  # screen dimming delay in seconds
  system.defaults.CustomUserPreferences."com.apple.BezelServices".kDimTime = 5;

  # disable power chime sound
  system.defaults.CustomUserPreferences."com.apple.PowerChime".ChimeOnNoHardware = false;

  # auto-quit printer app after jobs complete
  system.defaults.CustomUserPreferences."com.apple.print.PrintingPrefs"."Quit When Finished" = true;

  # disable Siri data sharing
  system.defaults.CustomUserPreferences."com.apple.assistant.support"."Search Queries Data Sharing Status" = 2;

  # defaults - disable guest
  system.defaults.loginwindow.GuestEnabled = false;

  # leverage nix-homebrew flake
  nix-homebrew = {
    enable = true;
    user = "aarbour";
  };

  # enable touch for sudo
#  security.pam.enableSudoTouchIdAuth = true; -- disabled in favor of Yubikey
/*
  # sops
  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    age = {
      sshKeyPaths = ["/Users/aarbour/.ssh/id_ed25519"]; # TODO: Fix me
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      example_key = {
        neededForUsers = true;
      };
    };
  };
*/
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.enable = false;
  nix.package = pkgs.nix;

####### DO NOT TOUCH #######
  system.stateVersion = 5;
####### DO NOT TOUCH #######
}
