{ lib
, stdenv
, fetchFromGitHub
, python3
, cmake
, ninja
}:

let
  fips = fetchFromGitHub {
    owner = "floooh";
    repo = "fips";
    rev = "36ae6b60a5d6d8c6a5661f8cf56b474c28d9bdaa";
    hash = "sha256-sRIlQsnSJz8klmhoSlw7CdW+RQONH8YL4dbF0U9by6k=";
  };
in
stdenv.mkDerivation {
  pname = "sokol-tools";
  version = "unstable-2023-10-22";

  src = fetchFromGitHub {
    owner = "floooh";
    repo = "sokol-tools";
    rev = "9cdfb422bccd207b94cfde80c98d491e69c9814c";
    hash = "sha256-7gO6FUs9J7S03qnvaTgkt4Uc8j86ZbCC7blr+2pVFLw=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    python3
    cmake
    ninja
  ];

  configurePhase = ''
    runHook preConfigure

    mkdir -p /build/fips/
    cp -r ${fips}/* /build/fips/

    python3 fips set config linux-ninja-release

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    python3 fips build linux-ninja-release

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -m 755 -D /build/fips-deploy/source/linux-ninja-release/sokol-shdc $out/bin/sokol-shdc

    runHook postInstall
  '';

  meta = with lib; {
    description = "Command line tools for use with sokol headers";
    homepage = "https://github.com/floooh/sokol-tools";
    licenses = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "sokol-shdc";
  };
}
