//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <native_pdf_renderer/native_pdf_renderer_plugin.h>
#include <uni_links_desktop/uni_links_desktop_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  NativePdfRendererPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("NativePdfRendererPlugin"));
  UniLinksDesktopPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UniLinksDesktopPlugin"));
}
