{ src
, fips
, lib
, stdenv
, fetchFromGitHub
, python3
, cmake
, ninja
}:

stdenv.mkDerivation {
  name = "sokol-tools";

  inherit src;

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
