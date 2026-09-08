{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  extra-cmake-modules,
  nix-update-script,
  cava,
  qt6Packages,
  python3Packages,
  kdePackages,
  autoPatchelfHook,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "plasma-audio-visualizer";
  version = "3.6.1";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "luisbocanegra";
    repo = "plasma-audio-visualizer";
    tag = "v${finalAttrs.version}";
    hash = "sha256-mrEcO7okpGzcKiZi0rz2Run8kBR9wx8yY5E9zROtNas=";
  };

  dontWrapQtApps = true;

  cmakeFlags = [
    "-DINSTALL_PLASMOID=ON"
    "-DBUILD_PLUGIN=ON"
  ];

  nativeBuildInputs = [
    cmake
    kdePackages.extra-cmake-modules
    autoPatchelfHook
  ];

  buildInputs = [
    qt6Packages.qtwebsockets
    python3Packages.websockets
    kdePackages.libplasma
  ];

  runtimeDependencies = [
    cava
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Audio visualizer widget powered by CAVA for the KDE Plasma Desktop";
    homepage = "https://github.com/luisbocanegra/plasma-audio-visualizer";
    changelog = "https://github.com/luisbocanegra/plasma-audio-visualizer/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ Kladki ];
  };
})
