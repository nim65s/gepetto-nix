{
  lib,
  buildRosPackage,
  fetchFromGitHub,

  # nativeBuildInputs
  ament-cmake,

  # propagatedBuildInputs

  # checkInputs
  ament-lint-auto,
  ament-lint-common,
}:
buildRosPackage {
  pname = "ros-humble-omni-drive-controller";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "jpgtzg";
    repo = "omni_drive_controller";
    rev = "842b49a9562433ca14ecb02c83eecded0fb9047a";
    hash = "sha256-FodEDCvg2dOpPHYNKWKRIp0xXAo2EdfcT4JTuwN8NsQ=";
  };

  buildType = "ament_cmake";

  nativeBuidInputs = [
    ament-cmake
  ];
  propagatedBuidInputs = [
  ];
  checkInputs = [
    ament-lint-auto
    ament-lint-common
  ];

  doCheck = true;

  meta = {
    description = "TODO: Package description";
    license = with lib.licenses; [ unfree ];
    homepage = "https://github.com/jpgtzg/omni_drive_controller";
    platforms = lib.platforms.linux;
    maintainers = [ lib.maintainers.nim65s ];
  };
}
