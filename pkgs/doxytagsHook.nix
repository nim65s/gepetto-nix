{
  makeSetupHook,
  writeText,
}:
makeSetupHook { name = "doxytags-hook"; } (
  writeText "doxytags-hook.sh" ''
    _doxytagsHook() {
      doxyfile=''${doxytagsDoxyfile:-$(find . -name Doxyfile)}

      if [[ ! -f $doxyfile ]]
      then
          echo "doxytagsHook error: no Doxyfile to patch"
          exit 1
      fi

      for dep in $doxytagsDeps
      do
        tagfile=$(find $dep -name \*.doxytag)

        if [[ -f $tagfile ]]
        then
          mkdir -p doc

          echo "TAGFILES += $tagfile=$(dirname $tagfile)" >> $doxyfile
        else
          echo "doxytagsHook error: can't find a .doxytag in $dep"
          exit 1
        fi
      done
    }

    postConfigureHooks+=(_doxytagsHook)
  ''
)
