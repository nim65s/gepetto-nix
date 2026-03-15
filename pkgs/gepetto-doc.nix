{
  buildEnv,

  # eigen,
  # keep-sorted start
  aig,
  aligator,
  biped-stabilizer,
  coal,
  crocoddyl,
  eiquadprog,
  flex-joints,
  hpp-affordance,
  hpp-baxter,
  hpp-bezier-com-traj,
  hpp-centroidal-dynamics,
  hpp-constraints,
  hpp-core,
  hpp-doc,
  hpp-environments,
  hpp-gepetto-viewer,
  hpp-gui,
  hpp-manipulation,
  hpp-manipulation-urdf,
  hpp-pinocchio,
  hpp-plot,
  hpp-practicals,
  hpp-romeo,
  hpp-statistics,
  hpp-tools,
  hpp-tutorial,
  hpp-universal-robot,
  hpp-util,
  multicontact-api,
  ndcurves,
  pinocchio,
  proxsuite,
  python3Packages,
  tsid,
# keep-sorted end
}:

buildEnv {
  name = "gepetto-doc";
  paths = [
    # eigen
    # keep-sorted start
    aig
    aligator
    biped-stabilizer
    coal
    crocoddyl
    eiquadprog
    flex-joints
    hpp-affordance
    hpp-baxter
    hpp-bezier-com-traj
    hpp-centroidal-dynamics
    hpp-constraints
    hpp-core
    hpp-doc
    hpp-environments
    hpp-gepetto-viewer
    hpp-gui
    hpp-manipulation
    hpp-manipulation-urdf
    hpp-pinocchio
    hpp-plot
    hpp-practicals
    hpp-romeo
    hpp-statistics
    hpp-tools
    hpp-tutorial
    hpp-universal-robot
    hpp-util
    multicontact-api
    ndcurves
    pinocchio
    proxsuite
    python3Packages.eigenpy
    tsid
    # keep-sorted end
  ];
  pathsToLink = [ "/share/doc" ];
  extraOutputsToInstall = [ "doc" ];
}
