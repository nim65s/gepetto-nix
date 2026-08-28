# NB: this is a light version, used on shared computers
# The real one is at https://github.com/nim65s/dotfiles/tree/main/home/nim
{
  config,
  lib,
  pkgs,
  ...
}:
{
  home = {
    keyboard = {
      layout = "fr";
      variant = "ergol";
    };

    sessionVariables = {
      CMAKE_BUILD_TYPE = "RelWithDebInfo";
      CMAKE_C_COMPILER_LAUNCHER = "sccache";
      CMAKE_CXX_COMPILER_LAUNCHER = "sccache";
      CMAKE_COLOR_DIAGNOSTICS = "ON";
      CMAKE_EXPORT_COMPILE_COMMANDS = "ON";
      CMAKE_GENERATOR = "Ninja";
      CMEEL_LOG_LEVEL = "DEBUG";
      CTEST_OUTPUT_ON_FAILURE = "ON";
      CTEST_PROGRESS_OUTPUT = "ON";
      DELTA_PAGER = "less -FR";
      POETRY_VIRTUALENVS_IN_PROJECT = "true";
      RUSTC_WRAPPER = lib.getExe pkgs.sccache;
      SHELL = lib.getExe config.programs.fish.package;
      EDITOR = lib.getExe config.programs.nixvim.build.package;
      VISUAL = lib.getExe config.programs.nixvim.build.package;
    };
  };

  programs = {
    starship.enable = true;
  };
}
