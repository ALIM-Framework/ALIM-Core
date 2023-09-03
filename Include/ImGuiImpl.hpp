#ifndef IMGUIIMPL_H
#define IMGUIIMPL_H

typedef struct ID3D11Device ID3D11Device;
typedef struct ID3D11DeviceContext ID3D11DeviceContext;
struct ID3D11Device;
struct ID3D11DeviceContext;

bool ImGui_ImplDX11_Init(ID3D11Device* device,ID3D11DeviceContext* device_context);
void ImGui_ImplDX11_Shutdown(void);
void ImGui_ImplDX11_NewFrame(void);
void ImGui_ImplDX11_RenderDrawData(ImDrawData* draw_data);
void ImGui_ImplDX11_InvalidateDeviceObjects(void);
bool ImGui_ImplDX11_CreateDeviceObjects(void);

#endif