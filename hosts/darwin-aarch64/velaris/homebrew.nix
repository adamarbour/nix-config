{ ... }:
{
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
}