{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "HandmadeMath";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "HandmadeMath";
    repo = "HandmadeMath";
    rev = "v2.0.0";
    hash = "sha256-hmQXZRqgJOztvqmekRRnuF8bjPF3ZczKDfCVZv4aDvY=";
  };

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/include/
    cp HandmadeMath.h $out/include/HandmadeMath.h

    runHook postInstall
  '';

  meta = with lib; {
    description = "A simple math library for games and computer graphics";
    homepage = "https://github.com/HandmadeMath/HandmadeMath";
    license = licenses.cc0;
    platforms = platforms.all;
  };
}
