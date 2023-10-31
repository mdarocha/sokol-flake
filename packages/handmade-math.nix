{ src, lib, stdenv }:

stdenv.mkDerivation {
  pname = "HandmadeMath";
  version = "2.0.0";

  inherit src;

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
