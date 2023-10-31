{ sokol-src, sokol-tools-src, fips-src, handmade-math-src, ... }:
final: prev: {
  sokol = prev.sokol.overrideAttrs {
    name = "sokol";
    src = sokol-src;
  };

  handmade-math = prev.callPackage ./packages/handmade-math.nix { src = handmade-math-src; };

  sokol-tools = prev.callPackage ./packages/sokol-tools.nix { src = sokol-tools-src; fips = fips-src; };
}
