{
  deadnix,
  nixfmt,
  nurl,
  python3,
  writeShellApplication,
}:
writeShellApplication {
  name = "gazebo2nix";
  runtimeInputs = [
    deadnix
    nixfmt
    nurl
    (python3.withPackages (p: [
      p.case-converter
      p.catkin-pkg
      p.jinja2
      p.pygithub
      p.pyyaml
    ]))
  ];
  text = ''
    python ${../bin/gazebo2nix.py} "$@"
  '';
}
