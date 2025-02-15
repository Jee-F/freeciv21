# CPack configuration file

# General Configuration for all OS's
set(CPACK_PACKAGE_NAME "Freeciv21")
set(CPACK_PACKAGE_VENDOR "longturn.net")
set(CPACK_PACKAGE_VERSION_MAJOR ${FREECIV21_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${FREECIV21_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${FREECIV21_VERSION_PATCH})
set(CPACK_PACKAGE_VERSION ${FREECIV21_VERSION})
set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Freeciv21 - Freeciv for the 21st Century")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://longturn.net")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/COPYING")
set(CPACK_PACKAGE_CHECKSUM "SHA256")

if(WIN32 OR MSYS OR MINGW)

  # Use the NSIS Package Tool same as classic Freeciv
  set(CPACK_GENERATOR "NSIS")

  # The variable is not set on MSYS2, so we force it.
  if(NOT CPACK_SYSTEM_NAME)
    set(CPACK_CPU_ARCH $ENV{MSYSTEM_CARCH})
    set(CPACK_SYSTEM_NAME "${CMAKE_SYSTEM_NAME}-${CPACK_CPU_ARCH}")
  endif()

  # Set some package specific variables...
  #   Where to save the package exe at build time
  set(CPACK_PACKAGE_DIRECTORY "${CMAKE_BINARY_DIR}/${CPACK_SYSTEM_NAME}")
  #   The name of the package exe file
  set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-v${CPACK_PACKAGE_VERSION}-${CPACK_SYSTEM_NAME}")
  #   This is a combo variable. Used on welcome screen to introduce the project and also sets
  #   the install directory.
  set(CPACK_OUTPUT_FILE_PREFIX ${CPACK_PACKAGE_DIRECTORY})

  ## Component definition
  #  - variable names are UPPER CASE, even if component names are lower case
  #  - components/groups are ordered alphabetically by component/group name; groups always come first
  #  - empty (e.g. OS-specific) components are discarded automatically

  # Define the components and how they are organized in the install package
  set(CPACK_COMPONENTS_ALL freeciv21 tool_ruledit tool_fcmp_cli tool_ruleup tool_manual translations)
  #set(CPACK_ALL_INSTALL_TYPES Default)
  set(CPACK_COMPONENT_FREECIV21_INSTALL_TYPES Default Custom)
  set(CPACK_COMPONENT_FREECIV21_REQUIRED)
  set(CPACK_COMPONENT_TOOL_RULEDIT_INSTALL_TYPES Custom)
  set(CPACK_COMPONENT_TOOL_FCMP_CLI_INSTALL_TYPES Custom)
  set(CPACK_COMPONENT_TOOL_RULEUP_INSTALL_TYPES Custom)
  set(CPACK_COMPONENT_TOOL_MANUAL_INSTALL_TYPES Custom)
  set(CPACK_COMPONENT_TRANSLATIONS_INSTALL_TYPES Default Custom)

  set(CPACK_COMPONENT_TOOL_FCMP_CLI_GROUP "Tools")
  set(CPACK_COMPONENT_TOOL_RULEDIT_GROUP "Tools")
  set(CPACK_COMPONENT_TOOL_RULEUP_GROUP "Tools")
  set(CPACK_COMPONENT_TOOL_MANUAL_GROUP "Tools")
  set(CPACK_COMPONENT_GROUP_TOOLS_DESCRIPTION
    "All of the tools you'll ever need to support Freeciv21 game play.")
  set(CPACK_COMPONENT_GROUP_TOOLS_EXPANDED)

  # Define the names of the components and how they are displayed
  set(CPACK_COMPONENT_FREECIV21_DISPLAY_NAME "Freeciv21")
  set(CPACK_COMPONENT_TOOL_RULEDIT_DISPLAY_NAME "Ruleset Editor")
  set(CPACK_COMPONENT_TOOL_FCMP_CLI_DISPLAY_NAME "Modpack Installer CLI Edition")
  set(CPACK_COMPONENT_TOOL_RULEUP_DISPLAY_NAME "Ruleset Upgrade Tool")
  set(CPACK_COMPONENT_TOOL_MANUAL_DISPLAY_NAME "Server Manual Tool")
  set(CPACK_COMPONENT_TRANSLATIONS_DISPLAY_NAME "Languages")

  ## Generator-specific configuration ##

  # NSIS (Windows .exe installer)
  set(CPACK_NSIS_MUI_ICON "${CMAKE_SOURCE_DIR}/dist/client.ico")
  set(CPACK_NSIS_MUI_UNIICON "${CMAKE_SOURCE_DIR}/dist/client.ico")
  set(CPACK_NSIS_INSTALLED_ICON_NAME "${CMAKE_SOURCE_DIR}/dist/client.ico")
  set(CPACK_NSIS_HELP_LINK "${CPACK_PACKAGE_HOMEPAGE_URL}")
  set(CPACK_NSIS_URL_INFO_ABOUT "${CPACK_PACKAGE_HOMEPAGE_URL}")
  set(CPACK_NSIS_MENU_LINKS "${CPACK_PACKAGE_HOMEPAGE_URL}" "Longturn Homepage")
  set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL "OFF")
  set(CPACK_NSIS_MODIFY_PATH "OFF")
  set(CPACK_NSIS_CONTACT "longturn.net@gmail.com")

  set(CPACK_NSIS_COMPRESSOR "/SOLID lzma") # zlib|bzip2|lzma
  set(CPACK_NSIS_COMPRESSOR "${CPACK_NSIS_COMPRESSOR}\n  SetCompressorDictSize 64") # hack (improve compression)
  set(CPACK_NSIS_COMPRESSOR "${CPACK_NSIS_COMPRESSOR}\n  BrandingText '${CPACK_PACKAGE_DESCRIPTION_SUMMARY}'") # hack (overwrite BrandingText)

endif()

message("-- Including CPack")
include(CPack)
