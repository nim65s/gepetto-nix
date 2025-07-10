{
  toPythonModule,
  symlinkJoin,
  hpp-affordance-corba,
  hpp-baxter,
  hpp-bezier-com-traj,
  hpp-centroidal-dynamics,
  hpp-corbaserver,
  hpp-environments,
  hpp-gepetto-viewer,
  hpp-gui,
  hpp-manipulation-corba,
  hpp-plot,
  hpp-practicals,
  hpp-romeo,
  hpp-tutorial,
  hpp-universal-robot,

}:
toPythonModule (symlinkJoin {
  name = "hpp";
  paths = [
    hpp-affordance-corba
    hpp-baxter
    hpp-bezier-com-traj
    hpp-centroidal-dynamics
    hpp-corbaserver
    hpp-environments
    hpp-gepetto-viewer
    hpp-gui
    hpp-manipulation-corba
    hpp-plot
    hpp-practicals
    hpp-romeo
    hpp-tutorial
    hpp-universal-robot
  ];
})
