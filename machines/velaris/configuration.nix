{ config, pkgs, ... }:
let
  user = config.hostUser;
in
{
  users.users."${user}" = {
    home = /Users/${user};
    description = "_";
  };

  # TODO: Move out
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;
  
  # programs
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = false; # slow

  # home manager
  home-manager.useGlobalPkgs = true;
  home-manager.users."${user}" = import ./home.nix;

  # system packages - TODO: Move out
  environment.systemPackages = with pkgs; [
    # GUI
    zed-editor
    obsidian
    # CMD
    just
    neovim
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
      "ghostty"
      "iina"
      "the-unarchiver"
    ];
    masApps = {
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
    sleep.computer = 20;
    sleep.display = 5;
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
    WarnOnEmptyTrash = false;
    NewWindowTarget = "PfHm"; # new windows open in home dir
    _FXSortFoldersFirst = true;
    _FXSortFoldersFirstOnDesktop = true;
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
  security.pam.enableSudoTouchIdAuth = true;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.enable = false;  # Disabled because we're using Determinate's installation
  
####### DO NOT TOUCH #######
  system.stateVersion = 5;
####### DO NOT TOUCH #######
}