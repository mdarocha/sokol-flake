final: prev: {
  sokol = prev.sokol.overrideAttrs {
    version = "unstable-2023-08-04";
    src = prev.fetchFromGitHub {
      owner = "floooh";
      repo = "sokol";
      rev = "47d92ff86298fc96b3b84d93d0ee8c8533d3a2d2";
      sha256 = "sha256-TsM5wK9a2ectrAY8VnrMPaxCNV3e1yW92SBBCHgs+0k=";
    };
  };

  handmade-math = prev.callPackage ./packages/handmade-math.nix { };

  sokol-tools = prev.callPackage ./packages/sokol-tools.nix { };
}
