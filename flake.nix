{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/develop";
    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.follows = "nix-ros-overlay/nixpkgs";
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.follows = "nix-ros-overlay/flake-utils/systems";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # keep-sorted start block=yes

    src-agimus-controller = {
      url = "github:agimus-project/agimus_controller";
      flake = false;
    };
    src-agimus-msgs = {
      url = "github:agimus-project/agimus_msgs";
      flake = false;
    };
    src-colmpc = {
      url = "github:agimus-project/colmpc";
      flake = false;
    };
    src-example-parallel-robots = {
      url = "github:gepetto/example-parallel-robots";
      flake = false;
    };
    src-franka-description = {
      url = "github:agimus-project/franka_description";
      flake = false;
    };
    src-franka-ros2 = {
      # url = "github:agimus-project/franka_ros2";
      url = "github:nim65s/franka_ros2/harmonic";
      flake = false;
    };
    # gepetto-viewer has a fix to understand AMENT_PREFIX_PATH in #239/devel
    src-gepetto-viewer = {
      url = "github:Gepetto/gepetto-viewer/devel";
      flake = false;
    };
    src-odri-control-interface = {
      # TODO url = "github:open-dynamic-robot-initiative/odri_control_interface"; see https://github.com/open-dynamic-robot-initiative/odri_control_interface/pull/26
      url = "github:gwennlbh/odri_control_interface/nix";
      flake = false;
    };
    src-odri-masterboard-sdk = {
      url = "github:gwennlbh/master-board/nix";
      flake = false;
      # TODO: sparse checkout
    };
    src-toolbox-parallel-robots = {
      url = "github:gepetto/toolbox-parallel-robots";
      flake = false;
    };

    # keep-sorted end
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { self, lib, ... }:
      let
        flakeModule = inputs.flake-parts.lib.importApply ./module.nix { localFlake = self; };
      in
      {
        systems = import inputs.systems;
        imports = [ flakeModule ];
        flake = {
          inherit flakeModule;
          systemConfigs.default = inputs.system-manager.lib.makeSystemConfig {
            modules = [
              inputs.nix-system-graphics.systemModules.default
              ./modules/system-manager/direnv.nix
              {
                config = {
                  nixpkgs.hostPlatform = "x86_64-linux";
                  programs.direnv = {
                    enable = true;
                    nix-direnv.enable = true;
                  };
                  system-graphics.enable = true;
                };
              }
            ];
          };
          templates.default = {
            path = ./template;
            description = "A template for use with gepetto/nix";
          };
        };
        perSystem =
          {
            inputs',
            pkgs,
            self',
            system,
            ...
          }:
          {

            devShells = {
              default = pkgs.mkShell {
                name = "Gepetto Main Dev Shell";
                packages = [
                  # keep-sorted start
                  pkgs.colcon
                  self'.packages.python
                  self'.packages.ros
                  # keep-sorted end
                ];
              };
              hpp = pkgs.mkShell {
                name = "dev shell for HPP";
                CMAKE_C_COMPILER_LAUNCHER = "ccache";
                CMAKE_CXX_COMPILER_LAUNCHER = "ccache";
                CMAKE_GENERATOR = "Unix Makefiles";
                ROS_PACKAGE_PATH = "${pkgs.example-robot-data}/share";
                shellHook = ''
                  export DEVEL_HPP_DIR=$(pwd -P)
                  mkdir -p $DEVEL_HPP_DIR/{src,install}
                  export INSTALL_HPP_DIR=$DEVEL_HPP_DIR/install
                  export PATH=$INSTALL_HPP_DIR/bin:$PATH
                  export LD_LIBRARY_PATH=$INSTALL_HPP_DIR/lib
                  export PYTHONPATH=$INSTALL_HPP_DIR/${pkgs.python3.sitePackages}
                  export GEPETTO_GUI_PLUGIN_DIRS=$INSTALL_HPP_DIR/lib/gepetto-gui-plugins
                  export HPP_PLUGIN_DIRS=$INSTALL_HPP_DIR/lib/hppPlugins
                '';
                packages =
                  with pkgs;
                  [
                    assimp
                    ccache
                    cddlib
                    clp
                    cmake
                    console-bridge
                    doxygen
                    eigen
                    glpk
                    graphviz
                    jrl-cmakemodules
                    libGL
                    libsForQt5.full
                    octomap
                    openscenegraph
                    osgqt
                    pkg-config
                    (python3.withPackages (
                      p: with p; [
                        lxml
                        numpy
                        omniorb
                        omniorbpy
                        python-qt
                        scipy
                        (toPythonModule rosPackages.rolling.xacro)
                      ]
                    ))
                    python3Packages.boost
                    qhull
                    qpoases
                    tinyxml-2
                    urdfdom
                    zlib
                  ]
                  ++ lib.optionals stdenv.isLinux [
                    psmisc
                  ];
              };
              hpp-bin = pkgs.mkShell {
                packages = [
                  (pkgs.python3.withPackages (p: [
                    p.gepetto-gui
                    p.hpp-corba
                  ]))
                ];
              };
              gs = pkgs.mkShell {
                name = "Dev Shell for Guilhem";
                packages = [
                  (pkgs.rosPackages.jazzy.python3.withPackages (p: [
                    p.bloom
                    p.rosdep
                  ]))
                ];
              };
              ms = pkgs.mkShell {
                name = "Dev Shell for Maxime";
                inputsFrom = [ pkgs.python3Packages.crocoddyl ];
                packages = [
                  (pkgs.python3.withPackages (p: [
                    # keep-sorted start
                    p.example-parallel-robots
                    p.fatrop
                    p.gepetto-gui
                    p.ipython
                    p.matplotlib
                    p.mim-solvers
                    p.opencv4
                    p.pandas
                    p.proxsuite
                    p.quadprog
                    p.scikit-learn
                    p.seaborn
                    # keep-sorted end
                  ]))
                ];
                shellHook = ''
                  export PYTHONPATH=${
                    lib.concatStringsSep ":" [
                      "$PWD/src/cobotmpc"
                      "$PWD/install/${pkgs.python3.sitePackages}"
                      "$PYTHONPATH"
                    ]
                  }
                '';
              };
            };
            packages = lib.filterAttrs (_n: v: v.meta.available && !v.meta.broken) (
              {
                python = pkgs.python3.withPackages (p: [
                  # keep-sorted start
                  p.agimus-controller
                  p.agimus-controller-examples
                  p.crocoddyl
                  p.gepetto-gui
                  p.hpp-corba
                  p.ipython
                  p.matplotlib
                  # keep-sorted end
                ]);
                ros =
                  with pkgs.rosPackages.humble;
                  buildEnv {
                    paths = [
                      # keep-sorted start
                      pkgs.python3Packages.example-robot-data # for availability in AMENT_PREFIX_PATH
                      pkgs.python3Packages.hpp-tutorial # for availability in AMENT_PREFIX_PATH
                      ros-core
                      turtlesim
                      # keep-sorted end
                    ];
                  };
                gz-harmonic = pkgs.rosPackages.jazzy.buildEnv {
                  name = "gz-harmonic";
                  postBuild = ''
                    rosWrapperArgs+=(--set QT_QPA_PLATFORM_PLUGIN_PATH ${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins/platforms)
                  '';
                  paths = with pkgs.gazebo.harmonic; [
                    # keep-sorted start
                    pkgs.qt5.wrapQtAppsHook
                    gz-cmake
                    gz-common
                    gz-fuel-tools
                    gz-gui
                    gz-launch
                    gz-math
                    gz-msgs
                    gz-physics
                    gz-plugin
                    gz-rendering
                    gz-sensors
                    gz-sim
                    gz-tools
                    gz-transport
                    gz-utils
                    sdformat
                    # keep-sorted end
                  ];
                };
                # TODO: kilted
                gz-ionic = pkgs.rosPackages.jazzy.buildEnv {
                  name = "gz-ionic";
                  postBuild = ''
                    rosWrapperArgs+=(--set QT_QPA_PLATFORM_PLUGIN_PATH ${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins/platforms)
                  '';
                  paths = with pkgs.gazebo.ionic; [
                    # keep-sorted start
                    pkgs.qt5.wrapQtAppsHook
                    gz-cmake
                    gz-common
                    gz-fuel-tools
                    gz-gui
                    gz-launch
                    gz-math
                    gz-msgs
                    gz-physics
                    gz-plugin
                    gz-rendering
                    gz-sensors
                    gz-sim
                    gz-tools
                    gz-transport
                    gz-utils
                    sdformat
                    # keep-sorted end
                  ];
                };
              }
              // lib.optionalAttrs (system == "x86_64-linux") {
                system-manager = inputs'.system-manager.packages.default;
              }
              // {
                inherit (pkgs)
                  # keep-sorted start
                  aligator
                  colmpc
                  crocoddyl
                  dart
                  example-robot-data
                  gazebo2nix
                  gepetto-viewer
                  # gz-harmonic
                  hpp-affordance
                  hpp-affordance-corba
                  hpp-baxter
                  hpp-bezier-com-traj
                  hpp-centroidal-dynamics
                  hpp-constraints
                  hpp-corbaserver
                  hpp-core
                  hpp-doc
                  hpp-environments
                  hpp-gepetto-viewer
                  hpp-gui
                  hpp-manipulation
                  hpp-manipulation-corba
                  hpp-manipulation-urdf
                  hpp-pinocchio
                  hpp-plot
                  hpp-practicals
                  hpp-romeo
                  hpp-statistics
                  hpp-template-corba
                  hpp-tutorial
                  hpp-universal-robot
                  hpp-util
                  mim-solvers
                  odri-control-interface
                  odri-masterboard-sdk
                  pinocchio
                  ros2nix
                  # keep-sorted end
                  ;
              }
              // lib.mapAttrs' (n: lib.nameValuePair "py-${n}") {
                inherit (pkgs.python3Packages)
                  # keep-sorted start
                  aligator
                  brax
                  colmpc
                  crocoddyl
                  example-parallel-robots
                  example-robot-data
                  gepetto-gui
                  hpp-affordance-corba
                  hpp-corba
                  hpp-corbaserver
                  hpp-doc
                  hpp-environments
                  hpp-gepetto-viewer
                  hpp-gui
                  hpp-manipulation-corba
                  hpp-plot
                  hpp-practicals
                  hpp-python
                  hpp-romeo
                  hpp-tutorial
                  hpp-universal-robot
                  mim-solvers
                  pinocchio
                  platypus
                  sensitivity
                  toolbox-parallel-robots
                  # keep-sorted end
                  ;
              }
              // lib.mapAttrs' (n: lib.nameValuePair "gz-harmonic-${n}") (
                lib.optionalAttrs (system == "x86_64-linux") {
                  inherit (pkgs.gazebo.harmonic)
                    # keep-sorted start
                    gz-cmake
                    gz-cmake3
                    gz-common
                    gz-common5
                    gz-fuel-tools
                    gz-fuel-tools9
                    gz-gui
                    gz-gui8
                    gz-launch
                    gz-launch7
                    gz-math
                    gz-math7
                    gz-msgs
                    gz-msgs10
                    gz-physics
                    gz-physics7
                    gz-plugin
                    gz-plugin2
                    gz-rendering
                    gz-rendering8
                    gz-sensors
                    gz-sensors8
                    gz-sim
                    gz-sim8
                    gz-tools
                    gz-tools2
                    gz-transport
                    gz-transport13
                    gz-utils
                    gz-utils2
                    sdformat
                    sdformat14
                    # keep-sorted end
                    ;

                }
              )
              // lib.mapAttrs' (n: lib.nameValuePair "gz-ionic-${n}") (
                lib.optionalAttrs (system == "x86_64-linux") {
                  inherit (pkgs.gazebo.ionic)
                    # keep-sorted start
                    gz-cmake
                    gz-common
                    gz-fuel-tools
                    gz-gui
                    gz-launch
                    gz-math
                    gz-msgs
                    gz-physics
                    gz-plugin
                    gz-rendering
                    gz-sensors
                    gz-sim
                    gz-tools
                    gz-transport
                    gz-utils
                    sdformat
                    # keep-sorted end
                    ;
                }
              )

              // lib.mapAttrs' (n: lib.nameValuePair "ros-noetic-${n}") (
                lib.optionalAttrs (system == "x86_64-linux") {
                  inherit (pkgs.rosPackages.noetic)
                    # keep-sorted start
                    rosbag
                    rospy
                    # keep-sorted end
                    ;
                }
              )
              // lib.mapAttrs' (n: lib.nameValuePair "ros-humble-${n}") {
              }
              // lib.mapAttrs' (n: lib.nameValuePair "ros-jazzy-${n}") {
                inherit (pkgs.rosPackages.jazzy)
                  # keep-sorted start
                  agimus-controller-ros
                  agimus-msgs
                  linear-feedback-controller
                  linear-feedback-controller-msgs
                  # keep-sorted end
                  ;
              }

            );
            treefmt = {
              settings.global.excludes = [
                ".envrc"
                ".git-blame-ignore-revs"
                "LICENSE"
              ];
              programs = {
                # keep-sorted start
                mdformat.enable = true;
                yamlfmt.enable = true;
                # keep-sorted end
              };
            };
          };
      }
    );
}
