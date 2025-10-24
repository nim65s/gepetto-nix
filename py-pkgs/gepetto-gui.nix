{
  toPythonModule,
  gepetto-viewer,
  gepetto-viewer-corba,
  hpp-gepetto-viewer,
  hpp-gui,
}:
toPythonModule (
  gepetto-viewer.withPlugins [
    gepetto-viewer-corba
    hpp-gepetto-viewer
    hpp-gui
  ]
)
