// Compiled shader for custom platforms

//////////////////////////////////////////////////////////////////////////
// 
// NOTE: This is *not* a valid shader file, the contents are provided just
// for information and for debugging purposes only.
// 
//////////////////////////////////////////////////////////////////////////
// Skipping shader variants that would not be included into build of current scene.

Shader "Custom/Plasma_S" {
Properties {
 _Color ("Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Albedo (RGB)", 2D) = "white" { }
 _Glossiness ("Smoothness", Range(0.000000,1.000000)) = 0.500000
 _Metallic ("Metallic", Range(0.000000,1.000000)) = 0.000000
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="FORWARDBASE" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (208 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Vector4 _MainTex_ST at 192
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 2
Set CUBE Texture "unity_SpecCube0" to slot 1 sampler slot 0
Set CUBE Texture "unity_SpecCube1" to slot 2 sampler slot -1
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 1

Constant Buffer "FGlobals" (336 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 192
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 unity_SpecCube0_BoxMax at 48
  Vector4 unity_SpecCube0_BoxMin at 64
  Vector4 unity_SpecCube0_ProbePosition at 80
  Vector4 unity_SpecCube0_HDR at 96
  Vector4 unity_SpecCube1_BoxMax at 112
  Vector4 unity_SpecCube1_BoxMin at 128
  Vector4 unity_SpecCube1_ProbePosition at 144
  Vector4 unity_SpecCube1_HDR at 160
  Vector4 unity_ProbeVolumeParams at 176
  Vector3 unity_ProbeVolumeSizeInv at 256
  Vector3 unity_ProbeVolumeMin at 272
  Vector4 _LightColor0 at 288
  Float _Glossiness at 304
  Float _Metallic at 308
  Vector4 _Color at 320
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_SpecCube0_BoxMax;
    float4 unity_SpecCube0_BoxMin;
    float4 unity_SpecCube0_ProbePosition;
    float4 unity_SpecCube0_HDR;
    float4 unity_SpecCube1_BoxMax;
    float4 unity_SpecCube1_BoxMin;
    float4 unity_SpecCube1_ProbePosition;
    float4 unity_SpecCube1_HDR;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<float, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    texturecube<float, access::sample > unity_SpecCube1 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    bool3 u_xlatb9;
    float3 u_xlat10;
    bool3 u_xlatb11;
    float3 u_xlat12;
    float u_xlat13;
    float u_xlat24;
    float u_xlat25;
    float u_xlat36;
    float u_xlat37;
    bool u_xlatb37;
    float u_xlat38;
    float u_xlat39;
    float u_xlat40;
    bool u_xlatb40;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat1.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlatb37 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb37){
        u_xlatb37 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat4.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat4.xyz);
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat4.xyz);
        u_xlat4.xyz = u_xlat4.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat4.xyz = (bool(u_xlatb37)) ? u_xlat4.xyz : input.TEXCOORD2.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat4.yzw = u_xlat4.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat37 = fma(u_xlat4.y, 0.25, 0.75);
        u_xlat38 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat4.x = max(u_xlat37, u_xlat38);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xzw);
    } else {
        u_xlat4.x = float(1.0);
        u_xlat4.y = float(1.0);
        u_xlat4.z = float(1.0);
        u_xlat4.w = float(1.0);
    }
    u_xlat37 = dot(u_xlat4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat37 = clamp(u_xlat37, 0.0f, 1.0f);
    u_xlat38 = (-FGlobals._Glossiness) + 1.0;
    u_xlat39 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat4.xyz = fma(input.TEXCOORD1.xyz, (-float3(u_xlat39)), (-u_xlat1.xyz));
    u_xlat5.xyz = float3(u_xlat37) * FGlobals._LightColor0.xyz;
    u_xlatb37 = 0.0<FGlobals.unity_SpecCube0_ProbePosition.w;
    if(u_xlatb37){
        u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat37 = rsqrt(u_xlat37);
        u_xlat6.xyz = float3(u_xlat37) * u_xlat4.xyz;
        u_xlat7.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMax.xyz;
        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
        u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMin.xyz;
        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
        u_xlatb9.xyz = (float3(0.0, 0.0, 0.0)<u_xlat6.xyz);
        {
            float3 hlslcc_movcTemp = u_xlat7;
            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
            u_xlat7 = hlslcc_movcTemp;
        }
        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
        u_xlat37 = min(u_xlat7.z, u_xlat37);
        u_xlat7.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube0_ProbePosition.xyz);
        u_xlat6.xyz = fma(u_xlat6.xyz, float3(u_xlat37), u_xlat7.xyz);
    } else {
        u_xlat6.xyz = u_xlat4.xyz;
    }
    u_xlat37 = fma((-u_xlat38), 0.699999988, 1.70000005);
    u_xlat37 = u_xlat37 * u_xlat38;
    u_xlat37 = u_xlat37 * 6.0;
    u_xlat6 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat6.xyz, level(u_xlat37));
    u_xlat39 = u_xlat6.w + -1.0;
    u_xlat39 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat39, 1.0);
    u_xlat39 = u_xlat39 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat7.xyz = u_xlat6.xyz * float3(u_xlat39);
    u_xlatb40 = FGlobals.unity_SpecCube0_BoxMin.w<0.999989986;
    if(u_xlatb40){
        u_xlatb40 = 0.0<FGlobals.unity_SpecCube1_ProbePosition.w;
        if(u_xlatb40){
            u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
            u_xlat40 = rsqrt(u_xlat40);
            u_xlat8.xyz = float3(u_xlat40) * u_xlat4.xyz;
            u_xlat9.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMax.xyz;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
            u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMin.xyz;
            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
            u_xlatb11.xyz = (float3(0.0, 0.0, 0.0)<u_xlat8.xyz);
            {
                float3 hlslcc_movcTemp = u_xlat9;
                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
                u_xlat9 = hlslcc_movcTemp;
            }
            u_xlat40 = min(u_xlat9.y, u_xlat9.x);
            u_xlat40 = min(u_xlat9.z, u_xlat40);
            u_xlat9.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube1_ProbePosition.xyz);
            u_xlat4.xyz = fma(u_xlat8.xyz, float3(u_xlat40), u_xlat9.xyz);
        }
        u_xlat4 = unity_SpecCube1.sample(samplerunity_SpecCube0, u_xlat4.xyz, level(u_xlat37));
        u_xlat37 = u_xlat4.w + -1.0;
        u_xlat37 = fma(FGlobals.unity_SpecCube1_HDR.w, u_xlat37, 1.0);
        u_xlat37 = u_xlat37 * FGlobals.unity_SpecCube1_HDR.x;
        u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat37);
        u_xlat6.xyz = fma(float3(u_xlat39), u_xlat6.xyz, (-u_xlat4.xyz));
        u_xlat7.xyz = fma(FGlobals.unity_SpecCube0_BoxMin.www, u_xlat6.xyz, u_xlat4.xyz);
    }
    u_xlat37 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat37 = rsqrt(u_xlat37);
    u_xlat4.xyz = float3(u_xlat37) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat37 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat37) * u_xlat3.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = max(u_xlat36, 0.00100000005);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat13 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat13 = clamp(u_xlat13, 0.0f, 1.0f);
    u_xlat0.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat0.x * u_xlat0.x;
    u_xlat12.x = dot(u_xlat12.xx, float2(u_xlat38));
    u_xlat12.x = u_xlat12.x + -0.5;
    u_xlat24 = (-u_xlat1.x) + 1.0;
    u_xlat25 = u_xlat24 * u_xlat24;
    u_xlat25 = u_xlat25 * u_xlat25;
    u_xlat24 = u_xlat24 * u_xlat25;
    u_xlat24 = fma(u_xlat12.x, u_xlat24, 1.0);
    u_xlat25 = -abs(u_xlat36) + 1.0;
    u_xlat39 = u_xlat25 * u_xlat25;
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat25 = u_xlat25 * u_xlat39;
    u_xlat12.x = fma(u_xlat12.x, u_xlat25, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat24;
    u_xlat24 = u_xlat38 * u_xlat38;
    u_xlat24 = max(u_xlat24, 0.00200000009);
    u_xlat39 = (-u_xlat24) + 1.0;
    u_xlat4.x = fma(abs(u_xlat36), u_xlat39, u_xlat24);
    u_xlat39 = fma(u_xlat1.x, u_xlat39, u_xlat24);
    u_xlat36 = abs(u_xlat36) * u_xlat39;
    u_xlat36 = fma(u_xlat1.x, u_xlat4.x, u_xlat36);
    u_xlat36 = u_xlat36 + 9.99999975e-06;
    u_xlat36 = 0.5 / u_xlat36;
    u_xlat39 = u_xlat24 * u_xlat24;
    u_xlat4.x = fma(u_xlat13, u_xlat39, (-u_xlat13));
    u_xlat13 = fma(u_xlat4.x, u_xlat13, 1.0);
    u_xlat39 = u_xlat39 * 0.318309873;
    u_xlat13 = fma(u_xlat13, u_xlat13, 1.00000001e-07);
    u_xlat13 = u_xlat39 / u_xlat13;
    u_xlat36 = u_xlat36 * u_xlat13;
    u_xlat36 = u_xlat36 * 3.14159274;
    u_xlat36 = max(u_xlat36, 9.99999975e-05);
    u_xlat12.z = sqrt(u_xlat36);
    u_xlat12.xz = u_xlat1.xx * u_xlat12.xz;
    u_xlat24 = u_xlat24 * u_xlat38;
    u_xlat24 = fma((-u_xlat24), 0.280000001, 1.0);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = u_xlat1.x!=0.0;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat36 = u_xlat12.z * u_xlat1.x;
    u_xlat1.x = (-u_xlat37) + FGlobals._Glossiness;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * float3(u_xlat36);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat12.x = u_xlat0.x * u_xlat0.x;
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat0.x = u_xlat0.x * u_xlat12.x;
    u_xlat6.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat0.xyw = fma(u_xlat6.xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat5.xyz;
    u_xlat0.xyw = fma(u_xlat3.xyz, u_xlat4.xyz, u_xlat0.xyw);
    u_xlat3.xyz = u_xlat7.xyz * float3(u_xlat24);
    u_xlat1.xyw = (-u_xlat2.xyz) + u_xlat1.xxx;
    u_xlat1.xyz = fma(float3(u_xlat25), u_xlat1.xyw, u_xlat2.xyz);
    output.SV_Target0.xyz = fma(u_xlat3.xyz, u_xlat1.xyz, u_xlat0.xyw);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL LIGHTPROBE_SH 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 64
  Matrix4x4 unity_WorldToObject at 128
  Matrix4x4 unity_MatrixVP at 192
  Vector4 unity_SHBr at 0
  Vector4 unity_SHBg at 16
  Vector4 unity_SHBb at 32
  Vector4 unity_SHC at 48
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat6 = u_xlat0.y * u_xlat0.y;
    u_xlat6 = fma(u_xlat0.x, u_xlat0.x, (-u_xlat6));
    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat0.x = dot(VGlobals.unity_SHBr, u_xlat1);
    u_xlat0.y = dot(VGlobals.unity_SHBg, u_xlat1);
    u_xlat0.z = dot(VGlobals.unity_SHBb, u_xlat1);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, float3(u_xlat6), u_xlat0.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 2
Set CUBE Texture "unity_SpecCube0" to slot 1 sampler slot 0
Set CUBE Texture "unity_SpecCube1" to slot 2 sampler slot -1
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 1

Constant Buffer "FGlobals" (384 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 240
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_SHAr at 32
  Vector4 unity_SHAg at 48
  Vector4 unity_SHAb at 64
  Vector4 unity_OcclusionMaskSelector at 80
  Vector4 unity_SpecCube0_BoxMax at 96
  Vector4 unity_SpecCube0_BoxMin at 112
  Vector4 unity_SpecCube0_ProbePosition at 128
  Vector4 unity_SpecCube0_HDR at 144
  Vector4 unity_SpecCube1_BoxMax at 160
  Vector4 unity_SpecCube1_BoxMin at 176
  Vector4 unity_SpecCube1_ProbePosition at 192
  Vector4 unity_SpecCube1_HDR at 208
  Vector4 unity_ProbeVolumeParams at 224
  Vector3 unity_ProbeVolumeSizeInv at 304
  Vector3 unity_ProbeVolumeMin at 320
  Vector4 _LightColor0 at 336
  Float _Glossiness at 352
  Float _Metallic at 356
  Vector4 _Color at 368
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_OcclusionMaskSelector;
    float4 unity_SpecCube0_BoxMax;
    float4 unity_SpecCube0_BoxMin;
    float4 unity_SpecCube0_ProbePosition;
    float4 unity_SpecCube0_HDR;
    float4 unity_SpecCube1_BoxMax;
    float4 unity_SpecCube1_BoxMin;
    float4 unity_SpecCube1_ProbePosition;
    float4 unity_SpecCube1_HDR;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<float, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    texturecube<float, access::sample > unity_SpecCube1 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    float4 u_xlat9;
    float3 u_xlat10;
    bool3 u_xlatb10;
    float3 u_xlat11;
    bool3 u_xlatb12;
    float3 u_xlat13;
    float u_xlat14;
    float u_xlat26;
    float u_xlat27;
    float u_xlat39;
    float u_xlat40;
    bool u_xlatb40;
    float u_xlat41;
    bool u_xlatb41;
    float u_xlat42;
    float u_xlat43;
    bool u_xlatb43;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat1.xyz = float3(u_xlat39) * u_xlat0.xyz;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlatb40 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb40){
        u_xlatb41 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat4.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat4.xyz);
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat4.xyz);
        u_xlat4.xyz = u_xlat4.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat4.xyz = (bool(u_xlatb41)) ? u_xlat4.xyz : input.TEXCOORD2.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat4.yzw = u_xlat4.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat41 = fma(u_xlat4.y, 0.25, 0.75);
        u_xlat42 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat4.x = max(u_xlat41, u_xlat42);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xzw);
    } else {
        u_xlat4.x = float(1.0);
        u_xlat4.y = float(1.0);
        u_xlat4.z = float(1.0);
        u_xlat4.w = float(1.0);
    }
    u_xlat41 = dot(u_xlat4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat41 = clamp(u_xlat41, 0.0f, 1.0f);
    u_xlat42 = (-FGlobals._Glossiness) + 1.0;
    u_xlat4.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat4.x = u_xlat4.x + u_xlat4.x;
    u_xlat4.xyz = fma(input.TEXCOORD1.xyz, (-u_xlat4.xxx), (-u_xlat1.xyz));
    u_xlat5.xyz = float3(u_xlat41) * FGlobals._LightColor0.xyz;
    if(u_xlatb40){
        u_xlatb40 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
        u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : input.TEXCOORD2.xyz;
        u_xlat6.xyz = u_xlat6.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat6.yzw = u_xlat6.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat40 = u_xlat6.y * 0.25;
        u_xlat41 = FGlobals.unity_ProbeVolumeParams.z * 0.5;
        u_xlat43 = fma((-FGlobals.unity_ProbeVolumeParams.z), 0.5, 0.25);
        u_xlat40 = max(u_xlat40, u_xlat41);
        u_xlat6.x = min(u_xlat43, u_xlat40);
        u_xlat7 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xzw);
        u_xlat8.xyz = u_xlat6.xzw + float3(0.25, 0.0, 0.0);
        u_xlat8 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat8.xyz);
        u_xlat6.xyz = u_xlat6.xzw + float3(0.5, 0.0, 0.0);
        u_xlat6 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xyz);
        u_xlat9.xyz = input.TEXCOORD1.xyz;
        u_xlat9.w = 1.0;
        u_xlat7.x = dot(u_xlat7, u_xlat9);
        u_xlat7.y = dot(u_xlat8, u_xlat9);
        u_xlat7.z = dot(u_xlat6, u_xlat9);
    } else {
        u_xlat6.xyz = input.TEXCOORD1.xyz;
        u_xlat6.w = 1.0;
        u_xlat7.x = dot(FGlobals.unity_SHAr, u_xlat6);
        u_xlat7.y = dot(FGlobals.unity_SHAg, u_xlat6);
        u_xlat7.z = dot(FGlobals.unity_SHAb, u_xlat6);
    }
    u_xlat6.xyz = u_xlat7.xyz + input.TEXCOORD3.xyz;
    u_xlat6.xyz = max(u_xlat6.xyz, float3(0.0, 0.0, 0.0));
    u_xlat6.xyz = log2(u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat6.xyz = exp2(u_xlat6.xyz);
    u_xlat6.xyz = fma(u_xlat6.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat6.xyz = max(u_xlat6.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb40 = 0.0<FGlobals.unity_SpecCube0_ProbePosition.w;
    if(u_xlatb40){
        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat40 = rsqrt(u_xlat40);
        u_xlat7.xyz = float3(u_xlat40) * u_xlat4.xyz;
        u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMax.xyz;
        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
        u_xlat9.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMin.xyz;
        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
        u_xlatb10.xyz = (float3(0.0, 0.0, 0.0)<u_xlat7.xyz);
        {
            float4 hlslcc_movcTemp = u_xlat8;
            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
            u_xlat8 = hlslcc_movcTemp;
        }
        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
        u_xlat40 = min(u_xlat8.z, u_xlat40);
        u_xlat8.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube0_ProbePosition.xyz);
        u_xlat7.xyz = fma(u_xlat7.xyz, float3(u_xlat40), u_xlat8.xyz);
    } else {
        u_xlat7.xyz = u_xlat4.xyz;
    }
    u_xlat40 = fma((-u_xlat42), 0.699999988, 1.70000005);
    u_xlat40 = u_xlat40 * u_xlat42;
    u_xlat40 = u_xlat40 * 6.0;
    u_xlat7 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat7.xyz, level(u_xlat40));
    u_xlat41 = u_xlat7.w + -1.0;
    u_xlat41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat41, 1.0);
    u_xlat41 = u_xlat41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat8.xyz = u_xlat7.xyz * float3(u_xlat41);
    u_xlatb43 = FGlobals.unity_SpecCube0_BoxMin.w<0.999989986;
    if(u_xlatb43){
        u_xlatb43 = 0.0<FGlobals.unity_SpecCube1_ProbePosition.w;
        if(u_xlatb43){
            u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
            u_xlat43 = rsqrt(u_xlat43);
            u_xlat9.xyz = float3(u_xlat43) * u_xlat4.xyz;
            u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMax.xyz;
            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
            u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMin.xyz;
            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
            u_xlatb12.xyz = (float3(0.0, 0.0, 0.0)<u_xlat9.xyz);
            {
                float3 hlslcc_movcTemp = u_xlat10;
                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
                u_xlat10 = hlslcc_movcTemp;
            }
            u_xlat43 = min(u_xlat10.y, u_xlat10.x);
            u_xlat43 = min(u_xlat10.z, u_xlat43);
            u_xlat10.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube1_ProbePosition.xyz);
            u_xlat4.xyz = fma(u_xlat9.xyz, float3(u_xlat43), u_xlat10.xyz);
        }
        u_xlat4 = unity_SpecCube1.sample(samplerunity_SpecCube0, u_xlat4.xyz, level(u_xlat40));
        u_xlat40 = u_xlat4.w + -1.0;
        u_xlat40 = fma(FGlobals.unity_SpecCube1_HDR.w, u_xlat40, 1.0);
        u_xlat40 = u_xlat40 * FGlobals.unity_SpecCube1_HDR.x;
        u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat40);
        u_xlat7.xyz = fma(float3(u_xlat41), u_xlat7.xyz, (-u_xlat4.xyz));
        u_xlat8.xyz = fma(FGlobals.unity_SpecCube0_BoxMin.www, u_xlat7.xyz, u_xlat4.xyz);
    }
    u_xlat40 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat4.xyz = float3(u_xlat40) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat40 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat40) * u_xlat3.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat39), FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat0.xyz = float3(u_xlat39) * u_xlat0.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat14 = clamp(u_xlat14, 0.0f, 1.0f);
    u_xlat0.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat13.x = u_xlat0.x * u_xlat0.x;
    u_xlat13.x = dot(u_xlat13.xx, float2(u_xlat42));
    u_xlat13.x = u_xlat13.x + -0.5;
    u_xlat26 = (-u_xlat1.x) + 1.0;
    u_xlat27 = u_xlat26 * u_xlat26;
    u_xlat27 = u_xlat27 * u_xlat27;
    u_xlat26 = u_xlat26 * u_xlat27;
    u_xlat26 = fma(u_xlat13.x, u_xlat26, 1.0);
    u_xlat27 = -abs(u_xlat39) + 1.0;
    u_xlat41 = u_xlat27 * u_xlat27;
    u_xlat41 = u_xlat41 * u_xlat41;
    u_xlat27 = u_xlat27 * u_xlat41;
    u_xlat13.x = fma(u_xlat13.x, u_xlat27, 1.0);
    u_xlat13.x = u_xlat13.x * u_xlat26;
    u_xlat26 = u_xlat42 * u_xlat42;
    u_xlat26 = max(u_xlat26, 0.00200000009);
    u_xlat41 = (-u_xlat26) + 1.0;
    u_xlat4.x = fma(abs(u_xlat39), u_xlat41, u_xlat26);
    u_xlat41 = fma(u_xlat1.x, u_xlat41, u_xlat26);
    u_xlat39 = abs(u_xlat39) * u_xlat41;
    u_xlat39 = fma(u_xlat1.x, u_xlat4.x, u_xlat39);
    u_xlat39 = u_xlat39 + 9.99999975e-06;
    u_xlat39 = 0.5 / u_xlat39;
    u_xlat41 = u_xlat26 * u_xlat26;
    u_xlat4.x = fma(u_xlat14, u_xlat41, (-u_xlat14));
    u_xlat14 = fma(u_xlat4.x, u_xlat14, 1.0);
    u_xlat41 = u_xlat41 * 0.318309873;
    u_xlat14 = fma(u_xlat14, u_xlat14, 1.00000001e-07);
    u_xlat14 = u_xlat41 / u_xlat14;
    u_xlat39 = u_xlat39 * u_xlat14;
    u_xlat39 = u_xlat39 * 3.14159274;
    u_xlat39 = max(u_xlat39, 9.99999975e-05);
    u_xlat13.z = sqrt(u_xlat39);
    u_xlat13.xz = u_xlat1.xx * u_xlat13.xz;
    u_xlat26 = u_xlat26 * u_xlat42;
    u_xlat26 = fma((-u_xlat26), 0.280000001, 1.0);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = u_xlat1.x!=0.0;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat39 = u_xlat13.z * u_xlat1.x;
    u_xlat1.x = (-u_xlat40) + FGlobals._Glossiness;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat4.xyz = fma(u_xlat5.xyz, u_xlat13.xxx, u_xlat6.xyz);
    u_xlat5.xyz = u_xlat5.xyz * float3(u_xlat39);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat13.x = u_xlat0.x * u_xlat0.x;
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat0.x = u_xlat0.x * u_xlat13.x;
    u_xlat6.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat0.xyw = fma(u_xlat6.xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat5.xyz;
    u_xlat0.xyw = fma(u_xlat3.xyz, u_xlat4.xyz, u_xlat0.xyw);
    u_xlat3.xyz = u_xlat8.xyz * float3(u_xlat26);
    u_xlat1.xyw = (-u_xlat2.xyz) + u_xlat1.xxx;
    u_xlat1.xyz = fma(float3(u_xlat27), u_xlat1.xyw, u_xlat2.xyz);
    output.SV_Target0.xyz = fma(u_xlat3.xyz, u_xlat1.xyz, u_xlat0.xyw);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL SHADOWS_SCREEN 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (224 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 unity_WorldToObject at 80
  Matrix4x4 unity_MatrixVP at 144
  Vector4 _ProjectionParams at 0
  Vector4 _MainTex_ST at 208
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    output.TEXCOORD1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD5.zw = u_xlat0.zw;
    output.TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 3
Set 2D Texture "_ShadowMapTexture" to slot 1 sampler slot 2
Set CUBE Texture "unity_SpecCube0" to slot 2 sampler slot 0
Set CUBE Texture "unity_SpecCube1" to slot 3 sampler slot -1
Set 3D Texture "unity_ProbeVolumeSH" to slot 4 sampler slot 1

Constant Buffer "FGlobals" (432 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 80
  Matrix4x4 unity_ProbeVolumeWorldToObject at 288
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 _LightShadowData at 48
  Vector4 unity_ShadowFadeCenterAndType at 64
  Vector4 unity_SpecCube0_BoxMax at 144
  Vector4 unity_SpecCube0_BoxMin at 160
  Vector4 unity_SpecCube0_ProbePosition at 176
  Vector4 unity_SpecCube0_HDR at 192
  Vector4 unity_SpecCube1_BoxMax at 208
  Vector4 unity_SpecCube1_BoxMin at 224
  Vector4 unity_SpecCube1_ProbePosition at 240
  Vector4 unity_SpecCube1_HDR at 256
  Vector4 unity_ProbeVolumeParams at 272
  Vector3 unity_ProbeVolumeSizeInv at 352
  Vector3 unity_ProbeVolumeMin at 368
  Vector4 _LightColor0 at 384
  Float _Glossiness at 400
  Float _Metallic at 404
  Vector4 _Color at 416
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_SpecCube0_BoxMax;
    float4 unity_SpecCube0_BoxMin;
    float4 unity_SpecCube0_ProbePosition;
    float4 unity_SpecCube0_HDR;
    float4 unity_SpecCube1_BoxMax;
    float4 unity_SpecCube1_BoxMin;
    float4 unity_SpecCube1_ProbePosition;
    float4 unity_SpecCube1_HDR;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (1) ]],
    sampler sampler_ShadowMapTexture [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _ShadowMapTexture [[ texture(1) ]] ,
    texturecube<float, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    texturecube<float, access::sample > unity_SpecCube1 [[ texture(3) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    bool3 u_xlatb9;
    float3 u_xlat10;
    bool3 u_xlatb11;
    float3 u_xlat12;
    float u_xlat13;
    float u_xlat24;
    float u_xlat25;
    float u_xlat36;
    float u_xlat37;
    bool u_xlatb37;
    float u_xlat38;
    bool u_xlatb38;
    float u_xlat39;
    float u_xlat40;
    bool u_xlatb40;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat1.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat37 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat4.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat38 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat38 = sqrt(u_xlat38);
    u_xlat38 = (-u_xlat37) + u_xlat38;
    u_xlat37 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat38, u_xlat37);
    u_xlat37 = fma(u_xlat37, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat37 = clamp(u_xlat37, 0.0f, 1.0f);
    u_xlatb38 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb38){
        u_xlatb38 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat4.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat4.xyz);
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat4.xyz);
        u_xlat4.xyz = u_xlat4.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat4.xyz = (bool(u_xlatb38)) ? u_xlat4.xyz : input.TEXCOORD2.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat4.yzw = u_xlat4.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat38 = fma(u_xlat4.y, 0.25, 0.75);
        u_xlat39 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat4.x = max(u_xlat38, u_xlat39);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xzw);
    } else {
        u_xlat4.x = float(1.0);
        u_xlat4.y = float(1.0);
        u_xlat4.z = float(1.0);
        u_xlat4.w = float(1.0);
    }
    u_xlat38 = dot(u_xlat4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat4.xy = input.TEXCOORD5.xy / input.TEXCOORD5.ww;
    u_xlat39 = _ShadowMapTexture.sample(sampler_ShadowMapTexture, u_xlat4.xy).x;
    u_xlat38 = u_xlat38 + (-u_xlat39);
    u_xlat37 = fma(u_xlat37, u_xlat38, u_xlat39);
    u_xlat38 = (-FGlobals._Glossiness) + 1.0;
    u_xlat39 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat4.xyz = fma(input.TEXCOORD1.xyz, (-float3(u_xlat39)), (-u_xlat1.xyz));
    u_xlat5.xyz = float3(u_xlat37) * FGlobals._LightColor0.xyz;
    u_xlatb37 = 0.0<FGlobals.unity_SpecCube0_ProbePosition.w;
    if(u_xlatb37){
        u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat37 = rsqrt(u_xlat37);
        u_xlat6.xyz = float3(u_xlat37) * u_xlat4.xyz;
        u_xlat7.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMax.xyz;
        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
        u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMin.xyz;
        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
        u_xlatb9.xyz = (float3(0.0, 0.0, 0.0)<u_xlat6.xyz);
        {
            float3 hlslcc_movcTemp = u_xlat7;
            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
            u_xlat7 = hlslcc_movcTemp;
        }
        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
        u_xlat37 = min(u_xlat7.z, u_xlat37);
        u_xlat7.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube0_ProbePosition.xyz);
        u_xlat6.xyz = fma(u_xlat6.xyz, float3(u_xlat37), u_xlat7.xyz);
    } else {
        u_xlat6.xyz = u_xlat4.xyz;
    }
    u_xlat37 = fma((-u_xlat38), 0.699999988, 1.70000005);
    u_xlat37 = u_xlat37 * u_xlat38;
    u_xlat37 = u_xlat37 * 6.0;
    u_xlat6 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat6.xyz, level(u_xlat37));
    u_xlat39 = u_xlat6.w + -1.0;
    u_xlat39 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat39, 1.0);
    u_xlat39 = u_xlat39 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat7.xyz = u_xlat6.xyz * float3(u_xlat39);
    u_xlatb40 = FGlobals.unity_SpecCube0_BoxMin.w<0.999989986;
    if(u_xlatb40){
        u_xlatb40 = 0.0<FGlobals.unity_SpecCube1_ProbePosition.w;
        if(u_xlatb40){
            u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
            u_xlat40 = rsqrt(u_xlat40);
            u_xlat8.xyz = float3(u_xlat40) * u_xlat4.xyz;
            u_xlat9.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMax.xyz;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
            u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMin.xyz;
            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
            u_xlatb11.xyz = (float3(0.0, 0.0, 0.0)<u_xlat8.xyz);
            {
                float3 hlslcc_movcTemp = u_xlat9;
                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
                u_xlat9 = hlslcc_movcTemp;
            }
            u_xlat40 = min(u_xlat9.y, u_xlat9.x);
            u_xlat40 = min(u_xlat9.z, u_xlat40);
            u_xlat9.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube1_ProbePosition.xyz);
            u_xlat4.xyz = fma(u_xlat8.xyz, float3(u_xlat40), u_xlat9.xyz);
        }
        u_xlat4 = unity_SpecCube1.sample(samplerunity_SpecCube0, u_xlat4.xyz, level(u_xlat37));
        u_xlat37 = u_xlat4.w + -1.0;
        u_xlat37 = fma(FGlobals.unity_SpecCube1_HDR.w, u_xlat37, 1.0);
        u_xlat37 = u_xlat37 * FGlobals.unity_SpecCube1_HDR.x;
        u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat37);
        u_xlat6.xyz = fma(float3(u_xlat39), u_xlat6.xyz, (-u_xlat4.xyz));
        u_xlat7.xyz = fma(FGlobals.unity_SpecCube0_BoxMin.www, u_xlat6.xyz, u_xlat4.xyz);
    }
    u_xlat37 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat37 = rsqrt(u_xlat37);
    u_xlat4.xyz = float3(u_xlat37) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat37 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat37) * u_xlat3.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = max(u_xlat36, 0.00100000005);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat13 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat13 = clamp(u_xlat13, 0.0f, 1.0f);
    u_xlat0.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat0.x * u_xlat0.x;
    u_xlat12.x = dot(u_xlat12.xx, float2(u_xlat38));
    u_xlat12.x = u_xlat12.x + -0.5;
    u_xlat24 = (-u_xlat1.x) + 1.0;
    u_xlat25 = u_xlat24 * u_xlat24;
    u_xlat25 = u_xlat25 * u_xlat25;
    u_xlat24 = u_xlat24 * u_xlat25;
    u_xlat24 = fma(u_xlat12.x, u_xlat24, 1.0);
    u_xlat25 = -abs(u_xlat36) + 1.0;
    u_xlat39 = u_xlat25 * u_xlat25;
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat25 = u_xlat25 * u_xlat39;
    u_xlat12.x = fma(u_xlat12.x, u_xlat25, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat24;
    u_xlat24 = u_xlat38 * u_xlat38;
    u_xlat24 = max(u_xlat24, 0.00200000009);
    u_xlat39 = (-u_xlat24) + 1.0;
    u_xlat4.x = fma(abs(u_xlat36), u_xlat39, u_xlat24);
    u_xlat39 = fma(u_xlat1.x, u_xlat39, u_xlat24);
    u_xlat36 = abs(u_xlat36) * u_xlat39;
    u_xlat36 = fma(u_xlat1.x, u_xlat4.x, u_xlat36);
    u_xlat36 = u_xlat36 + 9.99999975e-06;
    u_xlat36 = 0.5 / u_xlat36;
    u_xlat39 = u_xlat24 * u_xlat24;
    u_xlat4.x = fma(u_xlat13, u_xlat39, (-u_xlat13));
    u_xlat13 = fma(u_xlat4.x, u_xlat13, 1.0);
    u_xlat39 = u_xlat39 * 0.318309873;
    u_xlat13 = fma(u_xlat13, u_xlat13, 1.00000001e-07);
    u_xlat13 = u_xlat39 / u_xlat13;
    u_xlat36 = u_xlat36 * u_xlat13;
    u_xlat36 = u_xlat36 * 3.14159274;
    u_xlat36 = max(u_xlat36, 9.99999975e-05);
    u_xlat12.z = sqrt(u_xlat36);
    u_xlat12.xz = u_xlat1.xx * u_xlat12.xz;
    u_xlat24 = u_xlat24 * u_xlat38;
    u_xlat24 = fma((-u_xlat24), 0.280000001, 1.0);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = u_xlat1.x!=0.0;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat36 = u_xlat12.z * u_xlat1.x;
    u_xlat1.x = (-u_xlat37) + FGlobals._Glossiness;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * float3(u_xlat36);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat12.x = u_xlat0.x * u_xlat0.x;
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat0.x = u_xlat0.x * u_xlat12.x;
    u_xlat6.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat0.xyw = fma(u_xlat6.xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat5.xyz;
    u_xlat0.xyw = fma(u_xlat3.xyz, u_xlat4.xyz, u_xlat0.xyw);
    u_xlat3.xyz = u_xlat7.xyz * float3(u_xlat24);
    u_xlat1.xyw = (-u_xlat2.xyz) + u_xlat1.xxx;
    u_xlat1.xyz = fma(float3(u_xlat25), u_xlat1.xyw, u_xlat2.xyz);
    output.SV_Target0.xyz = fma(u_xlat3.xyz, u_xlat1.xyz, u_xlat0.xyw);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL LIGHTPROBE_SH SHADOWS_SCREEN 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (288 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 80
  Matrix4x4 unity_WorldToObject at 144
  Matrix4x4 unity_MatrixVP at 208
  Vector4 _ProjectionParams at 0
  Vector4 unity_SHBr at 16
  Vector4 unity_SHBg at 32
  Vector4 unity_SHBb at 48
  Vector4 unity_SHC at 64
  Vector4 _MainTex_ST at 272
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    u_xlat1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat10 = u_xlat1.y * u_xlat1.y;
    u_xlat10 = fma(u_xlat1.x, u_xlat1.x, (-u_xlat10));
    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat1.x = dot(VGlobals.unity_SHBr, u_xlat2);
    u_xlat1.y = dot(VGlobals.unity_SHBg, u_xlat2);
    u_xlat1.z = dot(VGlobals.unity_SHBb, u_xlat2);
    output.TEXCOORD3.xyz = fma(VGlobals.unity_SHC.xyz, float3(u_xlat10), u_xlat1.xyz);
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD5.zw = u_xlat0.zw;
    output.TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 3
Set 2D Texture "_ShadowMapTexture" to slot 1 sampler slot 2
Set CUBE Texture "unity_SpecCube0" to slot 2 sampler slot 0
Set CUBE Texture "unity_SpecCube1" to slot 3 sampler slot -1
Set 3D Texture "unity_ProbeVolumeSH" to slot 4 sampler slot 1

Constant Buffer "FGlobals" (480 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 128
  Matrix4x4 unity_ProbeVolumeWorldToObject at 336
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_SHAr at 32
  Vector4 unity_SHAg at 48
  Vector4 unity_SHAb at 64
  Vector4 unity_OcclusionMaskSelector at 80
  Vector4 _LightShadowData at 96
  Vector4 unity_ShadowFadeCenterAndType at 112
  Vector4 unity_SpecCube0_BoxMax at 192
  Vector4 unity_SpecCube0_BoxMin at 208
  Vector4 unity_SpecCube0_ProbePosition at 224
  Vector4 unity_SpecCube0_HDR at 240
  Vector4 unity_SpecCube1_BoxMax at 256
  Vector4 unity_SpecCube1_BoxMin at 272
  Vector4 unity_SpecCube1_ProbePosition at 288
  Vector4 unity_SpecCube1_HDR at 304
  Vector4 unity_ProbeVolumeParams at 320
  Vector3 unity_ProbeVolumeSizeInv at 400
  Vector3 unity_ProbeVolumeMin at 416
  Vector4 _LightColor0 at 432
  Float _Glossiness at 448
  Float _Metallic at 452
  Vector4 _Color at 464
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_SpecCube0_BoxMax;
    float4 unity_SpecCube0_BoxMin;
    float4 unity_SpecCube0_ProbePosition;
    float4 unity_SpecCube0_HDR;
    float4 unity_SpecCube1_BoxMax;
    float4 unity_SpecCube1_BoxMin;
    float4 unity_SpecCube1_ProbePosition;
    float4 unity_SpecCube1_HDR;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (1) ]],
    sampler sampler_ShadowMapTexture [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _ShadowMapTexture [[ texture(1) ]] ,
    texturecube<float, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    texturecube<float, access::sample > unity_SpecCube1 [[ texture(3) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    float4 u_xlat9;
    float3 u_xlat10;
    bool3 u_xlatb10;
    float3 u_xlat11;
    bool3 u_xlatb12;
    float3 u_xlat13;
    float u_xlat14;
    float u_xlat17;
    float u_xlat26;
    float u_xlat27;
    float u_xlat39;
    float u_xlat40;
    bool u_xlatb40;
    float u_xlat41;
    bool u_xlatb41;
    float u_xlat42;
    bool u_xlatb42;
    float u_xlat43;
    bool u_xlatb43;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat1.xyz = float3(u_xlat39) * u_xlat0.xyz;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat40 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat4.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat41 = sqrt(u_xlat41);
    u_xlat41 = (-u_xlat40) + u_xlat41;
    u_xlat40 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat41, u_xlat40);
    u_xlat40 = fma(u_xlat40, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat40 = clamp(u_xlat40, 0.0f, 1.0f);
    u_xlatb41 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb41){
        u_xlatb42 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat4.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat4.xyz);
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat4.xyz);
        u_xlat4.xyz = u_xlat4.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat4.xyz = (bool(u_xlatb42)) ? u_xlat4.xyz : input.TEXCOORD2.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat4.yzw = u_xlat4.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat42 = fma(u_xlat4.y, 0.25, 0.75);
        u_xlat17 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat4.x = max(u_xlat42, u_xlat17);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xzw);
    } else {
        u_xlat4.x = float(1.0);
        u_xlat4.y = float(1.0);
        u_xlat4.z = float(1.0);
        u_xlat4.w = float(1.0);
    }
    u_xlat42 = dot(u_xlat4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat4.xy = input.TEXCOORD5.xy / input.TEXCOORD5.ww;
    u_xlat4.x = _ShadowMapTexture.sample(sampler_ShadowMapTexture, u_xlat4.xy).x;
    u_xlat42 = u_xlat42 + (-u_xlat4.x);
    u_xlat40 = fma(u_xlat40, u_xlat42, u_xlat4.x);
    u_xlat42 = (-FGlobals._Glossiness) + 1.0;
    u_xlat4.x = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat4.x = u_xlat4.x + u_xlat4.x;
    u_xlat4.xyz = fma(input.TEXCOORD1.xyz, (-u_xlat4.xxx), (-u_xlat1.xyz));
    u_xlat5.xyz = float3(u_xlat40) * FGlobals._LightColor0.xyz;
    if(u_xlatb41){
        u_xlatb40 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
        u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : input.TEXCOORD2.xyz;
        u_xlat6.xyz = u_xlat6.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat6.yzw = u_xlat6.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat40 = u_xlat6.y * 0.25;
        u_xlat41 = FGlobals.unity_ProbeVolumeParams.z * 0.5;
        u_xlat43 = fma((-FGlobals.unity_ProbeVolumeParams.z), 0.5, 0.25);
        u_xlat40 = max(u_xlat40, u_xlat41);
        u_xlat6.x = min(u_xlat43, u_xlat40);
        u_xlat7 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xzw);
        u_xlat8.xyz = u_xlat6.xzw + float3(0.25, 0.0, 0.0);
        u_xlat8 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat8.xyz);
        u_xlat6.xyz = u_xlat6.xzw + float3(0.5, 0.0, 0.0);
        u_xlat6 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xyz);
        u_xlat9.xyz = input.TEXCOORD1.xyz;
        u_xlat9.w = 1.0;
        u_xlat7.x = dot(u_xlat7, u_xlat9);
        u_xlat7.y = dot(u_xlat8, u_xlat9);
        u_xlat7.z = dot(u_xlat6, u_xlat9);
    } else {
        u_xlat6.xyz = input.TEXCOORD1.xyz;
        u_xlat6.w = 1.0;
        u_xlat7.x = dot(FGlobals.unity_SHAr, u_xlat6);
        u_xlat7.y = dot(FGlobals.unity_SHAg, u_xlat6);
        u_xlat7.z = dot(FGlobals.unity_SHAb, u_xlat6);
    }
    u_xlat6.xyz = u_xlat7.xyz + input.TEXCOORD3.xyz;
    u_xlat6.xyz = max(u_xlat6.xyz, float3(0.0, 0.0, 0.0));
    u_xlat6.xyz = log2(u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat6.xyz = exp2(u_xlat6.xyz);
    u_xlat6.xyz = fma(u_xlat6.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat6.xyz = max(u_xlat6.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb40 = 0.0<FGlobals.unity_SpecCube0_ProbePosition.w;
    if(u_xlatb40){
        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat40 = rsqrt(u_xlat40);
        u_xlat7.xyz = float3(u_xlat40) * u_xlat4.xyz;
        u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMax.xyz;
        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
        u_xlat9.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMin.xyz;
        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
        u_xlatb10.xyz = (float3(0.0, 0.0, 0.0)<u_xlat7.xyz);
        {
            float4 hlslcc_movcTemp = u_xlat8;
            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
            u_xlat8 = hlslcc_movcTemp;
        }
        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
        u_xlat40 = min(u_xlat8.z, u_xlat40);
        u_xlat8.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube0_ProbePosition.xyz);
        u_xlat7.xyz = fma(u_xlat7.xyz, float3(u_xlat40), u_xlat8.xyz);
    } else {
        u_xlat7.xyz = u_xlat4.xyz;
    }
    u_xlat40 = fma((-u_xlat42), 0.699999988, 1.70000005);
    u_xlat40 = u_xlat40 * u_xlat42;
    u_xlat40 = u_xlat40 * 6.0;
    u_xlat7 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat7.xyz, level(u_xlat40));
    u_xlat41 = u_xlat7.w + -1.0;
    u_xlat41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat41, 1.0);
    u_xlat41 = u_xlat41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat8.xyz = u_xlat7.xyz * float3(u_xlat41);
    u_xlatb43 = FGlobals.unity_SpecCube0_BoxMin.w<0.999989986;
    if(u_xlatb43){
        u_xlatb43 = 0.0<FGlobals.unity_SpecCube1_ProbePosition.w;
        if(u_xlatb43){
            u_xlat43 = dot(u_xlat4.xyz, u_xlat4.xyz);
            u_xlat43 = rsqrt(u_xlat43);
            u_xlat9.xyz = float3(u_xlat43) * u_xlat4.xyz;
            u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMax.xyz;
            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
            u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMin.xyz;
            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
            u_xlatb12.xyz = (float3(0.0, 0.0, 0.0)<u_xlat9.xyz);
            {
                float3 hlslcc_movcTemp = u_xlat10;
                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
                u_xlat10 = hlslcc_movcTemp;
            }
            u_xlat43 = min(u_xlat10.y, u_xlat10.x);
            u_xlat43 = min(u_xlat10.z, u_xlat43);
            u_xlat10.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube1_ProbePosition.xyz);
            u_xlat4.xyz = fma(u_xlat9.xyz, float3(u_xlat43), u_xlat10.xyz);
        }
        u_xlat4 = unity_SpecCube1.sample(samplerunity_SpecCube0, u_xlat4.xyz, level(u_xlat40));
        u_xlat40 = u_xlat4.w + -1.0;
        u_xlat40 = fma(FGlobals.unity_SpecCube1_HDR.w, u_xlat40, 1.0);
        u_xlat40 = u_xlat40 * FGlobals.unity_SpecCube1_HDR.x;
        u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat40);
        u_xlat7.xyz = fma(float3(u_xlat41), u_xlat7.xyz, (-u_xlat4.xyz));
        u_xlat8.xyz = fma(FGlobals.unity_SpecCube0_BoxMin.www, u_xlat7.xyz, u_xlat4.xyz);
    }
    u_xlat40 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat40 = rsqrt(u_xlat40);
    u_xlat4.xyz = float3(u_xlat40) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat40 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat40) * u_xlat3.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat39), FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat39 = max(u_xlat39, 0.00100000005);
    u_xlat39 = rsqrt(u_xlat39);
    u_xlat0.xyz = float3(u_xlat39) * u_xlat0.xyz;
    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat14 = clamp(u_xlat14, 0.0f, 1.0f);
    u_xlat0.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat13.x = u_xlat0.x * u_xlat0.x;
    u_xlat13.x = dot(u_xlat13.xx, float2(u_xlat42));
    u_xlat13.x = u_xlat13.x + -0.5;
    u_xlat26 = (-u_xlat1.x) + 1.0;
    u_xlat27 = u_xlat26 * u_xlat26;
    u_xlat27 = u_xlat27 * u_xlat27;
    u_xlat26 = u_xlat26 * u_xlat27;
    u_xlat26 = fma(u_xlat13.x, u_xlat26, 1.0);
    u_xlat27 = -abs(u_xlat39) + 1.0;
    u_xlat41 = u_xlat27 * u_xlat27;
    u_xlat41 = u_xlat41 * u_xlat41;
    u_xlat27 = u_xlat27 * u_xlat41;
    u_xlat13.x = fma(u_xlat13.x, u_xlat27, 1.0);
    u_xlat13.x = u_xlat13.x * u_xlat26;
    u_xlat26 = u_xlat42 * u_xlat42;
    u_xlat26 = max(u_xlat26, 0.00200000009);
    u_xlat41 = (-u_xlat26) + 1.0;
    u_xlat4.x = fma(abs(u_xlat39), u_xlat41, u_xlat26);
    u_xlat41 = fma(u_xlat1.x, u_xlat41, u_xlat26);
    u_xlat39 = abs(u_xlat39) * u_xlat41;
    u_xlat39 = fma(u_xlat1.x, u_xlat4.x, u_xlat39);
    u_xlat39 = u_xlat39 + 9.99999975e-06;
    u_xlat39 = 0.5 / u_xlat39;
    u_xlat41 = u_xlat26 * u_xlat26;
    u_xlat4.x = fma(u_xlat14, u_xlat41, (-u_xlat14));
    u_xlat14 = fma(u_xlat4.x, u_xlat14, 1.0);
    u_xlat41 = u_xlat41 * 0.318309873;
    u_xlat14 = fma(u_xlat14, u_xlat14, 1.00000001e-07);
    u_xlat14 = u_xlat41 / u_xlat14;
    u_xlat39 = u_xlat39 * u_xlat14;
    u_xlat39 = u_xlat39 * 3.14159274;
    u_xlat39 = max(u_xlat39, 9.99999975e-05);
    u_xlat13.z = sqrt(u_xlat39);
    u_xlat13.xz = u_xlat1.xx * u_xlat13.xz;
    u_xlat26 = u_xlat26 * u_xlat42;
    u_xlat26 = fma((-u_xlat26), 0.280000001, 1.0);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = u_xlat1.x!=0.0;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat39 = u_xlat13.z * u_xlat1.x;
    u_xlat1.x = (-u_xlat40) + FGlobals._Glossiness;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat4.xyz = fma(u_xlat5.xyz, u_xlat13.xxx, u_xlat6.xyz);
    u_xlat5.xyz = u_xlat5.xyz * float3(u_xlat39);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat13.x = u_xlat0.x * u_xlat0.x;
    u_xlat13.x = u_xlat13.x * u_xlat13.x;
    u_xlat0.x = u_xlat0.x * u_xlat13.x;
    u_xlat6.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat0.xyw = fma(u_xlat6.xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat5.xyz;
    u_xlat0.xyw = fma(u_xlat3.xyz, u_xlat4.xyz, u_xlat0.xyw);
    u_xlat3.xyz = u_xlat8.xyz * float3(u_xlat26);
    u_xlat1.xyw = (-u_xlat2.xyz) + u_xlat1.xxx;
    u_xlat1.xyz = fma(float3(u_xlat27), u_xlat1.xyw, u_xlat2.xyz);
    output.SV_Target0.xyz = fma(u_xlat3.xyz, u_xlat1.xyz, u_xlat0.xyw);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL VERTEXLIGHT_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (208 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Vector4 _MainTex_ST at 192
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL LIGHTPROBE_SH VERTEXLIGHT_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (464 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 256
  Matrix4x4 unity_WorldToObject at 320
  Matrix4x4 unity_MatrixVP at 384
  Vector4 unity_4LightPosX0 at 0
  Vector4 unity_4LightPosY0 at 16
  Vector4 unity_4LightPosZ0 at 32
  Vector4 unity_4LightAtten0 at 48
  Vector4 unity_LightColor[8] at 64
  Vector4 unity_SHBr at 192
  Vector4 unity_SHBg at 208
  Vector4 unity_SHBb at 224
  Vector4 unity_SHC at 240
  Vector4 _MainTex_ST at 448
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_4LightPosX0;
    float4 unity_4LightPosY0;
    float4 unity_4LightPosZ0;
    float4 unity_4LightAtten0;
    float4 unity_LightColor[8];
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float u_xlat15;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = rsqrt(u_xlat15);
    u_xlat1.xyz = float3(u_xlat15) * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat1.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat2 = (-u_xlat0.xxxx) + VGlobals.unity_4LightPosX0;
    u_xlat3 = (-u_xlat0.yyyy) + VGlobals.unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + VGlobals.unity_4LightPosZ0;
    u_xlat4 = u_xlat1.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat3 = fma(u_xlat2, u_xlat2, u_xlat3);
    u_xlat2 = fma(u_xlat2, u_xlat1.xxxx, u_xlat4);
    u_xlat2 = fma(u_xlat0, u_xlat1.zzzz, u_xlat2);
    u_xlat0 = fma(u_xlat0, u_xlat0, u_xlat3);
    u_xlat0 = max(u_xlat0, float4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = rsqrt(u_xlat0);
    u_xlat0 = fma(u_xlat0, VGlobals.unity_4LightAtten0, float4(1.0, 1.0, 1.0, 1.0));
    u_xlat0 = float4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat2 = max(u_xlat2, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat2;
    u_xlat2.xyz = u_xlat0.yyy * VGlobals.unity_LightColor[1].xyz;
    u_xlat2.xyz = fma(VGlobals.unity_LightColor[0].xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyz = fma(VGlobals.unity_LightColor[2].xyz, u_xlat0.zzz, u_xlat2.xyz);
    u_xlat0.xyz = fma(VGlobals.unity_LightColor[3].xyz, u_xlat0.www, u_xlat0.xyz);
    u_xlat2.xyz = fma(u_xlat0.xyz, float3(0.305306017, 0.305306017, 0.305306017), float3(0.682171106, 0.682171106, 0.682171106));
    u_xlat2.xyz = fma(u_xlat0.xyz, u_xlat2.xyz, float3(0.0125228781, 0.0125228781, 0.0125228781));
    u_xlat15 = u_xlat1.y * u_xlat1.y;
    u_xlat15 = fma(u_xlat1.x, u_xlat1.x, (-u_xlat15));
    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
    u_xlat3.x = dot(VGlobals.unity_SHBr, u_xlat1);
    u_xlat3.y = dot(VGlobals.unity_SHBg, u_xlat1);
    u_xlat3.z = dot(VGlobals.unity_SHBb, u_xlat1);
    u_xlat1.xyz = fma(VGlobals.unity_SHC.xyz, float3(u_xlat15), u_xlat3.xyz);
    output.TEXCOORD3.xyz = fma(u_xlat0.xyz, u_xlat2.xyz, u_xlat1.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL SHADOWS_SCREEN VERTEXLIGHT_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (224 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 unity_WorldToObject at 80
  Matrix4x4 unity_MatrixVP at 144
  Vector4 _ProjectionParams at 0
  Vector4 _MainTex_ST at 208
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    output.TEXCOORD1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD5.zw = u_xlat0.zw;
    output.TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL LIGHTPROBE_SH SHADOWS_SCREEN VERTEXLIGHT_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (480 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 272
  Matrix4x4 unity_WorldToObject at 336
  Matrix4x4 unity_MatrixVP at 400
  Vector4 _ProjectionParams at 0
  Vector4 unity_4LightPosX0 at 16
  Vector4 unity_4LightPosY0 at 32
  Vector4 unity_4LightPosZ0 at 48
  Vector4 unity_4LightAtten0 at 64
  Vector4 unity_LightColor[8] at 80
  Vector4 unity_SHBr at 208
  Vector4 unity_SHBg at 224
  Vector4 unity_SHBb at 240
  Vector4 unity_SHC at 256
  Vector4 _MainTex_ST at 464
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_4LightPosX0;
    float4 unity_4LightPosY0;
    float4 unity_4LightPosZ0;
    float4 unity_4LightAtten0;
    float4 unity_LightColor[8];
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float u_xlat18;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat2.xyz = float3(u_xlat18) * u_xlat2.xyz;
    output.TEXCOORD1.xyz = u_xlat2.xyz;
    output.TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat3 = (-u_xlat0.xxxx) + VGlobals.unity_4LightPosX0;
    u_xlat4 = (-u_xlat0.yyyy) + VGlobals.unity_4LightPosY0;
    u_xlat0 = (-u_xlat0.zzzz) + VGlobals.unity_4LightPosZ0;
    u_xlat5 = u_xlat2.yyyy * u_xlat4;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat4 = fma(u_xlat3, u_xlat3, u_xlat4);
    u_xlat3 = fma(u_xlat3, u_xlat2.xxxx, u_xlat5);
    u_xlat3 = fma(u_xlat0, u_xlat2.zzzz, u_xlat3);
    u_xlat0 = fma(u_xlat0, u_xlat0, u_xlat4);
    u_xlat0 = max(u_xlat0, float4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat4 = rsqrt(u_xlat0);
    u_xlat0 = fma(u_xlat0, VGlobals.unity_4LightAtten0, float4(1.0, 1.0, 1.0, 1.0));
    u_xlat0 = float4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat3 = u_xlat3 * u_xlat4;
    u_xlat3 = max(u_xlat3, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat3.xyz = u_xlat0.yyy * VGlobals.unity_LightColor[1].xyz;
    u_xlat3.xyz = fma(VGlobals.unity_LightColor[0].xyz, u_xlat0.xxx, u_xlat3.xyz);
    u_xlat0.xyz = fma(VGlobals.unity_LightColor[2].xyz, u_xlat0.zzz, u_xlat3.xyz);
    u_xlat0.xyz = fma(VGlobals.unity_LightColor[3].xyz, u_xlat0.www, u_xlat0.xyz);
    u_xlat3.xyz = fma(u_xlat0.xyz, float3(0.305306017, 0.305306017, 0.305306017), float3(0.682171106, 0.682171106, 0.682171106));
    u_xlat3.xyz = fma(u_xlat0.xyz, u_xlat3.xyz, float3(0.0125228781, 0.0125228781, 0.0125228781));
    u_xlat18 = u_xlat2.y * u_xlat2.y;
    u_xlat18 = fma(u_xlat2.x, u_xlat2.x, (-u_xlat18));
    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
    u_xlat4.x = dot(VGlobals.unity_SHBr, u_xlat2);
    u_xlat4.y = dot(VGlobals.unity_SHBg, u_xlat2);
    u_xlat4.z = dot(VGlobals.unity_SHBb, u_xlat2);
    u_xlat2.xyz = fma(VGlobals.unity_SHC.xyz, float3(u_xlat18), u_xlat4.xyz);
    output.TEXCOORD3.xyz = fma(u_xlat0.xyz, u_xlat3.xyz, u_xlat2.xyz);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD5.zw = u_xlat1.zw;
    output.TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL INSTANCING_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (80 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 0
  Vector4 _MainTex_ST at 64
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    float u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 0x3;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    output.TEXCOORD2.xyz = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat1 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat1);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = rsqrt(u_xlat0);
    output.TEXCOORD1.xyz = float3(u_xlat0) * u_xlat1.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 2
Set CUBE Texture "unity_SpecCube0" to slot 1 sampler slot 0
Set CUBE Texture "unity_SpecCube1" to slot 2 sampler slot -1
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 1

Constant Buffer "FGlobals" (336 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 192
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 unity_SpecCube0_BoxMax at 48
  Vector4 unity_SpecCube0_BoxMin at 64
  Vector4 unity_SpecCube0_ProbePosition at 80
  Vector4 unity_SpecCube0_HDR at 96
  Vector4 unity_SpecCube1_BoxMax at 112
  Vector4 unity_SpecCube1_BoxMin at 128
  Vector4 unity_SpecCube1_ProbePosition at 144
  Vector4 unity_SpecCube1_HDR at 160
  Vector4 unity_ProbeVolumeParams at 176
  Vector3 unity_ProbeVolumeSizeInv at 256
  Vector3 unity_ProbeVolumeMin at 272
  Vector4 _LightColor0 at 288
  Float _Glossiness at 304
  Float _Metallic at 308
  Vector4 _Color at 320
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_SpecCube0_BoxMax;
    float4 unity_SpecCube0_BoxMin;
    float4 unity_SpecCube0_ProbePosition;
    float4 unity_SpecCube0_HDR;
    float4 unity_SpecCube1_BoxMax;
    float4 unity_SpecCube1_BoxMin;
    float4 unity_SpecCube1_ProbePosition;
    float4 unity_SpecCube1_HDR;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<float, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    texturecube<float, access::sample > unity_SpecCube1 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    bool3 u_xlatb9;
    float3 u_xlat10;
    bool3 u_xlatb11;
    float3 u_xlat12;
    float u_xlat13;
    float u_xlat24;
    float u_xlat25;
    float u_xlat36;
    float u_xlat37;
    bool u_xlatb37;
    float u_xlat38;
    float u_xlat39;
    float u_xlat40;
    bool u_xlatb40;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat1.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlatb37 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb37){
        u_xlatb37 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat4.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat4.xyz);
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat4.xyz);
        u_xlat4.xyz = u_xlat4.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat4.xyz = (bool(u_xlatb37)) ? u_xlat4.xyz : input.TEXCOORD2.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat4.yzw = u_xlat4.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat37 = fma(u_xlat4.y, 0.25, 0.75);
        u_xlat38 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat4.x = max(u_xlat37, u_xlat38);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xzw);
    } else {
        u_xlat4.x = float(1.0);
        u_xlat4.y = float(1.0);
        u_xlat4.z = float(1.0);
        u_xlat4.w = float(1.0);
    }
    u_xlat37 = dot(u_xlat4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat37 = clamp(u_xlat37, 0.0f, 1.0f);
    u_xlat38 = (-FGlobals._Glossiness) + 1.0;
    u_xlat39 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat4.xyz = fma(input.TEXCOORD1.xyz, (-float3(u_xlat39)), (-u_xlat1.xyz));
    u_xlat5.xyz = float3(u_xlat37) * FGlobals._LightColor0.xyz;
    u_xlatb37 = 0.0<FGlobals.unity_SpecCube0_ProbePosition.w;
    if(u_xlatb37){
        u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat37 = rsqrt(u_xlat37);
        u_xlat6.xyz = float3(u_xlat37) * u_xlat4.xyz;
        u_xlat7.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMax.xyz;
        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
        u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMin.xyz;
        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
        u_xlatb9.xyz = (float3(0.0, 0.0, 0.0)<u_xlat6.xyz);
        {
            float3 hlslcc_movcTemp = u_xlat7;
            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
            u_xlat7 = hlslcc_movcTemp;
        }
        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
        u_xlat37 = min(u_xlat7.z, u_xlat37);
        u_xlat7.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube0_ProbePosition.xyz);
        u_xlat6.xyz = fma(u_xlat6.xyz, float3(u_xlat37), u_xlat7.xyz);
    } else {
        u_xlat6.xyz = u_xlat4.xyz;
    }
    u_xlat37 = fma((-u_xlat38), 0.699999988, 1.70000005);
    u_xlat37 = u_xlat37 * u_xlat38;
    u_xlat37 = u_xlat37 * 6.0;
    u_xlat6 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat6.xyz, level(u_xlat37));
    u_xlat39 = u_xlat6.w + -1.0;
    u_xlat39 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat39, 1.0);
    u_xlat39 = u_xlat39 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat7.xyz = u_xlat6.xyz * float3(u_xlat39);
    u_xlatb40 = FGlobals.unity_SpecCube0_BoxMin.w<0.999989986;
    if(u_xlatb40){
        u_xlatb40 = 0.0<FGlobals.unity_SpecCube1_ProbePosition.w;
        if(u_xlatb40){
            u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
            u_xlat40 = rsqrt(u_xlat40);
            u_xlat8.xyz = float3(u_xlat40) * u_xlat4.xyz;
            u_xlat9.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMax.xyz;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
            u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMin.xyz;
            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
            u_xlatb11.xyz = (float3(0.0, 0.0, 0.0)<u_xlat8.xyz);
            {
                float3 hlslcc_movcTemp = u_xlat9;
                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
                u_xlat9 = hlslcc_movcTemp;
            }
            u_xlat40 = min(u_xlat9.y, u_xlat9.x);
            u_xlat40 = min(u_xlat9.z, u_xlat40);
            u_xlat9.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube1_ProbePosition.xyz);
            u_xlat4.xyz = fma(u_xlat8.xyz, float3(u_xlat40), u_xlat9.xyz);
        }
        u_xlat4 = unity_SpecCube1.sample(samplerunity_SpecCube0, u_xlat4.xyz, level(u_xlat37));
        u_xlat37 = u_xlat4.w + -1.0;
        u_xlat37 = fma(FGlobals.unity_SpecCube1_HDR.w, u_xlat37, 1.0);
        u_xlat37 = u_xlat37 * FGlobals.unity_SpecCube1_HDR.x;
        u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat37);
        u_xlat6.xyz = fma(float3(u_xlat39), u_xlat6.xyz, (-u_xlat4.xyz));
        u_xlat7.xyz = fma(FGlobals.unity_SpecCube0_BoxMin.www, u_xlat6.xyz, u_xlat4.xyz);
    }
    u_xlat37 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat37 = rsqrt(u_xlat37);
    u_xlat4.xyz = float3(u_xlat37) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat37 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat37) * u_xlat3.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = max(u_xlat36, 0.00100000005);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat13 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat13 = clamp(u_xlat13, 0.0f, 1.0f);
    u_xlat0.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat0.x * u_xlat0.x;
    u_xlat12.x = dot(u_xlat12.xx, float2(u_xlat38));
    u_xlat12.x = u_xlat12.x + -0.5;
    u_xlat24 = (-u_xlat1.x) + 1.0;
    u_xlat25 = u_xlat24 * u_xlat24;
    u_xlat25 = u_xlat25 * u_xlat25;
    u_xlat24 = u_xlat24 * u_xlat25;
    u_xlat24 = fma(u_xlat12.x, u_xlat24, 1.0);
    u_xlat25 = -abs(u_xlat36) + 1.0;
    u_xlat39 = u_xlat25 * u_xlat25;
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat25 = u_xlat25 * u_xlat39;
    u_xlat12.x = fma(u_xlat12.x, u_xlat25, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat24;
    u_xlat24 = u_xlat38 * u_xlat38;
    u_xlat24 = max(u_xlat24, 0.00200000009);
    u_xlat39 = (-u_xlat24) + 1.0;
    u_xlat4.x = fma(abs(u_xlat36), u_xlat39, u_xlat24);
    u_xlat39 = fma(u_xlat1.x, u_xlat39, u_xlat24);
    u_xlat36 = abs(u_xlat36) * u_xlat39;
    u_xlat36 = fma(u_xlat1.x, u_xlat4.x, u_xlat36);
    u_xlat36 = u_xlat36 + 9.99999975e-06;
    u_xlat36 = 0.5 / u_xlat36;
    u_xlat39 = u_xlat24 * u_xlat24;
    u_xlat4.x = fma(u_xlat13, u_xlat39, (-u_xlat13));
    u_xlat13 = fma(u_xlat4.x, u_xlat13, 1.0);
    u_xlat39 = u_xlat39 * 0.318309873;
    u_xlat13 = fma(u_xlat13, u_xlat13, 1.00000001e-07);
    u_xlat13 = u_xlat39 / u_xlat13;
    u_xlat36 = u_xlat36 * u_xlat13;
    u_xlat36 = u_xlat36 * 3.14159274;
    u_xlat36 = max(u_xlat36, 9.99999975e-05);
    u_xlat12.z = sqrt(u_xlat36);
    u_xlat12.xz = u_xlat1.xx * u_xlat12.xz;
    u_xlat24 = u_xlat24 * u_xlat38;
    u_xlat24 = fma((-u_xlat24), 0.280000001, 1.0);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = u_xlat1.x!=0.0;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat36 = u_xlat12.z * u_xlat1.x;
    u_xlat1.x = (-u_xlat37) + FGlobals._Glossiness;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * float3(u_xlat36);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat12.x = u_xlat0.x * u_xlat0.x;
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat0.x = u_xlat0.x * u_xlat12.x;
    u_xlat6.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat0.xyw = fma(u_xlat6.xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat5.xyz;
    u_xlat0.xyw = fma(u_xlat3.xyz, u_xlat4.xyz, u_xlat0.xyw);
    u_xlat3.xyz = u_xlat7.xyz * float3(u_xlat24);
    u_xlat1.xyw = (-u_xlat2.xyz) + u_xlat1.xxx;
    u_xlat1.xyz = fma(float3(u_xlat25), u_xlat1.xyw, u_xlat2.xyz);
    output.SV_Target0.xyz = fma(u_xlat3.xyz, u_xlat1.xyz, u_xlat0.xyw);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL INSTANCING_ON LIGHTPROBE_SH 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (80 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 0
  Vector4 _MainTex_ST at 64
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}
Constant Buffer "UnityInstancing_PerDraw2" (224 bytes) on slot 3 {
  Struct unity_Builtins2Array [112][2] at 0 {
    Vector4 unity_SHArArray at 0
    Vector4 unity_SHAgArray at 16
    Vector4 unity_SHAbArray at 32
    Vector4 unity_SHBrArray at 48
    Vector4 unity_SHBgArray at 64
    Vector4 unity_SHBbArray at 80
    Vector4 unity_SHCArray at 96
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct unity_Builtins2Array_Type
{
    float4 unity_SHArArray;
    float4 unity_SHAgArray;
    float4 unity_SHAbArray;
    float4 unity_SHBrArray;
    float4 unity_SHBgArray;
    float4 unity_SHBbArray;
    float4 unity_SHCArray;
};

struct UnityInstancing_PerDraw2_Type
{
    unity_Builtins2Array_Type unity_Builtins2Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    const constant unity_Builtins2Array_Type* UnityInstancing_PerDraw2 [[ buffer(3) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    int u_xlati4;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati4 = u_xlati0 << 0x3;
    u_xlati0 = u_xlati0 * 0x7;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    output.TEXCOORD2.xyz = fma(UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat1 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat1);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat4.xyz;
    u_xlat1.x = u_xlat4.y * u_xlat4.y;
    u_xlat1.x = fma(u_xlat4.x, u_xlat4.x, (-u_xlat1.x));
    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat3.x = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBrArray, u_xlat2);
    u_xlat3.y = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBgArray, u_xlat2);
    u_xlat3.z = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBbArray, u_xlat2);
    output.TEXCOORD3.xyz = fma(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHCArray.xyz, u_xlat1.xxx, u_xlat3.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 2
Set CUBE Texture "unity_SpecCube0" to slot 1 sampler slot 0
Set CUBE Texture "unity_SpecCube1" to slot 2 sampler slot -1
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 1

Constant Buffer "FGlobals" (336 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 192
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 unity_SpecCube0_BoxMax at 48
  Vector4 unity_SpecCube0_BoxMin at 64
  Vector4 unity_SpecCube0_ProbePosition at 80
  Vector4 unity_SpecCube0_HDR at 96
  Vector4 unity_SpecCube1_BoxMax at 112
  Vector4 unity_SpecCube1_BoxMin at 128
  Vector4 unity_SpecCube1_ProbePosition at 144
  Vector4 unity_SpecCube1_HDR at 160
  Vector4 unity_ProbeVolumeParams at 176
  Vector3 unity_ProbeVolumeSizeInv at 256
  Vector3 unity_ProbeVolumeMin at 272
  Vector4 _LightColor0 at 288
  Float _Glossiness at 304
  Float _Metallic at 308
  Vector4 _Color at 320
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw2" (224 bytes) on slot 2 {
  Struct unity_Builtins2Array [112][2] at 0 {
    Vector4 unity_SHArArray at 0
    Vector4 unity_SHAgArray at 16
    Vector4 unity_SHAbArray at 32
    Vector4 unity_SHBrArray at 48
    Vector4 unity_SHBgArray at 64
    Vector4 unity_SHBbArray at 80
    Vector4 unity_SHCArray at 96
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_SpecCube0_BoxMax;
    float4 unity_SpecCube0_BoxMin;
    float4 unity_SpecCube0_ProbePosition;
    float4 unity_SpecCube0_HDR;
    float4 unity_SpecCube1_BoxMax;
    float4 unity_SpecCube1_BoxMin;
    float4 unity_SpecCube1_ProbePosition;
    float4 unity_SpecCube1_HDR;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins2Array_Type
{
    float4 unity_SHArArray;
    float4 unity_SHAgArray;
    float4 unity_SHAbArray;
    float4 unity_SHBrArray;
    float4 unity_SHBgArray;
    float4 unity_SHBbArray;
    float4 unity_SHCArray;
};

struct UnityInstancing_PerDraw2_Type
{
    unity_Builtins2Array_Type unity_Builtins2Array[2];
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]]  [[ flat ]];
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins2Array_Type* UnityInstancing_PerDraw2 [[ buffer(2) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texturecube<float, access::sample > unity_SpecCube0 [[ texture(1) ]] ,
    texturecube<float, access::sample > unity_SpecCube1 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    int u_xlati0;
    bool u_xlatb0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    float4 u_xlat9;
    float3 u_xlat10;
    bool3 u_xlatb10;
    float3 u_xlat11;
    bool3 u_xlatb12;
    float3 u_xlat13;
    float3 u_xlat14;
    bool u_xlatb14;
    float3 u_xlat17;
    float u_xlat26;
    float u_xlat27;
    float u_xlat39;
    float u_xlat40;
    float u_xlat41;
    bool u_xlatb41;
    float u_xlat42;
    bool u_xlatb42;
    float u_xlat44;
    u_xlati0 = int(input.SV_InstanceID0) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlat13.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlati0 = u_xlati0 * 0x7;
    u_xlatb41 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb41){
        u_xlatb42 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat4.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat4.xyz);
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat4.xyz);
        u_xlat4.xyz = u_xlat4.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat4.xyz = (bool(u_xlatb42)) ? u_xlat4.xyz : input.TEXCOORD2.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat4.yzw = u_xlat4.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat42 = fma(u_xlat4.y, 0.25, 0.75);
        u_xlat17.x = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat4.x = max(u_xlat42, u_xlat17.x);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xzw);
    } else {
        u_xlat4 = UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHCArray.wwww;
    }
    u_xlat42 = dot(u_xlat4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat42 = clamp(u_xlat42, 0.0f, 1.0f);
    u_xlat4.x = (-FGlobals._Glossiness) + 1.0;
    u_xlat17.x = dot((-u_xlat14.xyz), input.TEXCOORD1.xyz);
    u_xlat17.x = u_xlat17.x + u_xlat17.x;
    u_xlat17.xyz = fma(input.TEXCOORD1.xyz, (-u_xlat17.xxx), (-u_xlat14.xyz));
    u_xlat5.xyz = float3(u_xlat42) * FGlobals._LightColor0.xyz;
    if(u_xlatb41){
        u_xlatb41 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
        u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat6.xyz = (bool(u_xlatb41)) ? u_xlat6.xyz : input.TEXCOORD2.xyz;
        u_xlat6.xyz = u_xlat6.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat6.yzw = u_xlat6.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat41 = u_xlat6.y * 0.25;
        u_xlat42 = FGlobals.unity_ProbeVolumeParams.z * 0.5;
        u_xlat44 = fma((-FGlobals.unity_ProbeVolumeParams.z), 0.5, 0.25);
        u_xlat41 = max(u_xlat41, u_xlat42);
        u_xlat6.x = min(u_xlat44, u_xlat41);
        u_xlat7 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xzw);
        u_xlat8.xyz = u_xlat6.xzw + float3(0.25, 0.0, 0.0);
        u_xlat8 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat8.xyz);
        u_xlat6.xyz = u_xlat6.xzw + float3(0.5, 0.0, 0.0);
        u_xlat6 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xyz);
        u_xlat9.xyz = input.TEXCOORD1.xyz;
        u_xlat9.w = 1.0;
        u_xlat7.x = dot(u_xlat7, u_xlat9);
        u_xlat7.y = dot(u_xlat8, u_xlat9);
        u_xlat7.z = dot(u_xlat6, u_xlat9);
    } else {
        u_xlat6.xyz = input.TEXCOORD1.xyz;
        u_xlat6.w = 1.0;
        u_xlat7.x = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHArArray, u_xlat6);
        u_xlat7.y = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHAgArray, u_xlat6);
        u_xlat7.z = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHAbArray, u_xlat6);
    }
    u_xlat6.xyz = u_xlat7.xyz + input.TEXCOORD3.xyz;
    u_xlat6.xyz = max(u_xlat6.xyz, float3(0.0, 0.0, 0.0));
    u_xlat6.xyz = log2(u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat6.xyz = exp2(u_xlat6.xyz);
    u_xlat6.xyz = fma(u_xlat6.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat6.xyz = max(u_xlat6.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb0 = 0.0<FGlobals.unity_SpecCube0_ProbePosition.w;
    if(u_xlatb0){
        u_xlat0 = dot(u_xlat17.xyz, u_xlat17.xyz);
        u_xlat0 = rsqrt(u_xlat0);
        u_xlat7.xyz = float3(u_xlat0) * u_xlat17.xyz;
        u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMax.xyz;
        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
        u_xlat9.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMin.xyz;
        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
        u_xlatb10.xyz = (float3(0.0, 0.0, 0.0)<u_xlat7.xyz);
        {
            float4 hlslcc_movcTemp = u_xlat8;
            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
            u_xlat8 = hlslcc_movcTemp;
        }
        u_xlat0 = min(u_xlat8.y, u_xlat8.x);
        u_xlat0 = min(u_xlat8.z, u_xlat0);
        u_xlat8.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube0_ProbePosition.xyz);
        u_xlat7.xyz = fma(u_xlat7.xyz, float3(u_xlat0), u_xlat8.xyz);
    } else {
        u_xlat7.xyz = u_xlat17.xyz;
    }
    u_xlat0 = fma((-u_xlat4.x), 0.699999988, 1.70000005);
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat0 = u_xlat0 * 6.0;
    u_xlat7 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat7.xyz, level(u_xlat0));
    u_xlat41 = u_xlat7.w + -1.0;
    u_xlat41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat41, 1.0);
    u_xlat41 = u_xlat41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat8.xyz = u_xlat7.xyz * float3(u_xlat41);
    u_xlatb42 = FGlobals.unity_SpecCube0_BoxMin.w<0.999989986;
    if(u_xlatb42){
        u_xlatb42 = 0.0<FGlobals.unity_SpecCube1_ProbePosition.w;
        if(u_xlatb42){
            u_xlat42 = dot(u_xlat17.xyz, u_xlat17.xyz);
            u_xlat42 = rsqrt(u_xlat42);
            u_xlat9.xyz = float3(u_xlat42) * u_xlat17.xyz;
            u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMax.xyz;
            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
            u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMin.xyz;
            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
            u_xlatb12.xyz = (float3(0.0, 0.0, 0.0)<u_xlat9.xyz);
            {
                float3 hlslcc_movcTemp = u_xlat10;
                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
                u_xlat10 = hlslcc_movcTemp;
            }
            u_xlat42 = min(u_xlat10.y, u_xlat10.x);
            u_xlat42 = min(u_xlat10.z, u_xlat42);
            u_xlat10.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube1_ProbePosition.xyz);
            u_xlat17.xyz = fma(u_xlat9.xyz, float3(u_xlat42), u_xlat10.xyz);
        }
        u_xlat9 = unity_SpecCube1.sample(samplerunity_SpecCube0, u_xlat17.xyz, level(u_xlat0));
        u_xlat0 = u_xlat9.w + -1.0;
        u_xlat0 = fma(FGlobals.unity_SpecCube1_HDR.w, u_xlat0, 1.0);
        u_xlat0 = u_xlat0 * FGlobals.unity_SpecCube1_HDR.x;
        u_xlat17.xyz = u_xlat9.xyz * float3(u_xlat0);
        u_xlat7.xyz = fma(float3(u_xlat41), u_xlat7.xyz, (-u_xlat17.xyz));
        u_xlat8.xyz = fma(FGlobals.unity_SpecCube0_BoxMin.www, u_xlat7.xyz, u_xlat17.xyz);
    }
    u_xlat0 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat0 = rsqrt(u_xlat0);
    u_xlat17.xyz = float3(u_xlat0) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat0) * u_xlat3.xyz;
    u_xlat13.xyz = fma(u_xlat13.xyz, u_xlat1.xxx, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat1.x = dot(u_xlat17.xyz, u_xlat14.xyz);
    u_xlat14.x = dot(u_xlat17.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
    u_xlat27 = dot(u_xlat17.xyz, u_xlat13.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat13.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat13.xyz);
    u_xlat13.x = clamp(u_xlat13.x, 0.0f, 1.0f);
    u_xlat26 = u_xlat13.x * u_xlat13.x;
    u_xlat26 = dot(float2(u_xlat26), u_xlat4.xx);
    u_xlat26 = u_xlat26 + -0.5;
    u_xlat39 = (-u_xlat14.x) + 1.0;
    u_xlat40 = u_xlat39 * u_xlat39;
    u_xlat40 = u_xlat40 * u_xlat40;
    u_xlat39 = u_xlat39 * u_xlat40;
    u_xlat39 = fma(u_xlat26, u_xlat39, 1.0);
    u_xlat40 = -abs(u_xlat1.x) + 1.0;
    u_xlat41 = u_xlat40 * u_xlat40;
    u_xlat41 = u_xlat41 * u_xlat41;
    u_xlat40 = u_xlat40 * u_xlat41;
    u_xlat26 = fma(u_xlat26, u_xlat40, 1.0);
    u_xlat26 = u_xlat26 * u_xlat39;
    u_xlat26 = u_xlat14.x * u_xlat26;
    u_xlat39 = u_xlat4.x * u_xlat4.x;
    u_xlat39 = max(u_xlat39, 0.00200000009);
    u_xlat41 = (-u_xlat39) + 1.0;
    u_xlat42 = fma(abs(u_xlat1.x), u_xlat41, u_xlat39);
    u_xlat41 = fma(u_xlat14.x, u_xlat41, u_xlat39);
    u_xlat1.x = abs(u_xlat1.x) * u_xlat41;
    u_xlat1.x = fma(u_xlat14.x, u_xlat42, u_xlat1.x);
    u_xlat1.x = u_xlat1.x + 9.99999975e-06;
    u_xlat1.x = 0.5 / u_xlat1.x;
    u_xlat41 = u_xlat39 * u_xlat39;
    u_xlat42 = fma(u_xlat27, u_xlat41, (-u_xlat27));
    u_xlat27 = fma(u_xlat42, u_xlat27, 1.0);
    u_xlat41 = u_xlat41 * 0.318309873;
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.00000001e-07);
    u_xlat27 = u_xlat41 / u_xlat27;
    u_xlat1.x = u_xlat27 * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 3.14159274;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat14.x * u_xlat1.x;
    u_xlat39 = u_xlat39 * u_xlat4.x;
    u_xlat39 = fma((-u_xlat39), 0.280000001, 1.0);
    u_xlat14.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb14 = u_xlat14.x!=0.0;
    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat1.x = u_xlat14.x * u_xlat1.x;
    u_xlat0 = (-u_xlat0) + FGlobals._Glossiness;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat4.xyz = fma(u_xlat5.xyz, float3(u_xlat26), u_xlat6.xyz);
    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat13.x = (-u_xlat13.x) + 1.0;
    u_xlat26 = u_xlat13.x * u_xlat13.x;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat13.x = u_xlat13.x * u_xlat26;
    u_xlat5.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat5.xyz = fma(u_xlat5.xyz, u_xlat13.xxx, u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat5.xyz;
    u_xlat1.xyz = fma(u_xlat3.xyz, u_xlat4.xyz, u_xlat1.xyz);
    u_xlat13.xyz = u_xlat8.xyz * float3(u_xlat39);
    u_xlat3.xyz = (-u_xlat2.xyz) + float3(u_xlat0);
    u_xlat2.xyz = fma(float3(u_xlat40), u_xlat3.xyz, u_xlat2.xyz);
    output.SV_Target0.xyz = fma(u_xlat13.xyz, u_xlat2.xyz, u_xlat1.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL INSTANCING_ON SHADOWS_SCREEN 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (96 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 16
  Vector4 _ProjectionParams at 0
  Vector4 _MainTex_ST at 80
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    float4 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 0x3;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    output.TEXCOORD2.xyz = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat1 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD5.zw = u_xlat1.zw;
    output.TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 3
Set 2D Texture "_ShadowMapTexture" to slot 1 sampler slot 2
Set CUBE Texture "unity_SpecCube0" to slot 2 sampler slot 0
Set CUBE Texture "unity_SpecCube1" to slot 3 sampler slot -1
Set 3D Texture "unity_ProbeVolumeSH" to slot 4 sampler slot 1

Constant Buffer "FGlobals" (432 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 80
  Matrix4x4 unity_ProbeVolumeWorldToObject at 288
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 _LightShadowData at 48
  Vector4 unity_ShadowFadeCenterAndType at 64
  Vector4 unity_SpecCube0_BoxMax at 144
  Vector4 unity_SpecCube0_BoxMin at 160
  Vector4 unity_SpecCube0_ProbePosition at 176
  Vector4 unity_SpecCube0_HDR at 192
  Vector4 unity_SpecCube1_BoxMax at 208
  Vector4 unity_SpecCube1_BoxMin at 224
  Vector4 unity_SpecCube1_ProbePosition at 240
  Vector4 unity_SpecCube1_HDR at 256
  Vector4 unity_ProbeVolumeParams at 272
  Vector3 unity_ProbeVolumeSizeInv at 352
  Vector3 unity_ProbeVolumeMin at 368
  Vector4 _LightColor0 at 384
  Float _Glossiness at 400
  Float _Metallic at 404
  Vector4 _Color at 416
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_SpecCube0_BoxMax;
    float4 unity_SpecCube0_BoxMin;
    float4 unity_SpecCube0_ProbePosition;
    float4 unity_SpecCube0_HDR;
    float4 unity_SpecCube1_BoxMax;
    float4 unity_SpecCube1_BoxMin;
    float4 unity_SpecCube1_ProbePosition;
    float4 unity_SpecCube1_HDR;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (1) ]],
    sampler sampler_ShadowMapTexture [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _ShadowMapTexture [[ texture(1) ]] ,
    texturecube<float, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    texturecube<float, access::sample > unity_SpecCube1 [[ texture(3) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    bool u_xlatb1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    bool3 u_xlatb9;
    float3 u_xlat10;
    bool3 u_xlatb11;
    float3 u_xlat12;
    float u_xlat13;
    float u_xlat24;
    float u_xlat25;
    float u_xlat36;
    float u_xlat37;
    bool u_xlatb37;
    float u_xlat38;
    bool u_xlatb38;
    float u_xlat39;
    float u_xlat40;
    bool u_xlatb40;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat1.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat37 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat4.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat38 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat38 = sqrt(u_xlat38);
    u_xlat38 = (-u_xlat37) + u_xlat38;
    u_xlat37 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat38, u_xlat37);
    u_xlat37 = fma(u_xlat37, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat37 = clamp(u_xlat37, 0.0f, 1.0f);
    u_xlatb38 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb38){
        u_xlatb38 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat4.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat4.xyz);
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat4.xyz);
        u_xlat4.xyz = u_xlat4.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat4.xyz = (bool(u_xlatb38)) ? u_xlat4.xyz : input.TEXCOORD2.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat4.yzw = u_xlat4.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat38 = fma(u_xlat4.y, 0.25, 0.75);
        u_xlat39 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat4.x = max(u_xlat38, u_xlat39);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xzw);
    } else {
        u_xlat4.x = float(1.0);
        u_xlat4.y = float(1.0);
        u_xlat4.z = float(1.0);
        u_xlat4.w = float(1.0);
    }
    u_xlat38 = dot(u_xlat4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat4.xy = input.TEXCOORD5.xy / input.TEXCOORD5.ww;
    u_xlat39 = _ShadowMapTexture.sample(sampler_ShadowMapTexture, u_xlat4.xy).x;
    u_xlat38 = u_xlat38 + (-u_xlat39);
    u_xlat37 = fma(u_xlat37, u_xlat38, u_xlat39);
    u_xlat38 = (-FGlobals._Glossiness) + 1.0;
    u_xlat39 = dot((-u_xlat1.xyz), input.TEXCOORD1.xyz);
    u_xlat39 = u_xlat39 + u_xlat39;
    u_xlat4.xyz = fma(input.TEXCOORD1.xyz, (-float3(u_xlat39)), (-u_xlat1.xyz));
    u_xlat5.xyz = float3(u_xlat37) * FGlobals._LightColor0.xyz;
    u_xlatb37 = 0.0<FGlobals.unity_SpecCube0_ProbePosition.w;
    if(u_xlatb37){
        u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat37 = rsqrt(u_xlat37);
        u_xlat6.xyz = float3(u_xlat37) * u_xlat4.xyz;
        u_xlat7.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMax.xyz;
        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
        u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMin.xyz;
        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
        u_xlatb9.xyz = (float3(0.0, 0.0, 0.0)<u_xlat6.xyz);
        {
            float3 hlslcc_movcTemp = u_xlat7;
            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
            u_xlat7 = hlslcc_movcTemp;
        }
        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
        u_xlat37 = min(u_xlat7.z, u_xlat37);
        u_xlat7.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube0_ProbePosition.xyz);
        u_xlat6.xyz = fma(u_xlat6.xyz, float3(u_xlat37), u_xlat7.xyz);
    } else {
        u_xlat6.xyz = u_xlat4.xyz;
    }
    u_xlat37 = fma((-u_xlat38), 0.699999988, 1.70000005);
    u_xlat37 = u_xlat37 * u_xlat38;
    u_xlat37 = u_xlat37 * 6.0;
    u_xlat6 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat6.xyz, level(u_xlat37));
    u_xlat39 = u_xlat6.w + -1.0;
    u_xlat39 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat39, 1.0);
    u_xlat39 = u_xlat39 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat7.xyz = u_xlat6.xyz * float3(u_xlat39);
    u_xlatb40 = FGlobals.unity_SpecCube0_BoxMin.w<0.999989986;
    if(u_xlatb40){
        u_xlatb40 = 0.0<FGlobals.unity_SpecCube1_ProbePosition.w;
        if(u_xlatb40){
            u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
            u_xlat40 = rsqrt(u_xlat40);
            u_xlat8.xyz = float3(u_xlat40) * u_xlat4.xyz;
            u_xlat9.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMax.xyz;
            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
            u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMin.xyz;
            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
            u_xlatb11.xyz = (float3(0.0, 0.0, 0.0)<u_xlat8.xyz);
            {
                float3 hlslcc_movcTemp = u_xlat9;
                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
                u_xlat9 = hlslcc_movcTemp;
            }
            u_xlat40 = min(u_xlat9.y, u_xlat9.x);
            u_xlat40 = min(u_xlat9.z, u_xlat40);
            u_xlat9.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube1_ProbePosition.xyz);
            u_xlat4.xyz = fma(u_xlat8.xyz, float3(u_xlat40), u_xlat9.xyz);
        }
        u_xlat4 = unity_SpecCube1.sample(samplerunity_SpecCube0, u_xlat4.xyz, level(u_xlat37));
        u_xlat37 = u_xlat4.w + -1.0;
        u_xlat37 = fma(FGlobals.unity_SpecCube1_HDR.w, u_xlat37, 1.0);
        u_xlat37 = u_xlat37 * FGlobals.unity_SpecCube1_HDR.x;
        u_xlat4.xyz = u_xlat4.xyz * float3(u_xlat37);
        u_xlat6.xyz = fma(float3(u_xlat39), u_xlat6.xyz, (-u_xlat4.xyz));
        u_xlat7.xyz = fma(FGlobals.unity_SpecCube0_BoxMin.www, u_xlat6.xyz, u_xlat4.xyz);
    }
    u_xlat37 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat37 = rsqrt(u_xlat37);
    u_xlat4.xyz = float3(u_xlat37) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat37 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat37) * u_xlat3.xyz;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = max(u_xlat36, 0.00100000005);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat4.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat13 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat13 = clamp(u_xlat13, 0.0f, 1.0f);
    u_xlat0.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat0.x * u_xlat0.x;
    u_xlat12.x = dot(u_xlat12.xx, float2(u_xlat38));
    u_xlat12.x = u_xlat12.x + -0.5;
    u_xlat24 = (-u_xlat1.x) + 1.0;
    u_xlat25 = u_xlat24 * u_xlat24;
    u_xlat25 = u_xlat25 * u_xlat25;
    u_xlat24 = u_xlat24 * u_xlat25;
    u_xlat24 = fma(u_xlat12.x, u_xlat24, 1.0);
    u_xlat25 = -abs(u_xlat36) + 1.0;
    u_xlat39 = u_xlat25 * u_xlat25;
    u_xlat39 = u_xlat39 * u_xlat39;
    u_xlat25 = u_xlat25 * u_xlat39;
    u_xlat12.x = fma(u_xlat12.x, u_xlat25, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat24;
    u_xlat24 = u_xlat38 * u_xlat38;
    u_xlat24 = max(u_xlat24, 0.00200000009);
    u_xlat39 = (-u_xlat24) + 1.0;
    u_xlat4.x = fma(abs(u_xlat36), u_xlat39, u_xlat24);
    u_xlat39 = fma(u_xlat1.x, u_xlat39, u_xlat24);
    u_xlat36 = abs(u_xlat36) * u_xlat39;
    u_xlat36 = fma(u_xlat1.x, u_xlat4.x, u_xlat36);
    u_xlat36 = u_xlat36 + 9.99999975e-06;
    u_xlat36 = 0.5 / u_xlat36;
    u_xlat39 = u_xlat24 * u_xlat24;
    u_xlat4.x = fma(u_xlat13, u_xlat39, (-u_xlat13));
    u_xlat13 = fma(u_xlat4.x, u_xlat13, 1.0);
    u_xlat39 = u_xlat39 * 0.318309873;
    u_xlat13 = fma(u_xlat13, u_xlat13, 1.00000001e-07);
    u_xlat13 = u_xlat39 / u_xlat13;
    u_xlat36 = u_xlat36 * u_xlat13;
    u_xlat36 = u_xlat36 * 3.14159274;
    u_xlat36 = max(u_xlat36, 9.99999975e-05);
    u_xlat12.z = sqrt(u_xlat36);
    u_xlat12.xz = u_xlat1.xx * u_xlat12.xz;
    u_xlat24 = u_xlat24 * u_xlat38;
    u_xlat24 = fma((-u_xlat24), 0.280000001, 1.0);
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb1 = u_xlat1.x!=0.0;
    u_xlat1.x = u_xlatb1 ? 1.0 : float(0.0);
    u_xlat36 = u_xlat12.z * u_xlat1.x;
    u_xlat1.x = (-u_xlat37) + FGlobals._Glossiness;
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat4.xyz = u_xlat12.xxx * u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz * float3(u_xlat36);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat12.x = u_xlat0.x * u_xlat0.x;
    u_xlat12.x = u_xlat12.x * u_xlat12.x;
    u_xlat0.x = u_xlat0.x * u_xlat12.x;
    u_xlat6.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat0.xyw = fma(u_xlat6.xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyw = u_xlat0.xyw * u_xlat5.xyz;
    u_xlat0.xyw = fma(u_xlat3.xyz, u_xlat4.xyz, u_xlat0.xyw);
    u_xlat3.xyz = u_xlat7.xyz * float3(u_xlat24);
    u_xlat1.xyw = (-u_xlat2.xyz) + u_xlat1.xxx;
    u_xlat1.xyz = fma(float3(u_xlat25), u_xlat1.xyw, u_xlat2.xyz);
    output.SV_Target0.xyz = fma(u_xlat3.xyz, u_xlat1.xyz, u_xlat0.xyw);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL INSTANCING_ON LIGHTPROBE_SH SHADOWS_SCREEN 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (96 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 16
  Vector4 _ProjectionParams at 0
  Vector4 _MainTex_ST at 80
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}
Constant Buffer "UnityInstancing_PerDraw2" (224 bytes) on slot 3 {
  Struct unity_Builtins2Array [112][2] at 0 {
    Vector4 unity_SHArArray at 0
    Vector4 unity_SHAgArray at 16
    Vector4 unity_SHAbArray at 32
    Vector4 unity_SHBrArray at 48
    Vector4 unity_SHBgArray at 64
    Vector4 unity_SHBbArray at 80
    Vector4 unity_SHCArray at 96
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct unity_Builtins2Array_Type
{
    float4 unity_SHArArray;
    float4 unity_SHAgArray;
    float4 unity_SHAbArray;
    float4 unity_SHBrArray;
    float4 unity_SHBgArray;
    float4 unity_SHBbArray;
    float4 unity_SHCArray;
};

struct UnityInstancing_PerDraw2_Type
{
    unity_Builtins2Array_Type unity_Builtins2Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    const constant unity_Builtins2Array_Type* UnityInstancing_PerDraw2 [[ buffer(3) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    float4 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    int u_xlati5;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati5 = u_xlati0 << 0x3;
    u_xlati0 = u_xlati0 * 0x7;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    output.TEXCOORD2.xyz = fma(UnityInstancing_PerDraw0[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat1 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati5 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat5.x = rsqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * u_xlat2.xyz;
    output.TEXCOORD1.xyz = u_xlat5.xyz;
    u_xlat2.x = u_xlat5.y * u_xlat5.y;
    u_xlat2.x = fma(u_xlat5.x, u_xlat5.x, (-u_xlat2.x));
    u_xlat3 = u_xlat5.yzzx * u_xlat5.xyzz;
    u_xlat4.x = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBrArray, u_xlat3);
    u_xlat4.y = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBgArray, u_xlat3);
    u_xlat4.z = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBbArray, u_xlat3);
    output.TEXCOORD3.xyz = fma(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHCArray.xyz, u_xlat2.xxx, u_xlat4.xyz);
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD5.zw = u_xlat1.zw;
    output.TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 3
Set 2D Texture "_ShadowMapTexture" to slot 1 sampler slot 2
Set CUBE Texture "unity_SpecCube0" to slot 2 sampler slot 0
Set CUBE Texture "unity_SpecCube1" to slot 3 sampler slot -1
Set 3D Texture "unity_ProbeVolumeSH" to slot 4 sampler slot 1

Constant Buffer "FGlobals" (432 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 80
  Matrix4x4 unity_ProbeVolumeWorldToObject at 288
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 _LightShadowData at 48
  Vector4 unity_ShadowFadeCenterAndType at 64
  Vector4 unity_SpecCube0_BoxMax at 144
  Vector4 unity_SpecCube0_BoxMin at 160
  Vector4 unity_SpecCube0_ProbePosition at 176
  Vector4 unity_SpecCube0_HDR at 192
  Vector4 unity_SpecCube1_BoxMax at 208
  Vector4 unity_SpecCube1_BoxMin at 224
  Vector4 unity_SpecCube1_ProbePosition at 240
  Vector4 unity_SpecCube1_HDR at 256
  Vector4 unity_ProbeVolumeParams at 272
  Vector3 unity_ProbeVolumeSizeInv at 352
  Vector3 unity_ProbeVolumeMin at 368
  Vector4 _LightColor0 at 384
  Float _Glossiness at 400
  Float _Metallic at 404
  Vector4 _Color at 416
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw2" (224 bytes) on slot 2 {
  Struct unity_Builtins2Array [112][2] at 0 {
    Vector4 unity_SHArArray at 0
    Vector4 unity_SHAgArray at 16
    Vector4 unity_SHAbArray at 32
    Vector4 unity_SHBrArray at 48
    Vector4 unity_SHBgArray at 64
    Vector4 unity_SHBbArray at 80
    Vector4 unity_SHCArray at 96
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_SpecCube0_BoxMax;
    float4 unity_SpecCube0_BoxMin;
    float4 unity_SpecCube0_ProbePosition;
    float4 unity_SpecCube0_HDR;
    float4 unity_SpecCube1_BoxMax;
    float4 unity_SpecCube1_BoxMin;
    float4 unity_SpecCube1_ProbePosition;
    float4 unity_SpecCube1_HDR;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins2Array_Type
{
    float4 unity_SHArArray;
    float4 unity_SHAgArray;
    float4 unity_SHAbArray;
    float4 unity_SHBrArray;
    float4 unity_SHBgArray;
    float4 unity_SHBbArray;
    float4 unity_SHCArray;
};

struct UnityInstancing_PerDraw2_Type
{
    unity_Builtins2Array_Type unity_Builtins2Array[2];
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]] ;
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]]  [[ flat ]];
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins2Array_Type* UnityInstancing_PerDraw2 [[ buffer(2) ]],
    sampler samplerunity_SpecCube0 [[ sampler (0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (1) ]],
    sampler sampler_ShadowMapTexture [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _ShadowMapTexture [[ texture(1) ]] ,
    texturecube<float, access::sample > unity_SpecCube0 [[ texture(2) ]] ,
    texturecube<float, access::sample > unity_SpecCube1 [[ texture(3) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    int u_xlati0;
    bool u_xlatb0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    bool u_xlatb4;
    float3 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    float4 u_xlat9;
    float3 u_xlat10;
    bool3 u_xlatb10;
    float3 u_xlat11;
    bool3 u_xlatb12;
    float3 u_xlat13;
    float3 u_xlat14;
    bool u_xlatb14;
    float3 u_xlat17;
    float u_xlat26;
    float u_xlat27;
    float u_xlat39;
    float u_xlat40;
    float u_xlat41;
    bool u_xlatb41;
    float u_xlat42;
    bool u_xlatb42;
    float u_xlat44;
    u_xlati0 = int(input.SV_InstanceID0) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlat13.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat14.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat41 = dot(u_xlat13.xyz, u_xlat4.xyz);
    u_xlat4.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat42 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat42 = sqrt(u_xlat42);
    u_xlat42 = (-u_xlat41) + u_xlat42;
    u_xlat41 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat42, u_xlat41);
    u_xlat41 = fma(u_xlat41, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat41 = clamp(u_xlat41, 0.0f, 1.0f);
    u_xlati0 = u_xlati0 * 0x7;
    u_xlatb42 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb42){
        u_xlatb4 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat17.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat17.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat17.xyz);
        u_xlat17.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat17.xyz);
        u_xlat17.xyz = u_xlat17.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat17.xyz : input.TEXCOORD2.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat4.yzw = u_xlat4.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat17.x = fma(u_xlat4.y, 0.25, 0.75);
        u_xlat5.x = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat4.x = max(u_xlat17.x, u_xlat5.x);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xzw);
    } else {
        u_xlat4 = UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHCArray.wwww;
    }
    u_xlat4.x = dot(u_xlat4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat4.x = clamp(u_xlat4.x, 0.0f, 1.0f);
    u_xlat17.xy = input.TEXCOORD5.xy / input.TEXCOORD5.ww;
    u_xlat17.x = _ShadowMapTexture.sample(sampler_ShadowMapTexture, u_xlat17.xy).x;
    u_xlat4.x = (-u_xlat17.x) + u_xlat4.x;
    u_xlat41 = fma(u_xlat41, u_xlat4.x, u_xlat17.x);
    u_xlat4.x = (-FGlobals._Glossiness) + 1.0;
    u_xlat17.x = dot((-u_xlat14.xyz), input.TEXCOORD1.xyz);
    u_xlat17.x = u_xlat17.x + u_xlat17.x;
    u_xlat17.xyz = fma(input.TEXCOORD1.xyz, (-u_xlat17.xxx), (-u_xlat14.xyz));
    u_xlat5.xyz = float3(u_xlat41) * FGlobals._LightColor0.xyz;
    if(u_xlatb42){
        u_xlatb41 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
        u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat6.xyz = (bool(u_xlatb41)) ? u_xlat6.xyz : input.TEXCOORD2.xyz;
        u_xlat6.xyz = u_xlat6.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat6.yzw = u_xlat6.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat41 = u_xlat6.y * 0.25;
        u_xlat42 = FGlobals.unity_ProbeVolumeParams.z * 0.5;
        u_xlat44 = fma((-FGlobals.unity_ProbeVolumeParams.z), 0.5, 0.25);
        u_xlat41 = max(u_xlat41, u_xlat42);
        u_xlat6.x = min(u_xlat44, u_xlat41);
        u_xlat7 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xzw);
        u_xlat8.xyz = u_xlat6.xzw + float3(0.25, 0.0, 0.0);
        u_xlat8 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat8.xyz);
        u_xlat6.xyz = u_xlat6.xzw + float3(0.5, 0.0, 0.0);
        u_xlat6 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xyz);
        u_xlat9.xyz = input.TEXCOORD1.xyz;
        u_xlat9.w = 1.0;
        u_xlat7.x = dot(u_xlat7, u_xlat9);
        u_xlat7.y = dot(u_xlat8, u_xlat9);
        u_xlat7.z = dot(u_xlat6, u_xlat9);
    } else {
        u_xlat6.xyz = input.TEXCOORD1.xyz;
        u_xlat6.w = 1.0;
        u_xlat7.x = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHArArray, u_xlat6);
        u_xlat7.y = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHAgArray, u_xlat6);
        u_xlat7.z = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHAbArray, u_xlat6);
    }
    u_xlat6.xyz = u_xlat7.xyz + input.TEXCOORD3.xyz;
    u_xlat6.xyz = max(u_xlat6.xyz, float3(0.0, 0.0, 0.0));
    u_xlat6.xyz = log2(u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat6.xyz = exp2(u_xlat6.xyz);
    u_xlat6.xyz = fma(u_xlat6.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat6.xyz = max(u_xlat6.xyz, float3(0.0, 0.0, 0.0));
    u_xlatb0 = 0.0<FGlobals.unity_SpecCube0_ProbePosition.w;
    if(u_xlatb0){
        u_xlat0 = dot(u_xlat17.xyz, u_xlat17.xyz);
        u_xlat0 = rsqrt(u_xlat0);
        u_xlat7.xyz = float3(u_xlat0) * u_xlat17.xyz;
        u_xlat8.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMax.xyz;
        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
        u_xlat9.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube0_BoxMin.xyz;
        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
        u_xlatb10.xyz = (float3(0.0, 0.0, 0.0)<u_xlat7.xyz);
        {
            float4 hlslcc_movcTemp = u_xlat8;
            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
            u_xlat8 = hlslcc_movcTemp;
        }
        u_xlat0 = min(u_xlat8.y, u_xlat8.x);
        u_xlat0 = min(u_xlat8.z, u_xlat0);
        u_xlat8.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube0_ProbePosition.xyz);
        u_xlat7.xyz = fma(u_xlat7.xyz, float3(u_xlat0), u_xlat8.xyz);
    } else {
        u_xlat7.xyz = u_xlat17.xyz;
    }
    u_xlat0 = fma((-u_xlat4.x), 0.699999988, 1.70000005);
    u_xlat0 = u_xlat0 * u_xlat4.x;
    u_xlat0 = u_xlat0 * 6.0;
    u_xlat7 = unity_SpecCube0.sample(samplerunity_SpecCube0, u_xlat7.xyz, level(u_xlat0));
    u_xlat41 = u_xlat7.w + -1.0;
    u_xlat41 = fma(FGlobals.unity_SpecCube0_HDR.w, u_xlat41, 1.0);
    u_xlat41 = u_xlat41 * FGlobals.unity_SpecCube0_HDR.x;
    u_xlat8.xyz = u_xlat7.xyz * float3(u_xlat41);
    u_xlatb42 = FGlobals.unity_SpecCube0_BoxMin.w<0.999989986;
    if(u_xlatb42){
        u_xlatb42 = 0.0<FGlobals.unity_SpecCube1_ProbePosition.w;
        if(u_xlatb42){
            u_xlat42 = dot(u_xlat17.xyz, u_xlat17.xyz);
            u_xlat42 = rsqrt(u_xlat42);
            u_xlat9.xyz = float3(u_xlat42) * u_xlat17.xyz;
            u_xlat10.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMax.xyz;
            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
            u_xlat11.xyz = (-input.TEXCOORD2.xyz) + FGlobals.unity_SpecCube1_BoxMin.xyz;
            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
            u_xlatb12.xyz = (float3(0.0, 0.0, 0.0)<u_xlat9.xyz);
            {
                float3 hlslcc_movcTemp = u_xlat10;
                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
                u_xlat10 = hlslcc_movcTemp;
            }
            u_xlat42 = min(u_xlat10.y, u_xlat10.x);
            u_xlat42 = min(u_xlat10.z, u_xlat42);
            u_xlat10.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_SpecCube1_ProbePosition.xyz);
            u_xlat17.xyz = fma(u_xlat9.xyz, float3(u_xlat42), u_xlat10.xyz);
        }
        u_xlat9 = unity_SpecCube1.sample(samplerunity_SpecCube0, u_xlat17.xyz, level(u_xlat0));
        u_xlat0 = u_xlat9.w + -1.0;
        u_xlat0 = fma(FGlobals.unity_SpecCube1_HDR.w, u_xlat0, 1.0);
        u_xlat0 = u_xlat0 * FGlobals.unity_SpecCube1_HDR.x;
        u_xlat17.xyz = u_xlat9.xyz * float3(u_xlat0);
        u_xlat7.xyz = fma(float3(u_xlat41), u_xlat7.xyz, (-u_xlat17.xyz));
        u_xlat8.xyz = fma(FGlobals.unity_SpecCube0_BoxMin.www, u_xlat7.xyz, u_xlat17.xyz);
    }
    u_xlat0 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat0 = rsqrt(u_xlat0);
    u_xlat17.xyz = float3(u_xlat0) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat0) * u_xlat3.xyz;
    u_xlat13.xyz = fma(u_xlat13.xyz, u_xlat1.xxx, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = dot(u_xlat13.xyz, u_xlat13.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = rsqrt(u_xlat1.x);
    u_xlat13.xyz = u_xlat13.xyz * u_xlat1.xxx;
    u_xlat1.x = dot(u_xlat17.xyz, u_xlat14.xyz);
    u_xlat14.x = dot(u_xlat17.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat14.x = clamp(u_xlat14.x, 0.0f, 1.0f);
    u_xlat27 = dot(u_xlat17.xyz, u_xlat13.xyz);
    u_xlat27 = clamp(u_xlat27, 0.0f, 1.0f);
    u_xlat13.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat13.xyz);
    u_xlat13.x = clamp(u_xlat13.x, 0.0f, 1.0f);
    u_xlat26 = u_xlat13.x * u_xlat13.x;
    u_xlat26 = dot(float2(u_xlat26), u_xlat4.xx);
    u_xlat26 = u_xlat26 + -0.5;
    u_xlat39 = (-u_xlat14.x) + 1.0;
    u_xlat40 = u_xlat39 * u_xlat39;
    u_xlat40 = u_xlat40 * u_xlat40;
    u_xlat39 = u_xlat39 * u_xlat40;
    u_xlat39 = fma(u_xlat26, u_xlat39, 1.0);
    u_xlat40 = -abs(u_xlat1.x) + 1.0;
    u_xlat41 = u_xlat40 * u_xlat40;
    u_xlat41 = u_xlat41 * u_xlat41;
    u_xlat40 = u_xlat40 * u_xlat41;
    u_xlat26 = fma(u_xlat26, u_xlat40, 1.0);
    u_xlat26 = u_xlat26 * u_xlat39;
    u_xlat26 = u_xlat14.x * u_xlat26;
    u_xlat39 = u_xlat4.x * u_xlat4.x;
    u_xlat39 = max(u_xlat39, 0.00200000009);
    u_xlat41 = (-u_xlat39) + 1.0;
    u_xlat42 = fma(abs(u_xlat1.x), u_xlat41, u_xlat39);
    u_xlat41 = fma(u_xlat14.x, u_xlat41, u_xlat39);
    u_xlat1.x = abs(u_xlat1.x) * u_xlat41;
    u_xlat1.x = fma(u_xlat14.x, u_xlat42, u_xlat1.x);
    u_xlat1.x = u_xlat1.x + 9.99999975e-06;
    u_xlat1.x = 0.5 / u_xlat1.x;
    u_xlat41 = u_xlat39 * u_xlat39;
    u_xlat42 = fma(u_xlat27, u_xlat41, (-u_xlat27));
    u_xlat27 = fma(u_xlat42, u_xlat27, 1.0);
    u_xlat41 = u_xlat41 * 0.318309873;
    u_xlat27 = fma(u_xlat27, u_xlat27, 1.00000001e-07);
    u_xlat27 = u_xlat41 / u_xlat27;
    u_xlat1.x = u_xlat27 * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * 3.14159274;
    u_xlat1.x = max(u_xlat1.x, 9.99999975e-05);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat1.x = u_xlat14.x * u_xlat1.x;
    u_xlat39 = u_xlat39 * u_xlat4.x;
    u_xlat39 = fma((-u_xlat39), 0.280000001, 1.0);
    u_xlat14.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb14 = u_xlat14.x!=0.0;
    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
    u_xlat1.x = u_xlat14.x * u_xlat1.x;
    u_xlat0 = (-u_xlat0) + FGlobals._Glossiness;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = clamp(u_xlat0, 0.0f, 1.0f);
    u_xlat4.xyz = fma(u_xlat5.xyz, float3(u_xlat26), u_xlat6.xyz);
    u_xlat1.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat13.x = (-u_xlat13.x) + 1.0;
    u_xlat26 = u_xlat13.x * u_xlat13.x;
    u_xlat26 = u_xlat26 * u_xlat26;
    u_xlat13.x = u_xlat13.x * u_xlat26;
    u_xlat5.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat5.xyz = fma(u_xlat5.xyz, u_xlat13.xxx, u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat5.xyz;
    u_xlat1.xyz = fma(u_xlat3.xyz, u_xlat4.xyz, u_xlat1.xyz);
    u_xlat13.xyz = u_xlat8.xyz * float3(u_xlat39);
    u_xlat3.xyz = (-u_xlat2.xyz) + float3(u_xlat0);
    u_xlat2.xyz = fma(float3(u_xlat40), u_xlat3.xyz, u_xlat2.xyz);
    output.SV_Target0.xyz = fma(u_xlat13.xyz, u_xlat2.xyz, u_xlat1.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL INSTANCING_ON VERTEXLIGHT_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (80 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 0
  Vector4 _MainTex_ST at 64
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    float u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 0x3;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    output.TEXCOORD2.xyz = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat1 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat1);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = rsqrt(u_xlat0);
    output.TEXCOORD1.xyz = float3(u_xlat0) * u_xlat1.xyz;
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL INSTANCING_ON LIGHTPROBE_SH VERTEXLIGHT_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 192
  Vector4 unity_4LightPosX0 at 0
  Vector4 unity_4LightPosY0 at 16
  Vector4 unity_4LightPosZ0 at 32
  Vector4 unity_4LightAtten0 at 48
  Vector4 unity_LightColor[8] at 64
  Vector4 _MainTex_ST at 256
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}
Constant Buffer "UnityInstancing_PerDraw2" (224 bytes) on slot 3 {
  Struct unity_Builtins2Array [112][2] at 0 {
    Vector4 unity_SHArArray at 0
    Vector4 unity_SHAgArray at 16
    Vector4 unity_SHAbArray at 32
    Vector4 unity_SHBrArray at 48
    Vector4 unity_SHBgArray at 64
    Vector4 unity_SHBbArray at 80
    Vector4 unity_SHCArray at 96
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_4LightPosX0;
    float4 unity_4LightPosY0;
    float4 unity_4LightPosZ0;
    float4 unity_4LightAtten0;
    float4 unity_LightColor[8];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct unity_Builtins2Array_Type
{
    float4 unity_SHArArray;
    float4 unity_SHAgArray;
    float4 unity_SHAbArray;
    float4 unity_SHBrArray;
    float4 unity_SHBgArray;
    float4 unity_SHBbArray;
    float4 unity_SHCArray;
};

struct UnityInstancing_PerDraw2_Type
{
    unity_Builtins2Array_Type unity_Builtins2Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    const constant unity_Builtins2Array_Type* UnityInstancing_PerDraw2 [[ buffer(3) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    float4 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float3 u_xlat6;
    int u_xlati6;
    float u_xlat19;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati6 = u_xlati0 << 0x3;
    u_xlati0 = u_xlati0 * 0x7;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = fma(UnityInstancing_PerDraw0[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat3 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat3);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat3);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati6 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = rsqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    output.TEXCOORD1.xyz = u_xlat6.xyz;
    output.TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat19 = u_xlat6.y * u_xlat6.y;
    u_xlat19 = fma(u_xlat6.x, u_xlat6.x, (-u_xlat19));
    u_xlat2 = u_xlat6.yzzx * u_xlat6.xyzz;
    u_xlat3.x = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBrArray, u_xlat2);
    u_xlat3.y = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBgArray, u_xlat2);
    u_xlat3.z = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBbArray, u_xlat2);
    u_xlat2.xyz = fma(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHCArray.xyz, float3(u_xlat19), u_xlat3.xyz);
    u_xlat3 = (-u_xlat1.yyyy) + VGlobals.unity_4LightPosY0;
    u_xlat4 = u_xlat6.yyyy * u_xlat3;
    u_xlat3 = u_xlat3 * u_xlat3;
    u_xlat5 = (-u_xlat1.xxxx) + VGlobals.unity_4LightPosX0;
    u_xlat1 = (-u_xlat1.zzzz) + VGlobals.unity_4LightPosZ0;
    u_xlat4 = fma(u_xlat5, u_xlat6.xxxx, u_xlat4);
    u_xlat0 = fma(u_xlat1, u_xlat6.zzzz, u_xlat4);
    u_xlat3 = fma(u_xlat5, u_xlat5, u_xlat3);
    u_xlat1 = fma(u_xlat1, u_xlat1, u_xlat3);
    u_xlat1 = max(u_xlat1, float4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat3 = rsqrt(u_xlat1);
    u_xlat1 = fma(u_xlat1, VGlobals.unity_4LightAtten0, float4(1.0, 1.0, 1.0, 1.0));
    u_xlat1 = float4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat0 = max(u_xlat0, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat1 * u_xlat0;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.unity_LightColor[1].xyz;
    u_xlat1.xyz = fma(VGlobals.unity_LightColor[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.unity_LightColor[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.unity_LightColor[3].xyz, u_xlat0.www, u_xlat0.xyz);
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(0.305306017, 0.305306017, 0.305306017), float3(0.682171106, 0.682171106, 0.682171106));
    u_xlat1.xyz = fma(u_xlat0.xyz, u_xlat1.xyz, float3(0.0125228781, 0.0125228781, 0.0125228781));
    output.TEXCOORD3.xyz = fma(u_xlat0.xyz, u_xlat1.xyz, u_xlat2.xyz);
    output.TEXCOORD5 = float4(0.0, 0.0, 0.0, 0.0);
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL INSTANCING_ON SHADOWS_SCREEN VERTEXLIGHT_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (96 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 16
  Vector4 _ProjectionParams at 0
  Vector4 _MainTex_ST at 80
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    float4 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 0x3;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    output.TEXCOORD2.xyz = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat1 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat1);
    output.mtl_Position = u_xlat1;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat2.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat2.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat2.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat0.x = rsqrt(u_xlat0.x);
    output.TEXCOORD1.xyz = u_xlat0.xxx * u_xlat2.xyz;
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD5.zw = u_xlat1.zw;
    output.TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL INSTANCING_ON LIGHTPROBE_SH SHADOWS_SCREEN VERTEXLIGHT_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (288 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 208
  Vector4 _ProjectionParams at 0
  Vector4 unity_4LightPosX0 at 16
  Vector4 unity_4LightPosY0 at 32
  Vector4 unity_4LightPosZ0 at 48
  Vector4 unity_4LightAtten0 at 64
  Vector4 unity_LightColor[8] at 80
  Vector4 _MainTex_ST at 272
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}
Constant Buffer "UnityInstancing_PerDraw2" (224 bytes) on slot 3 {
  Struct unity_Builtins2Array [112][2] at 0 {
    Vector4 unity_SHArArray at 0
    Vector4 unity_SHAgArray at 16
    Vector4 unity_SHAbArray at 32
    Vector4 unity_SHBrArray at 48
    Vector4 unity_SHBgArray at 64
    Vector4 unity_SHBbArray at 80
    Vector4 unity_SHCArray at 96
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 unity_4LightPosX0;
    float4 unity_4LightPosY0;
    float4 unity_4LightPosZ0;
    float4 unity_4LightAtten0;
    float4 unity_LightColor[8];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct unity_Builtins2Array_Type
{
    float4 unity_SHArArray;
    float4 unity_SHAgArray;
    float4 unity_SHAbArray;
    float4 unity_SHBrArray;
    float4 unity_SHBgArray;
    float4 unity_SHBbArray;
    float4 unity_SHCArray;
};

struct UnityInstancing_PerDraw2_Type
{
    unity_Builtins2Array_Type unity_Builtins2Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD5 [[ user(TEXCOORD5) ]];
    float4 TEXCOORD6 [[ user(TEXCOORD6) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    const constant unity_Builtins2Array_Type* UnityInstancing_PerDraw2 [[ buffer(3) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    float4 u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    int u_xlati7;
    float u_xlat22;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati7 = u_xlati0 << 0x3;
    u_xlati0 = u_xlati0 * 0x7;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1.xyz = fma(UnityInstancing_PerDraw0[u_xlati7 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat3 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat3);
    u_xlat3 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat3);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat3);
    output.mtl_Position = u_xlat2;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat3.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati7 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat3.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati7 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat3.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati7 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat7.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat7.x = rsqrt(u_xlat7.x);
    u_xlat7.xyz = u_xlat7.xxx * u_xlat3.xyz;
    output.TEXCOORD1.xyz = u_xlat7.xyz;
    output.TEXCOORD2.xyz = u_xlat1.xyz;
    u_xlat22 = u_xlat7.y * u_xlat7.y;
    u_xlat22 = fma(u_xlat7.x, u_xlat7.x, (-u_xlat22));
    u_xlat3 = u_xlat7.yzzx * u_xlat7.xyzz;
    u_xlat4.x = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBrArray, u_xlat3);
    u_xlat4.y = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBgArray, u_xlat3);
    u_xlat4.z = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBbArray, u_xlat3);
    u_xlat3.xyz = fma(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHCArray.xyz, float3(u_xlat22), u_xlat4.xyz);
    u_xlat4 = (-u_xlat1.yyyy) + VGlobals.unity_4LightPosY0;
    u_xlat5 = u_xlat7.yyyy * u_xlat4;
    u_xlat4 = u_xlat4 * u_xlat4;
    u_xlat6 = (-u_xlat1.xxxx) + VGlobals.unity_4LightPosX0;
    u_xlat1 = (-u_xlat1.zzzz) + VGlobals.unity_4LightPosZ0;
    u_xlat5 = fma(u_xlat6, u_xlat7.xxxx, u_xlat5);
    u_xlat0 = fma(u_xlat1, u_xlat7.zzzz, u_xlat5);
    u_xlat4 = fma(u_xlat6, u_xlat6, u_xlat4);
    u_xlat1 = fma(u_xlat1, u_xlat1, u_xlat4);
    u_xlat1 = max(u_xlat1, float4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat4 = rsqrt(u_xlat1);
    u_xlat1 = fma(u_xlat1, VGlobals.unity_4LightAtten0, float4(1.0, 1.0, 1.0, 1.0));
    u_xlat1 = float4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat4;
    u_xlat0 = max(u_xlat0, float4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat1 * u_xlat0;
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.unity_LightColor[1].xyz;
    u_xlat1.xyz = fma(VGlobals.unity_LightColor[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.unity_LightColor[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.unity_LightColor[3].xyz, u_xlat0.www, u_xlat0.xyz);
    u_xlat1.xyz = fma(u_xlat0.xyz, float3(0.305306017, 0.305306017, 0.305306017), float3(0.682171106, 0.682171106, 0.682171106));
    u_xlat1.xyz = fma(u_xlat0.xyz, u_xlat1.xyz, float3(0.0125228781, 0.0125228781, 0.0125228781));
    output.TEXCOORD3.xyz = fma(u_xlat0.xyz, u_xlat1.xyz, u_xlat3.xyz);
    u_xlat0.x = u_xlat2.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat2.xw * float2(0.5, 0.5);
    output.TEXCOORD5.zw = u_xlat2.zw;
    output.TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
    output.TEXCOORD6 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Fragment shader for "metal":
// No shader variant for this keyword set. The closest match will be used instead.

 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="FORWARDADD" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  ZWrite Off
  Blend One One
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
Global Keywords: POINT 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Matrix4x4 unity_WorldToLight at 192
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    output.TEXCOORD1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    output.TEXCOORD3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz, u_xlat0.www, u_xlat0.xyz);
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 2
Set 2D Texture "_LightTexture0" to slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 2 sampler slot 0

Constant Buffer "FGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 64
  Matrix4x4 unity_WorldToLight at 176
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 unity_ProbeVolumeParams at 48
  Vector3 unity_ProbeVolumeSizeInv at 128
  Vector3 unity_ProbeVolumeMin at 144
  Vector4 _LightColor0 at 160
  Float _Glossiness at 240
  Float _Metallic at 244
  Vector4 _Color at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_LightTexture0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture(1) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    float u_xlat8;
    float u_xlat9;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat4.xyz = u_xlat3.xyz * FGlobals._Color.xyz;
    u_xlat5.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat5.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, input.TEXCOORD2.xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, input.TEXCOORD2.zzz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat5.xyz + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlatb22 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb22){
        u_xlatb22 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
        u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat6.xyz = (bool(u_xlatb22)) ? u_xlat6.xyz : input.TEXCOORD2.xyz;
        u_xlat6.xyz = u_xlat6.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat6.yzw = u_xlat6.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat22 = fma(u_xlat6.y, 0.25, 0.75);
        u_xlat23 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat6.x = max(u_xlat22, u_xlat23);
        u_xlat6 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xzw);
    } else {
        u_xlat6.x = float(1.0);
        u_xlat6.y = float(1.0);
        u_xlat6.z = float(1.0);
        u_xlat6.w = float(1.0);
    }
    u_xlat22 = dot(u_xlat6, FGlobals.unity_OcclusionMaskSelector);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = _LightTexture0.sample(sampler_LightTexture0, float2(u_xlat23)).x;
    u_xlat22 = u_xlat22 * u_xlat23;
    u_xlat5.xyz = float3(u_xlat22) * FGlobals._LightColor0.xyz;
    u_xlat22 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat6.xyz = float3(u_xlat22) * input.TEXCOORD1.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat3.xyz = fma(float3(FGlobals._Metallic), u_xlat3.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat22 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat4.xyz = float3(u_xlat22) * u_xlat4.xyz;
    u_xlat22 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat21), u_xlat2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat0.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat9 = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat7.x = u_xlat0.x * u_xlat0.x;
    u_xlat7.x = dot(u_xlat7.xx, float2(u_xlat22));
    u_xlat7.x = u_xlat7.x + -0.5;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    u_xlat1.x = u_xlat14 * u_xlat14;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat14 = u_xlat14 * u_xlat1.x;
    u_xlat14 = fma(u_xlat7.x, u_xlat14, 1.0);
    u_xlat1.x = -abs(u_xlat21) + 1.0;
    u_xlat8 = u_xlat1.x * u_xlat1.x;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat7.x = fma(u_xlat7.x, u_xlat1.x, 1.0);
    u_xlat7.x = u_xlat7.x * u_xlat14;
    u_xlat14 = u_xlat22 * u_xlat22;
    u_xlat14 = max(u_xlat14, 0.00200000009);
    u_xlat1.x = (-u_xlat14) + 1.0;
    u_xlat8 = fma(abs(u_xlat21), u_xlat1.x, u_xlat14);
    u_xlat1.x = fma(u_xlat2.x, u_xlat1.x, u_xlat14);
    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
    u_xlat21 = fma(u_xlat2.x, u_xlat8, u_xlat21);
    u_xlat21 = u_xlat21 + 9.99999975e-06;
    u_xlat21 = 0.5 / u_xlat21;
    u_xlat14 = u_xlat14 * u_xlat14;
    u_xlat1.x = fma(u_xlat9, u_xlat14, (-u_xlat9));
    u_xlat1.x = fma(u_xlat1.x, u_xlat9, 1.0);
    u_xlat14 = u_xlat14 * 0.318309873;
    u_xlat1.x = fma(u_xlat1.x, u_xlat1.x, 1.00000001e-07);
    u_xlat14 = u_xlat14 / u_xlat1.x;
    u_xlat14 = u_xlat14 * u_xlat21;
    u_xlat14 = u_xlat14 * 3.14159274;
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat7.y = sqrt(u_xlat14);
    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlatb21 = u_xlat21!=0.0;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat14 = u_xlat21 * u_xlat7.y;
    u_xlat1.xyz = u_xlat7.xxx * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat5.xyz * float3(u_xlat14);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat22 = u_xlat0.x * u_xlat0.x;
    u_xlat22 = u_xlat22 * u_xlat22;
    u_xlat0.x = u_xlat0.x * u_xlat22;
    u_xlat2.xyz = (-u_xlat3.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat2.xyz, u_xlat0.xxx, u_xlat3.xyz);
    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat4.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (208 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Vector4 _MainTex_ST at 192
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 1 sampler slot 0

Constant Buffer "FGlobals" (208 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 64
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 unity_ProbeVolumeParams at 48
  Vector3 unity_ProbeVolumeSizeInv at 128
  Vector3 unity_ProbeVolumeMin at 144
  Vector4 _LightColor0 at 160
  Float _Glossiness at 176
  Float _Metallic at 180
  Vector4 _Color at 192
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float u_xlat12;
    float u_xlat13;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat19;
    bool u_xlatb19;
    float u_xlat20;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat1.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlatb19 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb19){
        u_xlatb19 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat4.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat4.xyz);
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat4.xyz);
        u_xlat4.xyz = u_xlat4.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat4.xyz = (bool(u_xlatb19)) ? u_xlat4.xyz : input.TEXCOORD2.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat4.yzw = u_xlat4.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat19 = fma(u_xlat4.y, 0.25, 0.75);
        u_xlat20 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat4.x = max(u_xlat19, u_xlat20);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xzw);
    } else {
        u_xlat4.x = float(1.0);
        u_xlat4.y = float(1.0);
        u_xlat4.z = float(1.0);
        u_xlat4.w = float(1.0);
    }
    u_xlat19 = dot(u_xlat4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat19 = clamp(u_xlat19, 0.0f, 1.0f);
    u_xlat4.xyz = float3(u_xlat19) * FGlobals._LightColor0.xyz;
    u_xlat19 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat5.xyz = float3(u_xlat19) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat19 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat19) * u_xlat3.xyz;
    u_xlat19 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat18), FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat0.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6.x = u_xlat0.x * u_xlat0.x;
    u_xlat6.x = dot(u_xlat6.xx, float2(u_xlat19));
    u_xlat6.x = u_xlat6.x + -0.5;
    u_xlat12 = (-u_xlat1.x) + 1.0;
    u_xlat13 = u_xlat12 * u_xlat12;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat12 = fma(u_xlat6.x, u_xlat12, 1.0);
    u_xlat13 = -abs(u_xlat18) + 1.0;
    u_xlat20 = u_xlat13 * u_xlat13;
    u_xlat20 = u_xlat20 * u_xlat20;
    u_xlat13 = u_xlat13 * u_xlat20;
    u_xlat6.x = fma(u_xlat6.x, u_xlat13, 1.0);
    u_xlat6.x = u_xlat6.x * u_xlat12;
    u_xlat12 = u_xlat19 * u_xlat19;
    u_xlat12 = max(u_xlat12, 0.00200000009);
    u_xlat13 = (-u_xlat12) + 1.0;
    u_xlat19 = fma(abs(u_xlat18), u_xlat13, u_xlat12);
    u_xlat13 = fma(u_xlat1.x, u_xlat13, u_xlat12);
    u_xlat18 = abs(u_xlat18) * u_xlat13;
    u_xlat18 = fma(u_xlat1.x, u_xlat19, u_xlat18);
    u_xlat18 = u_xlat18 + 9.99999975e-06;
    u_xlat18 = 0.5 / u_xlat18;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat13 = fma(u_xlat7, u_xlat12, (-u_xlat7));
    u_xlat7 = fma(u_xlat13, u_xlat7, 1.0);
    u_xlat12 = u_xlat12 * 0.318309873;
    u_xlat7 = fma(u_xlat7, u_xlat7, 1.00000001e-07);
    u_xlat12 = u_xlat12 / u_xlat7;
    u_xlat12 = u_xlat12 * u_xlat18;
    u_xlat12 = u_xlat12 * 3.14159274;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat6.y = sqrt(u_xlat12);
    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb18 = u_xlat18!=0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat12 = u_xlat18 * u_xlat6.y;
    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.xyz * float3(u_xlat12);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat19 = u_xlat0.x * u_xlat0.x;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat4.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat4.xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat3.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: SPOT 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Matrix4x4 unity_WorldToLight at 192
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    output.TEXCOORD1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2], u_xlat0.zzzz, u_xlat1);
    output.TEXCOORD3 = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 3
Set 2D Texture "_LightTexture0" to slot 1
Set 2D Texture "_LightTextureB0" to slot 2
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 0

Constant Buffer "FGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 64
  Matrix4x4 unity_WorldToLight at 176
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 unity_ProbeVolumeParams at 48
  Vector3 unity_ProbeVolumeSizeInv at 128
  Vector3 unity_ProbeVolumeMin at 144
  Vector4 _LightColor0 at 160
  Float _Glossiness at 240
  Float _Metallic at 244
  Vector4 _Color at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_LightTexture0 [[ sampler (1) ]],
    sampler sampler_LightTextureB0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture(1) ]] ,
    texture2d<float, access::sample > _LightTextureB0 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float4 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    float u_xlat8;
    float u_xlat9;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    bool u_xlatb23;
    float u_xlat24;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat4.xyz = u_xlat3.xyz * FGlobals._Color.xyz;
    u_xlat5 = input.TEXCOORD2.yyyy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat5 = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0], input.TEXCOORD2.xxxx, u_xlat5);
    u_xlat5 = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2], input.TEXCOORD2.zzzz, u_xlat5);
    u_xlat5 = u_xlat5 + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlatb22 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb22){
        u_xlatb22 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
        u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat6.xyz = (bool(u_xlatb22)) ? u_xlat6.xyz : input.TEXCOORD2.xyz;
        u_xlat6.xyz = u_xlat6.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat6.yzw = u_xlat6.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat22 = fma(u_xlat6.y, 0.25, 0.75);
        u_xlat23 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat6.x = max(u_xlat22, u_xlat23);
        u_xlat6 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xzw);
    } else {
        u_xlat6.x = float(1.0);
        u_xlat6.y = float(1.0);
        u_xlat6.z = float(1.0);
        u_xlat6.w = float(1.0);
    }
    u_xlat22 = dot(u_xlat6, FGlobals.unity_OcclusionMaskSelector);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlatb23 = 0.0<u_xlat5.z;
    u_xlat23 = u_xlatb23 ? 1.0 : float(0.0);
    u_xlat6.xy = u_xlat5.xy / u_xlat5.ww;
    u_xlat6.xy = u_xlat6.xy + float2(0.5, 0.5);
    u_xlat24 = _LightTexture0.sample(sampler_LightTexture0, u_xlat6.xy).w;
    u_xlat23 = u_xlat23 * u_xlat24;
    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat24 = _LightTextureB0.sample(sampler_LightTextureB0, float2(u_xlat24)).x;
    u_xlat23 = u_xlat23 * u_xlat24;
    u_xlat22 = u_xlat22 * u_xlat23;
    u_xlat5.xyz = float3(u_xlat22) * FGlobals._LightColor0.xyz;
    u_xlat22 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat6.xyz = float3(u_xlat22) * input.TEXCOORD1.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat3.xyz = fma(float3(FGlobals._Metallic), u_xlat3.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat22 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat4.xyz = float3(u_xlat22) * u_xlat4.xyz;
    u_xlat22 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat21), u_xlat2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat0.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat9 = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat7.x = u_xlat0.x * u_xlat0.x;
    u_xlat7.x = dot(u_xlat7.xx, float2(u_xlat22));
    u_xlat7.x = u_xlat7.x + -0.5;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    u_xlat1.x = u_xlat14 * u_xlat14;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat14 = u_xlat14 * u_xlat1.x;
    u_xlat14 = fma(u_xlat7.x, u_xlat14, 1.0);
    u_xlat1.x = -abs(u_xlat21) + 1.0;
    u_xlat8 = u_xlat1.x * u_xlat1.x;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat7.x = fma(u_xlat7.x, u_xlat1.x, 1.0);
    u_xlat7.x = u_xlat7.x * u_xlat14;
    u_xlat14 = u_xlat22 * u_xlat22;
    u_xlat14 = max(u_xlat14, 0.00200000009);
    u_xlat1.x = (-u_xlat14) + 1.0;
    u_xlat8 = fma(abs(u_xlat21), u_xlat1.x, u_xlat14);
    u_xlat1.x = fma(u_xlat2.x, u_xlat1.x, u_xlat14);
    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
    u_xlat21 = fma(u_xlat2.x, u_xlat8, u_xlat21);
    u_xlat21 = u_xlat21 + 9.99999975e-06;
    u_xlat21 = 0.5 / u_xlat21;
    u_xlat14 = u_xlat14 * u_xlat14;
    u_xlat1.x = fma(u_xlat9, u_xlat14, (-u_xlat9));
    u_xlat1.x = fma(u_xlat1.x, u_xlat9, 1.0);
    u_xlat14 = u_xlat14 * 0.318309873;
    u_xlat1.x = fma(u_xlat1.x, u_xlat1.x, 1.00000001e-07);
    u_xlat14 = u_xlat14 / u_xlat1.x;
    u_xlat14 = u_xlat14 * u_xlat21;
    u_xlat14 = u_xlat14 * 3.14159274;
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat7.y = sqrt(u_xlat14);
    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlatb21 = u_xlat21!=0.0;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat14 = u_xlat21 * u_xlat7.y;
    u_xlat1.xyz = u_xlat7.xxx * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat5.xyz * float3(u_xlat14);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat22 = u_xlat0.x * u_xlat0.x;
    u_xlat22 = u_xlat22 * u_xlat22;
    u_xlat0.x = u_xlat0.x * u_xlat22;
    u_xlat2.xyz = (-u_xlat3.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat2.xyz, u_xlat0.xxx, u_xlat3.xyz);
    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat4.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: POINT_COOKIE 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Matrix4x4 unity_WorldToLight at 192
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    output.TEXCOORD1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    output.TEXCOORD3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz, u_xlat0.www, u_xlat0.xyz);
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 3
Set 2D Texture "_LightTextureB0" to slot 1 sampler slot 2
Set CUBE Texture "_LightTexture0" to slot 2 sampler slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 0

Constant Buffer "FGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 64
  Matrix4x4 unity_WorldToLight at 176
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 unity_ProbeVolumeParams at 48
  Vector3 unity_ProbeVolumeSizeInv at 128
  Vector3 unity_ProbeVolumeMin at 144
  Vector4 _LightColor0 at 160
  Float _Glossiness at 240
  Float _Metallic at 244
  Vector4 _Color at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_LightTexture0 [[ sampler (1) ]],
    sampler sampler_LightTextureB0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _LightTextureB0 [[ texture(1) ]] ,
    texturecube<float, access::sample > _LightTexture0 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float3 u_xlat7;
    float u_xlat8;
    float u_xlat9;
    float u_xlat14;
    float u_xlat21;
    bool u_xlatb21;
    float u_xlat22;
    bool u_xlatb22;
    float u_xlat23;
    float u_xlat24;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceLightPos0.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat1.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat2.xyz = float3(u_xlat22) * u_xlat2.xyz;
    u_xlat3.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat4.xyz = u_xlat3.xyz * FGlobals._Color.xyz;
    u_xlat5.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat5.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, input.TEXCOORD2.xxx, u_xlat5.xyz);
    u_xlat5.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, input.TEXCOORD2.zzz, u_xlat5.xyz);
    u_xlat5.xyz = u_xlat5.xyz + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlatb22 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb22){
        u_xlatb22 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
        u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
        u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat6.xyz = (bool(u_xlatb22)) ? u_xlat6.xyz : input.TEXCOORD2.xyz;
        u_xlat6.xyz = u_xlat6.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat6.yzw = u_xlat6.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat22 = fma(u_xlat6.y, 0.25, 0.75);
        u_xlat23 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat6.x = max(u_xlat22, u_xlat23);
        u_xlat6 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat6.xzw);
    } else {
        u_xlat6.x = float(1.0);
        u_xlat6.y = float(1.0);
        u_xlat6.z = float(1.0);
        u_xlat6.w = float(1.0);
    }
    u_xlat22 = dot(u_xlat6, FGlobals.unity_OcclusionMaskSelector);
    u_xlat22 = clamp(u_xlat22, 0.0f, 1.0f);
    u_xlat23 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat23 = _LightTextureB0.sample(sampler_LightTextureB0, float2(u_xlat23)).x;
    u_xlat24 = _LightTexture0.sample(sampler_LightTexture0, u_xlat5.xyz).w;
    u_xlat23 = u_xlat23 * u_xlat24;
    u_xlat22 = u_xlat22 * u_xlat23;
    u_xlat5.xyz = float3(u_xlat22) * FGlobals._LightColor0.xyz;
    u_xlat22 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat22 = rsqrt(u_xlat22);
    u_xlat6.xyz = float3(u_xlat22) * input.TEXCOORD1.xyz;
    u_xlat3.xyz = fma(u_xlat3.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat3.xyz = fma(float3(FGlobals._Metallic), u_xlat3.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat22 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat4.xyz = float3(u_xlat22) * u_xlat4.xyz;
    u_xlat22 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat21), u_xlat2.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = max(u_xlat21, 0.00100000005);
    u_xlat21 = rsqrt(u_xlat21);
    u_xlat0.xyz = float3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat6.xyz, u_xlat2.xyz);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat9 = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat9 = clamp(u_xlat9, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat7.x = u_xlat0.x * u_xlat0.x;
    u_xlat7.x = dot(u_xlat7.xx, float2(u_xlat22));
    u_xlat7.x = u_xlat7.x + -0.5;
    u_xlat14 = (-u_xlat2.x) + 1.0;
    u_xlat1.x = u_xlat14 * u_xlat14;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat14 = u_xlat14 * u_xlat1.x;
    u_xlat14 = fma(u_xlat7.x, u_xlat14, 1.0);
    u_xlat1.x = -abs(u_xlat21) + 1.0;
    u_xlat8 = u_xlat1.x * u_xlat1.x;
    u_xlat8 = u_xlat8 * u_xlat8;
    u_xlat1.x = u_xlat1.x * u_xlat8;
    u_xlat7.x = fma(u_xlat7.x, u_xlat1.x, 1.0);
    u_xlat7.x = u_xlat7.x * u_xlat14;
    u_xlat14 = u_xlat22 * u_xlat22;
    u_xlat14 = max(u_xlat14, 0.00200000009);
    u_xlat1.x = (-u_xlat14) + 1.0;
    u_xlat8 = fma(abs(u_xlat21), u_xlat1.x, u_xlat14);
    u_xlat1.x = fma(u_xlat2.x, u_xlat1.x, u_xlat14);
    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
    u_xlat21 = fma(u_xlat2.x, u_xlat8, u_xlat21);
    u_xlat21 = u_xlat21 + 9.99999975e-06;
    u_xlat21 = 0.5 / u_xlat21;
    u_xlat14 = u_xlat14 * u_xlat14;
    u_xlat1.x = fma(u_xlat9, u_xlat14, (-u_xlat9));
    u_xlat1.x = fma(u_xlat1.x, u_xlat9, 1.0);
    u_xlat14 = u_xlat14 * 0.318309873;
    u_xlat1.x = fma(u_xlat1.x, u_xlat1.x, 1.00000001e-07);
    u_xlat14 = u_xlat14 / u_xlat1.x;
    u_xlat14 = u_xlat14 * u_xlat21;
    u_xlat14 = u_xlat14 * 3.14159274;
    u_xlat14 = max(u_xlat14, 9.99999975e-05);
    u_xlat7.y = sqrt(u_xlat14);
    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlatb21 = u_xlat21!=0.0;
    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
    u_xlat14 = u_xlat21 * u_xlat7.y;
    u_xlat1.xyz = u_xlat7.xxx * u_xlat5.xyz;
    u_xlat7.xyz = u_xlat5.xyz * float3(u_xlat14);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat22 = u_xlat0.x * u_xlat0.x;
    u_xlat22 = u_xlat22 * u_xlat22;
    u_xlat0.x = u_xlat0.x * u_xlat22;
    u_xlat2.xyz = (-u_xlat3.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat2.xyz, u_xlat0.xxx, u_xlat3.xyz);
    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat4.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL_COOKIE 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Matrix4x4 unity_WorldToLight at 192
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0.xy = u_xlat1.yy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xy, u_xlat1.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xy, u_xlat1.zz, u_xlat0.xy);
    output.TEXCOORD3.xy = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xy, u_xlat1.ww, u_xlat0.xy);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 2
Set 2D Texture "_LightTexture0" to slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 2 sampler slot 0

Constant Buffer "FGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 64
  Matrix4x4 unity_WorldToLight at 176
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 unity_ProbeVolumeParams at 48
  Vector3 unity_ProbeVolumeSizeInv at 128
  Vector3 unity_ProbeVolumeMin at 144
  Vector4 _LightColor0 at 160
  Float _Glossiness at 240
  Float _Metallic at 244
  Vector4 _Color at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_LightTexture0 [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture(1) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float4 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float u_xlat12;
    float u_xlat13;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat19;
    bool u_xlatb19;
    float u_xlat20;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat1.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat4.xy = input.TEXCOORD2.yy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat4.xy = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xy, input.TEXCOORD2.xx, u_xlat4.xy);
    u_xlat4.xy = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xy, input.TEXCOORD2.zz, u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlatb19 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb19){
        u_xlatb19 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat5.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat5.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat5.xyz);
        u_xlat5.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat5.xyz);
        u_xlat5.xyz = u_xlat5.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat5.xyz = (bool(u_xlatb19)) ? u_xlat5.xyz : input.TEXCOORD2.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat5.yzw = u_xlat5.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat19 = fma(u_xlat5.y, 0.25, 0.75);
        u_xlat20 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat5.x = max(u_xlat19, u_xlat20);
        u_xlat5 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat5.xzw);
    } else {
        u_xlat5.x = float(1.0);
        u_xlat5.y = float(1.0);
        u_xlat5.z = float(1.0);
        u_xlat5.w = float(1.0);
    }
    u_xlat19 = dot(u_xlat5, FGlobals.unity_OcclusionMaskSelector);
    u_xlat19 = clamp(u_xlat19, 0.0f, 1.0f);
    u_xlat20 = _LightTexture0.sample(sampler_LightTexture0, u_xlat4.xy).w;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat4.xyz = float3(u_xlat19) * FGlobals._LightColor0.xyz;
    u_xlat19 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat5.xyz = float3(u_xlat19) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat19 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat19) * u_xlat3.xyz;
    u_xlat19 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat18), FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat0.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6.x = u_xlat0.x * u_xlat0.x;
    u_xlat6.x = dot(u_xlat6.xx, float2(u_xlat19));
    u_xlat6.x = u_xlat6.x + -0.5;
    u_xlat12 = (-u_xlat1.x) + 1.0;
    u_xlat13 = u_xlat12 * u_xlat12;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat12 = fma(u_xlat6.x, u_xlat12, 1.0);
    u_xlat13 = -abs(u_xlat18) + 1.0;
    u_xlat20 = u_xlat13 * u_xlat13;
    u_xlat20 = u_xlat20 * u_xlat20;
    u_xlat13 = u_xlat13 * u_xlat20;
    u_xlat6.x = fma(u_xlat6.x, u_xlat13, 1.0);
    u_xlat6.x = u_xlat6.x * u_xlat12;
    u_xlat12 = u_xlat19 * u_xlat19;
    u_xlat12 = max(u_xlat12, 0.00200000009);
    u_xlat13 = (-u_xlat12) + 1.0;
    u_xlat19 = fma(abs(u_xlat18), u_xlat13, u_xlat12);
    u_xlat13 = fma(u_xlat1.x, u_xlat13, u_xlat12);
    u_xlat18 = abs(u_xlat18) * u_xlat13;
    u_xlat18 = fma(u_xlat1.x, u_xlat19, u_xlat18);
    u_xlat18 = u_xlat18 + 9.99999975e-06;
    u_xlat18 = 0.5 / u_xlat18;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat13 = fma(u_xlat7, u_xlat12, (-u_xlat7));
    u_xlat7 = fma(u_xlat13, u_xlat7, 1.0);
    u_xlat12 = u_xlat12 * 0.318309873;
    u_xlat7 = fma(u_xlat7, u_xlat7, 1.00000001e-07);
    u_xlat12 = u_xlat12 / u_xlat7;
    u_xlat12 = u_xlat12 * u_xlat18;
    u_xlat12 = u_xlat12 * 3.14159274;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat6.y = sqrt(u_xlat12);
    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb18 = u_xlat18!=0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat12 = u_xlat18 * u_xlat6.y;
    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.xyz * float3(u_xlat12);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat19 = u_xlat0.x * u_xlat0.x;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat4.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat4.xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat3.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: SHADOWS_DEPTH SPOT 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Matrix4x4 unity_WorldToLight at 192
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    output.TEXCOORD1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2], u_xlat0.zzzz, u_xlat1);
    output.TEXCOORD3 = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 4
Set 2D Texture "_LightTexture0" to slot 1 sampler slot 2
Set 2D Texture "_LightTextureB0" to slot 2 sampler slot 3
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 0
Set 2D Texture "_ShadowMapTexture" to slot 4 sampler slot 1

Constant Buffer "FGlobals" (624 bytes) on slot 0 {
  Matrix4x4 unity_WorldToShadow[4] at 48
  Matrix4x4 unity_MatrixV at 336
  Matrix4x4 unity_ProbeVolumeWorldToObject at 416
  Matrix4x4 unity_WorldToLight at 528
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 _LightShadowData at 304
  Vector4 unity_ShadowFadeCenterAndType at 320
  Vector4 unity_ProbeVolumeParams at 400
  Vector3 unity_ProbeVolumeSizeInv at 480
  Vector3 unity_ProbeVolumeMin at 496
  Vector4 _LightColor0 at 512
  Float _Glossiness at 592
  Float _Metallic at 596
  Vector4 _Color at 608
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_WorldToShadow[16];
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::greater_equal);
fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_ShadowMapTexture [[ sampler (1) ]],
    sampler sampler_LightTexture0 [[ sampler (2) ]],
    sampler sampler_LightTextureB0 [[ sampler (3) ]],
    sampler sampler_MainTex [[ sampler (4) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture(1) ]] ,
    texture2d<float, access::sample > _LightTextureB0 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    depth2d<float, access::sample > _ShadowMapTexture [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float u_xlat16;
    float u_xlat18;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat25;
    float u_xlat26;
    float u_xlat27;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat3.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat5.xyz = u_xlat4.xyz * FGlobals._Color.xyz;
    u_xlat6 = input.TEXCOORD2.yyyy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat6 = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0], input.TEXCOORD2.xxxx, u_xlat6);
    u_xlat6 = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2], input.TEXCOORD2.zzzz, u_xlat6);
    u_xlat6 = u_xlat6 + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = (-u_xlat25) + u_xlat2.x;
    u_xlat25 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat2.x, u_xlat25);
    u_xlat25 = fma(u_xlat25, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlatb2 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb2){
        u_xlatb2 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat10.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat10.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat10.xyz);
        u_xlat10.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat10.xyz);
        u_xlat10.xyz = u_xlat10.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat10.xyz : input.TEXCOORD2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat10.x = fma(u_xlat2.y, 0.25, 0.75);
        u_xlat27 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat2.x = max(u_xlat10.x, u_xlat27);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    }
    u_xlat2.x = dot(u_xlat2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat7 = input.TEXCOORD2.yyyy * FGlobals.hlslcc_mtx4x4unity_WorldToShadow[1];
    u_xlat7 = fma(FGlobals.hlslcc_mtx4x4unity_WorldToShadow[0], input.TEXCOORD2.xxxx, u_xlat7);
    u_xlat7 = fma(FGlobals.hlslcc_mtx4x4unity_WorldToShadow[2], input.TEXCOORD2.zzzz, u_xlat7);
    u_xlat7 = u_xlat7 + FGlobals.hlslcc_mtx4x4unity_WorldToShadow[3];
    u_xlat10.xyz = u_xlat7.xyz / u_xlat7.www;
    u_xlat10.x = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat10.xy, saturate(u_xlat10.z), level(0.0));
    u_xlat18 = (-FGlobals._LightShadowData.x) + 1.0;
    u_xlat10.x = fma(u_xlat10.x, u_xlat18, FGlobals._LightShadowData.x);
    u_xlat2.x = (-u_xlat10.x) + u_xlat2.x;
    u_xlat25 = fma(u_xlat25, u_xlat2.x, u_xlat10.x);
    u_xlatb2 = 0.0<u_xlat6.z;
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat6.xy / u_xlat6.ww;
    u_xlat10.xy = u_xlat10.xy + float2(0.5, 0.5);
    u_xlat10.x = _LightTexture0.sample(sampler_LightTexture0, u_xlat10.xy).w;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat10.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat10.x = _LightTextureB0.sample(sampler_LightTextureB0, u_xlat10.xx).x;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat25 = u_xlat25 * u_xlat2.x;
    u_xlat2.xyz = float3(u_xlat25) * FGlobals._LightColor0.xyz;
    u_xlat25 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat6.xyz = float3(u_xlat25) * input.TEXCOORD1.xyz;
    u_xlat4.xyz = fma(u_xlat4.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat4.xyz = fma(float3(FGlobals._Metallic), u_xlat4.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat25 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat5.xyz = float3(u_xlat25) * u_xlat5.xyz;
    u_xlat25 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat24), u_xlat3.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat26 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat3.x = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.x = dot(u_xlat8.xx, float2(u_xlat25));
    u_xlat8.x = u_xlat8.x + -0.5;
    u_xlat16 = (-u_xlat26) + 1.0;
    u_xlat1.x = u_xlat16 * u_xlat16;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16 = u_xlat16 * u_xlat1.x;
    u_xlat16 = fma(u_xlat8.x, u_xlat16, 1.0);
    u_xlat1.x = -abs(u_xlat24) + 1.0;
    u_xlat9 = u_xlat1.x * u_xlat1.x;
    u_xlat9 = u_xlat9 * u_xlat9;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat8.x = fma(u_xlat8.x, u_xlat1.x, 1.0);
    u_xlat8.x = u_xlat8.x * u_xlat16;
    u_xlat16 = u_xlat25 * u_xlat25;
    u_xlat16 = max(u_xlat16, 0.00200000009);
    u_xlat1.x = (-u_xlat16) + 1.0;
    u_xlat9 = fma(abs(u_xlat24), u_xlat1.x, u_xlat16);
    u_xlat1.x = fma(u_xlat26, u_xlat1.x, u_xlat16);
    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
    u_xlat24 = fma(u_xlat26, u_xlat9, u_xlat24);
    u_xlat24 = u_xlat24 + 9.99999975e-06;
    u_xlat24 = 0.5 / u_xlat24;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat1.x = fma(u_xlat3.x, u_xlat16, (-u_xlat3.x));
    u_xlat1.x = fma(u_xlat1.x, u_xlat3.x, 1.0);
    u_xlat16 = u_xlat16 * 0.318309873;
    u_xlat1.x = fma(u_xlat1.x, u_xlat1.x, 1.00000001e-07);
    u_xlat16 = u_xlat16 / u_xlat1.x;
    u_xlat16 = u_xlat16 * u_xlat24;
    u_xlat16 = u_xlat16 * 3.14159274;
    u_xlat16 = max(u_xlat16, 9.99999975e-05);
    u_xlat8.y = sqrt(u_xlat16);
    u_xlat8.xy = float2(u_xlat26) * u_xlat8.xy;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlatb24 = u_xlat24!=0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16 = u_xlat24 * u_xlat8.y;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.xyz = u_xlat2.xyz * float3(u_xlat16);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat25 = u_xlat0.x * u_xlat0.x;
    u_xlat25 = u_xlat25 * u_xlat25;
    u_xlat0.x = u_xlat0.x * u_xlat25;
    u_xlat2.xyz = (-u_xlat4.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat2.xyz, u_xlat0.xxx, u_xlat4.xyz);
    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat5.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: SHADOWS_DEPTH SHADOWS_SOFT SPOT 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Matrix4x4 unity_WorldToLight at 192
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    output.TEXCOORD1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2], u_xlat0.zzzz, u_xlat1);
    output.TEXCOORD3 = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3], u_xlat0.wwww, u_xlat1);
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 4
Set 2D Texture "_LightTexture0" to slot 1 sampler slot 2
Set 2D Texture "_LightTextureB0" to slot 2 sampler slot 3
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 0
Set 2D Texture "_ShadowMapTexture" to slot 4 sampler slot 1

Constant Buffer "FGlobals" (640 bytes) on slot 0 {
  Matrix4x4 unity_WorldToShadow[4] at 48
  Matrix4x4 unity_MatrixV at 336
  Matrix4x4 unity_ProbeVolumeWorldToObject at 416
  Matrix4x4 unity_WorldToLight at 544
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 _LightShadowData at 304
  Vector4 unity_ShadowFadeCenterAndType at 320
  Vector4 unity_ProbeVolumeParams at 400
  Vector3 unity_ProbeVolumeSizeInv at 480
  Vector3 unity_ProbeVolumeMin at 496
  Vector4 _LightColor0 at 512
  Vector4 _ShadowMapTexture_TexelSize at 528
  Float _Glossiness at 608
  Float _Metallic at 612
  Vector4 _Color at 624
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 hlslcc_mtx4x4unity_WorldToShadow[16];
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 _ShadowMapTexture_TexelSize;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::greater_equal);
fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_ShadowMapTexture [[ sampler (1) ]],
    sampler sampler_LightTexture0 [[ sampler (2) ]],
    sampler sampler_LightTextureB0 [[ sampler (3) ]],
    sampler sampler_MainTex [[ sampler (4) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture(1) ]] ,
    texture2d<float, access::sample > _LightTextureB0 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    depth2d<float, access::sample > _ShadowMapTexture [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float4 u_xlat6;
    float4 u_xlat7;
    float4 u_xlat8;
    float4 u_xlat9;
    float4 u_xlat10;
    float4 u_xlat11;
    float3 u_xlat12;
    float u_xlat13;
    float3 u_xlat14;
    bool u_xlatb14;
    float u_xlat24;
    float u_xlat26;
    float2 u_xlat31;
    float u_xlat36;
    bool u_xlatb36;
    float u_xlat37;
    float u_xlat38;
    float u_xlat39;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceLightPos0.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat1.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat37 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat37 = rsqrt(u_xlat37);
    u_xlat3.xyz = float3(u_xlat37) * u_xlat2.xyz;
    u_xlat4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat5.xyz = u_xlat4.xyz * FGlobals._Color.xyz;
    u_xlat6 = input.TEXCOORD2.yyyy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1];
    u_xlat6 = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0], input.TEXCOORD2.xxxx, u_xlat6);
    u_xlat6 = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2], input.TEXCOORD2.zzzz, u_xlat6);
    u_xlat6 = u_xlat6 + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3];
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat37 = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = (-u_xlat37) + u_xlat2.x;
    u_xlat37 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat2.x, u_xlat37);
    u_xlat37 = fma(u_xlat37, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat37 = clamp(u_xlat37, 0.0f, 1.0f);
    u_xlatb2 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb2){
        u_xlatb2 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat14.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat14.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat14.xyz);
        u_xlat14.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat14.xyz);
        u_xlat14.xyz = u_xlat14.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat14.xyz : input.TEXCOORD2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat14.x = fma(u_xlat2.y, 0.25, 0.75);
        u_xlat39 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat2.x = max(u_xlat14.x, u_xlat39);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    }
    u_xlat2.x = dot(u_xlat2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlatb14 = u_xlat37<0.99000001;
    if(u_xlatb14){
        u_xlat7 = input.TEXCOORD2.yyyy * FGlobals.hlslcc_mtx4x4unity_WorldToShadow[1];
        u_xlat7 = fma(FGlobals.hlslcc_mtx4x4unity_WorldToShadow[0], input.TEXCOORD2.xxxx, u_xlat7);
        u_xlat7 = fma(FGlobals.hlslcc_mtx4x4unity_WorldToShadow[2], input.TEXCOORD2.zzzz, u_xlat7);
        u_xlat7 = u_xlat7 + FGlobals.hlslcc_mtx4x4unity_WorldToShadow[3];
        u_xlat14.xyz = u_xlat7.xyz / u_xlat7.www;
        u_xlat7.xy = fma(u_xlat14.xy, FGlobals._ShadowMapTexture_TexelSize.zw, float2(0.5, 0.5));
        u_xlat7.xy = floor(u_xlat7.xy);
        u_xlat14.xy = fma(u_xlat14.xy, FGlobals._ShadowMapTexture_TexelSize.zw, (-u_xlat7.xy));
        u_xlat8 = u_xlat14.xxyy + float4(0.5, 1.0, 0.5, 1.0);
        u_xlat9.xw = u_xlat8.xz * u_xlat8.xz;
        u_xlat31.xy = fma(u_xlat9.xw, float2(0.5, 0.5), (-u_xlat14.xy));
        u_xlat8.xz = (-u_xlat14.xy) + float2(1.0, 1.0);
        u_xlat10.xy = min(u_xlat14.xy, float2(0.0, 0.0));
        u_xlat8.xz = fma((-u_xlat10.xy), u_xlat10.xy, u_xlat8.xz);
        u_xlat14.xy = max(u_xlat14.xy, float2(0.0, 0.0));
        u_xlat14.xy = fma((-u_xlat14.xy), u_xlat14.xy, u_xlat8.yw);
        u_xlat10.x = u_xlat31.x;
        u_xlat10.y = u_xlat8.x;
        u_xlat10.z = u_xlat14.x;
        u_xlat10.w = u_xlat9.x;
        u_xlat10 = u_xlat10 * float4(0.444440007, 0.444440007, 0.444440007, 0.222220004);
        u_xlat9.x = u_xlat31.y;
        u_xlat9.y = u_xlat8.z;
        u_xlat9.z = u_xlat14.y;
        u_xlat8 = u_xlat9 * float4(0.444440007, 0.444440007, 0.444440007, 0.222220004);
        u_xlat9 = u_xlat10.ywyw + u_xlat10.xzxz;
        u_xlat11 = u_xlat8.yyww + u_xlat8.xxzz;
        u_xlat14.xy = u_xlat10.yw / u_xlat9.zw;
        u_xlat14.xy = u_xlat14.xy + float2(-1.5, 0.5);
        u_xlat31.xy = u_xlat8.yw / u_xlat11.yw;
        u_xlat31.xy = u_xlat31.xy + float2(-1.5, 0.5);
        u_xlat8.xy = u_xlat14.xy * FGlobals._ShadowMapTexture_TexelSize.xx;
        u_xlat8.zw = u_xlat31.xy * FGlobals._ShadowMapTexture_TexelSize.yy;
        u_xlat9 = u_xlat9 * u_xlat11;
        u_xlat10 = fma(u_xlat7.xyxy, FGlobals._ShadowMapTexture_TexelSize.xyxy, u_xlat8.xzyz);
        u_xlat14.x = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat10.xy, saturate(u_xlat14.z), level(0.0));
        u_xlat26 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat10.zw, saturate(u_xlat14.z), level(0.0));
        u_xlat26 = u_xlat26 * u_xlat9.y;
        u_xlat14.x = fma(u_xlat9.x, u_xlat14.x, u_xlat26);
        u_xlat7 = fma(u_xlat7.xyxy, FGlobals._ShadowMapTexture_TexelSize.xyxy, u_xlat8.xwyw);
        u_xlat26 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat7.xy, saturate(u_xlat14.z), level(0.0));
        u_xlat14.x = fma(u_xlat9.z, u_xlat26, u_xlat14.x);
        u_xlat26 = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat7.zw, saturate(u_xlat14.z), level(0.0));
        u_xlat14.x = fma(u_xlat9.w, u_xlat26, u_xlat14.x);
        u_xlat26 = (-FGlobals._LightShadowData.x) + 1.0;
        u_xlat14.x = fma(u_xlat14.x, u_xlat26, FGlobals._LightShadowData.x);
    } else {
        u_xlat14.x = 1.0;
    }
    u_xlat2.x = (-u_xlat14.x) + u_xlat2.x;
    u_xlat37 = fma(u_xlat37, u_xlat2.x, u_xlat14.x);
    u_xlatb2 = 0.0<u_xlat6.z;
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat14.xy = u_xlat6.xy / u_xlat6.ww;
    u_xlat14.xy = u_xlat14.xy + float2(0.5, 0.5);
    u_xlat14.x = _LightTexture0.sample(sampler_LightTexture0, u_xlat14.xy).w;
    u_xlat2.x = u_xlat14.x * u_xlat2.x;
    u_xlat14.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat14.x = _LightTextureB0.sample(sampler_LightTextureB0, u_xlat14.xx).x;
    u_xlat2.x = u_xlat14.x * u_xlat2.x;
    u_xlat37 = u_xlat37 * u_xlat2.x;
    u_xlat2.xyz = float3(u_xlat37) * FGlobals._LightColor0.xyz;
    u_xlat37 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat37 = rsqrt(u_xlat37);
    u_xlat6.xyz = float3(u_xlat37) * input.TEXCOORD1.xyz;
    u_xlat4.xyz = fma(u_xlat4.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat4.xyz = fma(float3(FGlobals._Metallic), u_xlat4.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat37 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat5.xyz = float3(u_xlat37) * u_xlat5.xyz;
    u_xlat37 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat36), u_xlat3.xyz);
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = max(u_xlat36, 0.00100000005);
    u_xlat36 = rsqrt(u_xlat36);
    u_xlat0.xyz = float3(u_xlat36) * u_xlat0.xyz;
    u_xlat36 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat38 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0f, 1.0f);
    u_xlat3.x = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat12.x = u_xlat0.x * u_xlat0.x;
    u_xlat12.x = dot(u_xlat12.xx, float2(u_xlat37));
    u_xlat12.x = u_xlat12.x + -0.5;
    u_xlat24 = (-u_xlat38) + 1.0;
    u_xlat1.x = u_xlat24 * u_xlat24;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat24 = u_xlat24 * u_xlat1.x;
    u_xlat24 = fma(u_xlat12.x, u_xlat24, 1.0);
    u_xlat1.x = -abs(u_xlat36) + 1.0;
    u_xlat13 = u_xlat1.x * u_xlat1.x;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat1.x = u_xlat1.x * u_xlat13;
    u_xlat12.x = fma(u_xlat12.x, u_xlat1.x, 1.0);
    u_xlat12.x = u_xlat12.x * u_xlat24;
    u_xlat24 = u_xlat37 * u_xlat37;
    u_xlat24 = max(u_xlat24, 0.00200000009);
    u_xlat1.x = (-u_xlat24) + 1.0;
    u_xlat13 = fma(abs(u_xlat36), u_xlat1.x, u_xlat24);
    u_xlat1.x = fma(u_xlat38, u_xlat1.x, u_xlat24);
    u_xlat36 = abs(u_xlat36) * u_xlat1.x;
    u_xlat36 = fma(u_xlat38, u_xlat13, u_xlat36);
    u_xlat36 = u_xlat36 + 9.99999975e-06;
    u_xlat36 = 0.5 / u_xlat36;
    u_xlat24 = u_xlat24 * u_xlat24;
    u_xlat1.x = fma(u_xlat3.x, u_xlat24, (-u_xlat3.x));
    u_xlat1.x = fma(u_xlat1.x, u_xlat3.x, 1.0);
    u_xlat24 = u_xlat24 * 0.318309873;
    u_xlat1.x = fma(u_xlat1.x, u_xlat1.x, 1.00000001e-07);
    u_xlat24 = u_xlat24 / u_xlat1.x;
    u_xlat24 = u_xlat24 * u_xlat36;
    u_xlat24 = u_xlat24 * 3.14159274;
    u_xlat24 = max(u_xlat24, 9.99999975e-05);
    u_xlat12.y = sqrt(u_xlat24);
    u_xlat12.xy = float2(u_xlat38) * u_xlat12.xy;
    u_xlat36 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlatb36 = u_xlat36!=0.0;
    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
    u_xlat24 = u_xlat36 * u_xlat12.y;
    u_xlat1.xyz = u_xlat12.xxx * u_xlat2.xyz;
    u_xlat12.xyz = u_xlat2.xyz * float3(u_xlat24);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat37 = u_xlat0.x * u_xlat0.x;
    u_xlat37 = u_xlat37 * u_xlat37;
    u_xlat0.x = u_xlat0.x * u_xlat37;
    u_xlat2.xyz = (-u_xlat4.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat2.xyz, u_xlat0.xxx, u_xlat4.xyz);
    u_xlat0.xyz = u_xlat12.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat5.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL SHADOWS_SCREEN 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (224 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 unity_WorldToObject at 80
  Matrix4x4 unity_MatrixVP at 144
  Vector4 _ProjectionParams at 0
  Vector4 _MainTex_ST at 208
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat7;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.mtl_Position = u_xlat0;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat7 = rsqrt(u_xlat7);
    output.TEXCOORD1.xyz = float3(u_xlat7) * u_xlat1.xyz;
    u_xlat0.y = u_xlat0.y * VGlobals._ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * float3(0.5, 0.5, 0.5);
    output.TEXCOORD4.zw = u_xlat0.zw;
    output.TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 2
Set 2D Texture "_ShadowMapTexture" to slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 2 sampler slot 0

Constant Buffer "FGlobals" (304 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 80
  Matrix4x4 unity_ProbeVolumeWorldToObject at 160
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 _LightShadowData at 48
  Vector4 unity_ShadowFadeCenterAndType at 64
  Vector4 unity_ProbeVolumeParams at 144
  Vector3 unity_ProbeVolumeSizeInv at 224
  Vector3 unity_ProbeVolumeMin at 240
  Vector4 _LightColor0 at 256
  Float _Glossiness at 272
  Float _Metallic at 276
  Vector4 _Color at 288
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_ShadowMapTexture [[ sampler (1) ]],
    sampler sampler_MainTex [[ sampler (2) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _ShadowMapTexture [[ texture(1) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(2) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float4 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float u_xlat12;
    float u_xlat13;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat19;
    float u_xlat20;
    bool u_xlatb20;
    float u_xlat21;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat1.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat4.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat4.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat4.xyz);
    u_xlat4.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat20 = (-u_xlat19) + u_xlat20;
    u_xlat19 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat20, u_xlat19);
    u_xlat19 = fma(u_xlat19, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat19 = clamp(u_xlat19, 0.0f, 1.0f);
    u_xlatb20 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb20){
        u_xlatb20 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat4.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat4.xyz);
        u_xlat4.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat4.xyz);
        u_xlat4.xyz = u_xlat4.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat4.xyz = (bool(u_xlatb20)) ? u_xlat4.xyz : input.TEXCOORD2.xyz;
        u_xlat4.xyz = u_xlat4.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat4.yzw = u_xlat4.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat20 = fma(u_xlat4.y, 0.25, 0.75);
        u_xlat21 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat4.x = max(u_xlat20, u_xlat21);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xzw);
    } else {
        u_xlat4.x = float(1.0);
        u_xlat4.y = float(1.0);
        u_xlat4.z = float(1.0);
        u_xlat4.w = float(1.0);
    }
    u_xlat20 = dot(u_xlat4, FGlobals.unity_OcclusionMaskSelector);
    u_xlat20 = clamp(u_xlat20, 0.0f, 1.0f);
    u_xlat4.xy = input.TEXCOORD4.xy / input.TEXCOORD4.ww;
    u_xlat21 = _ShadowMapTexture.sample(sampler_ShadowMapTexture, u_xlat4.xy).x;
    u_xlat20 = u_xlat20 + (-u_xlat21);
    u_xlat19 = fma(u_xlat19, u_xlat20, u_xlat21);
    u_xlat4.xyz = float3(u_xlat19) * FGlobals._LightColor0.xyz;
    u_xlat19 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat5.xyz = float3(u_xlat19) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat19 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat19) * u_xlat3.xyz;
    u_xlat19 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat18), FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat0.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6.x = u_xlat0.x * u_xlat0.x;
    u_xlat6.x = dot(u_xlat6.xx, float2(u_xlat19));
    u_xlat6.x = u_xlat6.x + -0.5;
    u_xlat12 = (-u_xlat1.x) + 1.0;
    u_xlat13 = u_xlat12 * u_xlat12;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat12 = fma(u_xlat6.x, u_xlat12, 1.0);
    u_xlat13 = -abs(u_xlat18) + 1.0;
    u_xlat20 = u_xlat13 * u_xlat13;
    u_xlat20 = u_xlat20 * u_xlat20;
    u_xlat13 = u_xlat13 * u_xlat20;
    u_xlat6.x = fma(u_xlat6.x, u_xlat13, 1.0);
    u_xlat6.x = u_xlat6.x * u_xlat12;
    u_xlat12 = u_xlat19 * u_xlat19;
    u_xlat12 = max(u_xlat12, 0.00200000009);
    u_xlat13 = (-u_xlat12) + 1.0;
    u_xlat19 = fma(abs(u_xlat18), u_xlat13, u_xlat12);
    u_xlat13 = fma(u_xlat1.x, u_xlat13, u_xlat12);
    u_xlat18 = abs(u_xlat18) * u_xlat13;
    u_xlat18 = fma(u_xlat1.x, u_xlat19, u_xlat18);
    u_xlat18 = u_xlat18 + 9.99999975e-06;
    u_xlat18 = 0.5 / u_xlat18;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat13 = fma(u_xlat7, u_xlat12, (-u_xlat7));
    u_xlat7 = fma(u_xlat13, u_xlat7, 1.0);
    u_xlat12 = u_xlat12 * 0.318309873;
    u_xlat7 = fma(u_xlat7, u_xlat7, 1.00000001e-07);
    u_xlat12 = u_xlat12 / u_xlat7;
    u_xlat12 = u_xlat12 * u_xlat18;
    u_xlat12 = u_xlat12 * 3.14159274;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat6.y = sqrt(u_xlat12);
    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb18 = u_xlat18!=0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat12 = u_xlat18 * u_xlat6.y;
    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.xyz * float3(u_xlat12);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat19 = u_xlat0.x * u_xlat0.x;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat4.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat4.xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat3.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: DIRECTIONAL_COOKIE SHADOWS_SCREEN 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (288 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 unity_WorldToObject at 80
  Matrix4x4 unity_MatrixVP at 144
  Matrix4x4 unity_WorldToLight at 208
  Vector4 _ProjectionParams at 0
  Vector4 _MainTex_ST at 272
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 _ProjectionParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float2 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat9;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.mtl_Position = u_xlat1;
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0.xy = u_xlat2.yy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xy, u_xlat2.xx, u_xlat0.xy);
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xy, u_xlat2.zz, u_xlat0.xy);
    output.TEXCOORD3.xy = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xy, u_xlat2.ww, u_xlat0.xy);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = rsqrt(u_xlat9);
    output.TEXCOORD1.xyz = float3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.x = u_xlat1.y * VGlobals._ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * float2(0.5, 0.5);
    output.TEXCOORD4.zw = u_xlat1.zw;
    output.TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 3
Set 2D Texture "_ShadowMapTexture" to slot 1
Set 2D Texture "_LightTexture0" to slot 2
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 0

Constant Buffer "FGlobals" (368 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 80
  Matrix4x4 unity_ProbeVolumeWorldToObject at 160
  Matrix4x4 unity_WorldToLight at 272
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 unity_OcclusionMaskSelector at 32
  Vector4 _LightShadowData at 48
  Vector4 unity_ShadowFadeCenterAndType at 64
  Vector4 unity_ProbeVolumeParams at 144
  Vector3 unity_ProbeVolumeSizeInv at 224
  Vector3 unity_ProbeVolumeMin at 240
  Vector4 _LightColor0 at 256
  Float _Glossiness at 336
  Float _Metallic at 340
  Vector4 _Color at 352
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_ShadowMapTexture [[ sampler (1) ]],
    sampler sampler_LightTexture0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _ShadowMapTexture [[ texture(1) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    float4 u_xlat5;
    float3 u_xlat6;
    float u_xlat7;
    float u_xlat12;
    float u_xlat13;
    float2 u_xlat16;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat19;
    float u_xlat20;
    bool u_xlatb20;
    float u_xlat21;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat1.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat4.xy = input.TEXCOORD2.yy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xy;
    u_xlat4.xy = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xy, input.TEXCOORD2.xx, u_xlat4.xy);
    u_xlat4.xy = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xy, input.TEXCOORD2.zz, u_xlat4.xy);
    u_xlat4.xy = u_xlat4.xy + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xy;
    u_xlat5.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat5.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat19 = dot(u_xlat0.xyz, u_xlat5.xyz);
    u_xlat5.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat20 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat20 = sqrt(u_xlat20);
    u_xlat20 = (-u_xlat19) + u_xlat20;
    u_xlat19 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat20, u_xlat19);
    u_xlat19 = fma(u_xlat19, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat19 = clamp(u_xlat19, 0.0f, 1.0f);
    u_xlatb20 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb20){
        u_xlatb20 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat5.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat5.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat5.xyz);
        u_xlat5.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat5.xyz);
        u_xlat5.xyz = u_xlat5.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat5.xyz = (bool(u_xlatb20)) ? u_xlat5.xyz : input.TEXCOORD2.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat5.yzw = u_xlat5.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat20 = fma(u_xlat5.y, 0.25, 0.75);
        u_xlat21 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat5.x = max(u_xlat20, u_xlat21);
        u_xlat5 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat5.xzw);
    } else {
        u_xlat5.x = float(1.0);
        u_xlat5.y = float(1.0);
        u_xlat5.z = float(1.0);
        u_xlat5.w = float(1.0);
    }
    u_xlat20 = dot(u_xlat5, FGlobals.unity_OcclusionMaskSelector);
    u_xlat20 = clamp(u_xlat20, 0.0f, 1.0f);
    u_xlat16.xy = input.TEXCOORD4.xy / input.TEXCOORD4.ww;
    u_xlat21 = _ShadowMapTexture.sample(sampler_ShadowMapTexture, u_xlat16.xy).x;
    u_xlat20 = u_xlat20 + (-u_xlat21);
    u_xlat19 = fma(u_xlat19, u_xlat20, u_xlat21);
    u_xlat20 = _LightTexture0.sample(sampler_LightTexture0, u_xlat4.xy).w;
    u_xlat19 = u_xlat19 * u_xlat20;
    u_xlat4.xyz = float3(u_xlat19) * FGlobals._LightColor0.xyz;
    u_xlat19 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat19 = rsqrt(u_xlat19);
    u_xlat5.xyz = float3(u_xlat19) * input.TEXCOORD1.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat2.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat19 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat3.xyz = float3(u_xlat19) * u_xlat3.xyz;
    u_xlat19 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat18), FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = max(u_xlat18, 0.00100000005);
    u_xlat18 = rsqrt(u_xlat18);
    u_xlat0.xyz = float3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat5.xyz, FGlobals._WorldSpaceLightPos0.xyz);
    u_xlat1.x = clamp(u_xlat1.x, 0.0f, 1.0f);
    u_xlat7 = dot(u_xlat5.xyz, u_xlat0.xyz);
    u_xlat7 = clamp(u_xlat7, 0.0f, 1.0f);
    u_xlat0.x = dot(FGlobals._WorldSpaceLightPos0.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat6.x = u_xlat0.x * u_xlat0.x;
    u_xlat6.x = dot(u_xlat6.xx, float2(u_xlat19));
    u_xlat6.x = u_xlat6.x + -0.5;
    u_xlat12 = (-u_xlat1.x) + 1.0;
    u_xlat13 = u_xlat12 * u_xlat12;
    u_xlat13 = u_xlat13 * u_xlat13;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat12 = fma(u_xlat6.x, u_xlat12, 1.0);
    u_xlat13 = -abs(u_xlat18) + 1.0;
    u_xlat20 = u_xlat13 * u_xlat13;
    u_xlat20 = u_xlat20 * u_xlat20;
    u_xlat13 = u_xlat13 * u_xlat20;
    u_xlat6.x = fma(u_xlat6.x, u_xlat13, 1.0);
    u_xlat6.x = u_xlat6.x * u_xlat12;
    u_xlat12 = u_xlat19 * u_xlat19;
    u_xlat12 = max(u_xlat12, 0.00200000009);
    u_xlat13 = (-u_xlat12) + 1.0;
    u_xlat19 = fma(abs(u_xlat18), u_xlat13, u_xlat12);
    u_xlat13 = fma(u_xlat1.x, u_xlat13, u_xlat12);
    u_xlat18 = abs(u_xlat18) * u_xlat13;
    u_xlat18 = fma(u_xlat1.x, u_xlat19, u_xlat18);
    u_xlat18 = u_xlat18 + 9.99999975e-06;
    u_xlat18 = 0.5 / u_xlat18;
    u_xlat12 = u_xlat12 * u_xlat12;
    u_xlat13 = fma(u_xlat7, u_xlat12, (-u_xlat7));
    u_xlat7 = fma(u_xlat13, u_xlat7, 1.0);
    u_xlat12 = u_xlat12 * 0.318309873;
    u_xlat7 = fma(u_xlat7, u_xlat7, 1.00000001e-07);
    u_xlat12 = u_xlat12 / u_xlat7;
    u_xlat12 = u_xlat12 * u_xlat18;
    u_xlat12 = u_xlat12 * 3.14159274;
    u_xlat12 = max(u_xlat12, 9.99999975e-05);
    u_xlat6.y = sqrt(u_xlat12);
    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlatb18 = u_xlat18!=0.0;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat12 = u_xlat18 * u_xlat6.y;
    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
    u_xlat6.xyz = u_xlat4.xyz * float3(u_xlat12);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat19 = u_xlat0.x * u_xlat0.x;
    u_xlat19 = u_xlat19 * u_xlat19;
    u_xlat0.x = u_xlat0.x * u_xlat19;
    u_xlat4.xyz = (-u_xlat2.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat4.xyz, u_xlat0.xxx, u_xlat2.xyz);
    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat3.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: POINT SHADOWS_CUBE 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Matrix4x4 unity_WorldToLight at 192
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    output.TEXCOORD1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    output.TEXCOORD3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz, u_xlat0.www, u_xlat0.xyz);
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 3
Set 2D Texture "_LightTexture0" to slot 1 sampler slot 2
Set 3D Texture "unity_ProbeVolumeSH" to slot 2 sampler slot 0
Set CUBE Texture "_ShadowMapTexture" to slot 3 sampler slot 1

Constant Buffer "FGlobals" (400 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 112
  Matrix4x4 unity_ProbeVolumeWorldToObject at 192
  Matrix4x4 unity_WorldToLight at 304
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 _LightPositionRange at 32
  Vector4 _LightProjectionParams at 48
  Vector4 unity_OcclusionMaskSelector at 64
  Vector4 _LightShadowData at 80
  Vector4 unity_ShadowFadeCenterAndType at 96
  Vector4 unity_ProbeVolumeParams at 176
  Vector3 unity_ProbeVolumeSizeInv at 256
  Vector3 unity_ProbeVolumeMin at 272
  Vector4 _LightColor0 at 288
  Float _Glossiness at 368
  Float _Metallic at 372
  Vector4 _Color at 384
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 _LightPositionRange;
    float4 _LightProjectionParams;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::greater_equal);
fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_ShadowMapTexture [[ sampler (1) ]],
    sampler sampler_LightTexture0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture(1) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(2) ]] ,
    depthcube<float, access::sample > _ShadowMapTexture [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    float3 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float u_xlat16;
    float u_xlat18;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat25;
    float u_xlat26;
    float u_xlat27;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat3.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat5.xyz = u_xlat4.xyz * FGlobals._Color.xyz;
    u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = (-u_xlat25) + u_xlat2.x;
    u_xlat25 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat2.x, u_xlat25);
    u_xlat25 = fma(u_xlat25, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlatb2 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb2){
        u_xlatb2 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat10.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat10.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat10.xyz);
        u_xlat10.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat10.xyz);
        u_xlat10.xyz = u_xlat10.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat10.xyz : input.TEXCOORD2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat10.x = fma(u_xlat2.y, 0.25, 0.75);
        u_xlat27 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat2.x = max(u_xlat10.x, u_xlat27);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    }
    u_xlat2.x = dot(u_xlat2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat10.xyz = input.TEXCOORD2.xyz + (-FGlobals._LightPositionRange.xyz);
    u_xlat27 = max(abs(u_xlat10.y), abs(u_xlat10.x));
    u_xlat27 = max(abs(u_xlat10.z), u_xlat27);
    u_xlat27 = u_xlat27 + (-FGlobals._LightProjectionParams.z);
    u_xlat27 = max(u_xlat27, 9.99999975e-06);
    u_xlat27 = u_xlat27 * FGlobals._LightProjectionParams.w;
    u_xlat27 = FGlobals._LightProjectionParams.y / u_xlat27;
    u_xlat27 = u_xlat27 + (-FGlobals._LightProjectionParams.x);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat10.x = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat10.xyz, saturate(u_xlat27), level(0.0));
    u_xlat18 = (-FGlobals._LightShadowData.x) + 1.0;
    u_xlat10.x = fma(u_xlat10.x, u_xlat18, FGlobals._LightShadowData.x);
    u_xlat2.x = (-u_xlat10.x) + u_xlat2.x;
    u_xlat25 = fma(u_xlat25, u_xlat2.x, u_xlat10.x);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = _LightTexture0.sample(sampler_LightTexture0, u_xlat2.xx).x;
    u_xlat25 = u_xlat25 * u_xlat2.x;
    u_xlat2.xyz = float3(u_xlat25) * FGlobals._LightColor0.xyz;
    u_xlat25 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat6.xyz = float3(u_xlat25) * input.TEXCOORD1.xyz;
    u_xlat4.xyz = fma(u_xlat4.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat4.xyz = fma(float3(FGlobals._Metallic), u_xlat4.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat25 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat5.xyz = float3(u_xlat25) * u_xlat5.xyz;
    u_xlat25 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat24), u_xlat3.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat26 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat3.x = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.x = dot(u_xlat8.xx, float2(u_xlat25));
    u_xlat8.x = u_xlat8.x + -0.5;
    u_xlat16 = (-u_xlat26) + 1.0;
    u_xlat1.x = u_xlat16 * u_xlat16;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16 = u_xlat16 * u_xlat1.x;
    u_xlat16 = fma(u_xlat8.x, u_xlat16, 1.0);
    u_xlat1.x = -abs(u_xlat24) + 1.0;
    u_xlat9 = u_xlat1.x * u_xlat1.x;
    u_xlat9 = u_xlat9 * u_xlat9;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat8.x = fma(u_xlat8.x, u_xlat1.x, 1.0);
    u_xlat8.x = u_xlat8.x * u_xlat16;
    u_xlat16 = u_xlat25 * u_xlat25;
    u_xlat16 = max(u_xlat16, 0.00200000009);
    u_xlat1.x = (-u_xlat16) + 1.0;
    u_xlat9 = fma(abs(u_xlat24), u_xlat1.x, u_xlat16);
    u_xlat1.x = fma(u_xlat26, u_xlat1.x, u_xlat16);
    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
    u_xlat24 = fma(u_xlat26, u_xlat9, u_xlat24);
    u_xlat24 = u_xlat24 + 9.99999975e-06;
    u_xlat24 = 0.5 / u_xlat24;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat1.x = fma(u_xlat3.x, u_xlat16, (-u_xlat3.x));
    u_xlat1.x = fma(u_xlat1.x, u_xlat3.x, 1.0);
    u_xlat16 = u_xlat16 * 0.318309873;
    u_xlat1.x = fma(u_xlat1.x, u_xlat1.x, 1.00000001e-07);
    u_xlat16 = u_xlat16 / u_xlat1.x;
    u_xlat16 = u_xlat16 * u_xlat24;
    u_xlat16 = u_xlat16 * 3.14159274;
    u_xlat16 = max(u_xlat16, 9.99999975e-05);
    u_xlat8.y = sqrt(u_xlat16);
    u_xlat8.xy = float2(u_xlat26) * u_xlat8.xy;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlatb24 = u_xlat24!=0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16 = u_xlat24 * u_xlat8.y;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.xyz = u_xlat2.xyz * float3(u_xlat16);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat25 = u_xlat0.x * u_xlat0.x;
    u_xlat25 = u_xlat25 * u_xlat25;
    u_xlat0.x = u_xlat0.x * u_xlat25;
    u_xlat2.xyz = (-u_xlat4.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat2.xyz, u_xlat0.xxx, u_xlat4.xyz);
    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat5.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: POINT SHADOWS_CUBE SHADOWS_SOFT 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Matrix4x4 unity_WorldToLight at 192
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    output.TEXCOORD1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    output.TEXCOORD3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz, u_xlat0.www, u_xlat0.xyz);
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 3
Set 2D Texture "_LightTexture0" to slot 1 sampler slot 2
Set 3D Texture "unity_ProbeVolumeSH" to slot 2 sampler slot 0
Set CUBE Texture "_ShadowMapTexture" to slot 3 sampler slot 1

Constant Buffer "FGlobals" (400 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 112
  Matrix4x4 unity_ProbeVolumeWorldToObject at 192
  Matrix4x4 unity_WorldToLight at 304
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 _LightPositionRange at 32
  Vector4 _LightProjectionParams at 48
  Vector4 unity_OcclusionMaskSelector at 64
  Vector4 _LightShadowData at 80
  Vector4 unity_ShadowFadeCenterAndType at 96
  Vector4 unity_ProbeVolumeParams at 176
  Vector3 unity_ProbeVolumeSizeInv at 256
  Vector3 unity_ProbeVolumeMin at 272
  Vector4 _LightColor0 at 288
  Float _Glossiness at 368
  Float _Metallic at 372
  Vector4 _Color at 384
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 _LightPositionRange;
    float4 _LightProjectionParams;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::greater_equal);
fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_ShadowMapTexture [[ sampler (1) ]],
    sampler sampler_LightTexture0 [[ sampler (2) ]],
    sampler sampler_MainTex [[ sampler (3) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _LightTexture0 [[ texture(1) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(2) ]] ,
    depthcube<float, access::sample > _ShadowMapTexture [[ texture(3) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float u_xlat10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat18;
    float u_xlat20;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat28;
    float u_xlat29;
    float u_xlat30;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat1.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat2.xyz;
    u_xlat4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat5.xyz = u_xlat4.xyz * FGlobals._Color.xyz;
    u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
    u_xlat28 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat2.x, u_xlat28);
    u_xlat28 = fma(u_xlat28, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlatb2 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb2){
        u_xlatb2 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat11.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat11.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat11.xyz);
        u_xlat11.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat11.xyz);
        u_xlat11.xyz = u_xlat11.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : input.TEXCOORD2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat11.x = fma(u_xlat2.y, 0.25, 0.75);
        u_xlat30 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat2.x = max(u_xlat11.x, u_xlat30);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    }
    u_xlat2.x = dot(u_xlat2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlatb11 = u_xlat28<0.99000001;
    if(u_xlatb11){
        u_xlat11.xyz = input.TEXCOORD2.xyz + (-FGlobals._LightPositionRange.xyz);
        u_xlat30 = max(abs(u_xlat11.y), abs(u_xlat11.x));
        u_xlat30 = max(abs(u_xlat11.z), u_xlat30);
        u_xlat30 = u_xlat30 + (-FGlobals._LightProjectionParams.z);
        u_xlat30 = max(u_xlat30, 9.99999975e-06);
        u_xlat30 = u_xlat30 * FGlobals._LightProjectionParams.w;
        u_xlat30 = FGlobals._LightProjectionParams.y / u_xlat30;
        u_xlat30 = u_xlat30 + (-FGlobals._LightProjectionParams.x);
        u_xlat30 = (-u_xlat30) + 1.0;
        u_xlat7.xyz = u_xlat11.xyz + float3(0.0078125, 0.0078125, 0.0078125);
        u_xlat7.x = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat7.xyz, saturate(u_xlat30), level(0.0));
        u_xlat8.xyz = u_xlat11.xyz + float3(-0.0078125, -0.0078125, 0.0078125);
        u_xlat7.y = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat8.xyz, saturate(u_xlat30), level(0.0));
        u_xlat8.xyz = u_xlat11.xyz + float3(-0.0078125, 0.0078125, -0.0078125);
        u_xlat7.z = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat8.xyz, saturate(u_xlat30), level(0.0));
        u_xlat11.xyz = u_xlat11.xyz + float3(0.0078125, -0.0078125, -0.0078125);
        u_xlat7.w = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat11.xyz, saturate(u_xlat30), level(0.0));
        u_xlat11.x = dot(u_xlat7, float4(0.25, 0.25, 0.25, 0.25));
        u_xlat20 = (-FGlobals._LightShadowData.x) + 1.0;
        u_xlat11.x = fma(u_xlat11.x, u_xlat20, FGlobals._LightShadowData.x);
    } else {
        u_xlat11.x = 1.0;
    }
    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
    u_xlat28 = fma(u_xlat28, u_xlat2.x, u_xlat11.x);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = _LightTexture0.sample(sampler_LightTexture0, u_xlat2.xx).x;
    u_xlat28 = u_xlat28 * u_xlat2.x;
    u_xlat2.xyz = float3(u_xlat28) * FGlobals._LightColor0.xyz;
    u_xlat28 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat6.xyz = float3(u_xlat28) * input.TEXCOORD1.xyz;
    u_xlat4.xyz = fma(u_xlat4.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat4.xyz = fma(float3(FGlobals._Metallic), u_xlat4.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat28 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat5.xyz = float3(u_xlat28) * u_xlat5.xyz;
    u_xlat28 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), u_xlat3.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat29 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat3.x = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat0.x * u_xlat0.x;
    u_xlat9.x = dot(u_xlat9.xx, float2(u_xlat28));
    u_xlat9.x = u_xlat9.x + -0.5;
    u_xlat18 = (-u_xlat29) + 1.0;
    u_xlat1.x = u_xlat18 * u_xlat18;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat18 = u_xlat18 * u_xlat1.x;
    u_xlat18 = fma(u_xlat9.x, u_xlat18, 1.0);
    u_xlat1.x = -abs(u_xlat27) + 1.0;
    u_xlat10 = u_xlat1.x * u_xlat1.x;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat1.x = u_xlat1.x * u_xlat10;
    u_xlat9.x = fma(u_xlat9.x, u_xlat1.x, 1.0);
    u_xlat9.x = u_xlat9.x * u_xlat18;
    u_xlat18 = u_xlat28 * u_xlat28;
    u_xlat18 = max(u_xlat18, 0.00200000009);
    u_xlat1.x = (-u_xlat18) + 1.0;
    u_xlat10 = fma(abs(u_xlat27), u_xlat1.x, u_xlat18);
    u_xlat1.x = fma(u_xlat29, u_xlat1.x, u_xlat18);
    u_xlat27 = abs(u_xlat27) * u_xlat1.x;
    u_xlat27 = fma(u_xlat29, u_xlat10, u_xlat27);
    u_xlat27 = u_xlat27 + 9.99999975e-06;
    u_xlat27 = 0.5 / u_xlat27;
    u_xlat18 = u_xlat18 * u_xlat18;
    u_xlat1.x = fma(u_xlat3.x, u_xlat18, (-u_xlat3.x));
    u_xlat1.x = fma(u_xlat1.x, u_xlat3.x, 1.0);
    u_xlat18 = u_xlat18 * 0.318309873;
    u_xlat1.x = fma(u_xlat1.x, u_xlat1.x, 1.00000001e-07);
    u_xlat18 = u_xlat18 / u_xlat1.x;
    u_xlat18 = u_xlat18 * u_xlat27;
    u_xlat18 = u_xlat18 * 3.14159274;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat9.y = sqrt(u_xlat18);
    u_xlat9.xy = float2(u_xlat29) * u_xlat9.xy;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlatb27 = u_xlat27!=0.0;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat27 * u_xlat9.y;
    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
    u_xlat9.xyz = u_xlat2.xyz * float3(u_xlat18);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat28 = u_xlat0.x * u_xlat0.x;
    u_xlat28 = u_xlat28 * u_xlat28;
    u_xlat0.x = u_xlat0.x * u_xlat28;
    u_xlat2.xyz = (-u_xlat4.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat2.xyz, u_xlat0.xxx, u_xlat4.xyz);
    u_xlat0.xyz = u_xlat9.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat5.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: POINT_COOKIE SHADOWS_CUBE 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Matrix4x4 unity_WorldToLight at 192
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    output.TEXCOORD1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    output.TEXCOORD3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz, u_xlat0.www, u_xlat0.xyz);
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 4
Set 2D Texture "_LightTextureB0" to slot 1 sampler slot 3
Set CUBE Texture "_LightTexture0" to slot 2
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 0
Set CUBE Texture "_ShadowMapTexture" to slot 4 sampler slot 1

Constant Buffer "FGlobals" (400 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 112
  Matrix4x4 unity_ProbeVolumeWorldToObject at 192
  Matrix4x4 unity_WorldToLight at 304
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 _LightPositionRange at 32
  Vector4 _LightProjectionParams at 48
  Vector4 unity_OcclusionMaskSelector at 64
  Vector4 _LightShadowData at 80
  Vector4 unity_ShadowFadeCenterAndType at 96
  Vector4 unity_ProbeVolumeParams at 176
  Vector3 unity_ProbeVolumeSizeInv at 256
  Vector3 unity_ProbeVolumeMin at 272
  Vector4 _LightColor0 at 288
  Float _Glossiness at 368
  Float _Metallic at 372
  Vector4 _Color at 384
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 _LightPositionRange;
    float4 _LightProjectionParams;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::greater_equal);
fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_ShadowMapTexture [[ sampler (1) ]],
    sampler sampler_LightTexture0 [[ sampler (2) ]],
    sampler sampler_LightTextureB0 [[ sampler (3) ]],
    sampler sampler_MainTex [[ sampler (4) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _LightTextureB0 [[ texture(1) ]] ,
    texturecube<float, access::sample > _LightTexture0 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    depthcube<float, access::sample > _ShadowMapTexture [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    float3 u_xlat7;
    float3 u_xlat8;
    float u_xlat9;
    float3 u_xlat10;
    float u_xlat16;
    float u_xlat18;
    float u_xlat24;
    bool u_xlatb24;
    float u_xlat25;
    float u_xlat26;
    float u_xlat27;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceLightPos0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat1.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat3.xyz = float3(u_xlat25) * u_xlat2.xyz;
    u_xlat4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat5.xyz = u_xlat4.xyz * FGlobals._Color.xyz;
    u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = (-u_xlat25) + u_xlat2.x;
    u_xlat25 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat2.x, u_xlat25);
    u_xlat25 = fma(u_xlat25, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat25 = clamp(u_xlat25, 0.0f, 1.0f);
    u_xlatb2 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb2){
        u_xlatb2 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat10.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat10.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat10.xyz);
        u_xlat10.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat10.xyz);
        u_xlat10.xyz = u_xlat10.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat10.xyz : input.TEXCOORD2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat10.x = fma(u_xlat2.y, 0.25, 0.75);
        u_xlat27 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat2.x = max(u_xlat10.x, u_xlat27);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    }
    u_xlat2.x = dot(u_xlat2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlat10.xyz = input.TEXCOORD2.xyz + (-FGlobals._LightPositionRange.xyz);
    u_xlat27 = max(abs(u_xlat10.y), abs(u_xlat10.x));
    u_xlat27 = max(abs(u_xlat10.z), u_xlat27);
    u_xlat27 = u_xlat27 + (-FGlobals._LightProjectionParams.z);
    u_xlat27 = max(u_xlat27, 9.99999975e-06);
    u_xlat27 = u_xlat27 * FGlobals._LightProjectionParams.w;
    u_xlat27 = FGlobals._LightProjectionParams.y / u_xlat27;
    u_xlat27 = u_xlat27 + (-FGlobals._LightProjectionParams.x);
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat10.x = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat10.xyz, saturate(u_xlat27), level(0.0));
    u_xlat18 = (-FGlobals._LightShadowData.x) + 1.0;
    u_xlat10.x = fma(u_xlat10.x, u_xlat18, FGlobals._LightShadowData.x);
    u_xlat2.x = (-u_xlat10.x) + u_xlat2.x;
    u_xlat25 = fma(u_xlat25, u_xlat2.x, u_xlat10.x);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = _LightTextureB0.sample(sampler_LightTextureB0, u_xlat2.xx).x;
    u_xlat10.x = _LightTexture0.sample(sampler_LightTexture0, u_xlat6.xyz).w;
    u_xlat2.x = u_xlat10.x * u_xlat2.x;
    u_xlat25 = u_xlat25 * u_xlat2.x;
    u_xlat2.xyz = float3(u_xlat25) * FGlobals._LightColor0.xyz;
    u_xlat25 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat25 = rsqrt(u_xlat25);
    u_xlat6.xyz = float3(u_xlat25) * input.TEXCOORD1.xyz;
    u_xlat4.xyz = fma(u_xlat4.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat4.xyz = fma(float3(FGlobals._Metallic), u_xlat4.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat25 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat5.xyz = float3(u_xlat25) * u_xlat5.xyz;
    u_xlat25 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat24), u_xlat3.xyz);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = max(u_xlat24, 0.00100000005);
    u_xlat24 = rsqrt(u_xlat24);
    u_xlat0.xyz = float3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat26 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat26 = clamp(u_xlat26, 0.0f, 1.0f);
    u_xlat3.x = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat8.x = u_xlat0.x * u_xlat0.x;
    u_xlat8.x = dot(u_xlat8.xx, float2(u_xlat25));
    u_xlat8.x = u_xlat8.x + -0.5;
    u_xlat16 = (-u_xlat26) + 1.0;
    u_xlat1.x = u_xlat16 * u_xlat16;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat16 = u_xlat16 * u_xlat1.x;
    u_xlat16 = fma(u_xlat8.x, u_xlat16, 1.0);
    u_xlat1.x = -abs(u_xlat24) + 1.0;
    u_xlat9 = u_xlat1.x * u_xlat1.x;
    u_xlat9 = u_xlat9 * u_xlat9;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat8.x = fma(u_xlat8.x, u_xlat1.x, 1.0);
    u_xlat8.x = u_xlat8.x * u_xlat16;
    u_xlat16 = u_xlat25 * u_xlat25;
    u_xlat16 = max(u_xlat16, 0.00200000009);
    u_xlat1.x = (-u_xlat16) + 1.0;
    u_xlat9 = fma(abs(u_xlat24), u_xlat1.x, u_xlat16);
    u_xlat1.x = fma(u_xlat26, u_xlat1.x, u_xlat16);
    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
    u_xlat24 = fma(u_xlat26, u_xlat9, u_xlat24);
    u_xlat24 = u_xlat24 + 9.99999975e-06;
    u_xlat24 = 0.5 / u_xlat24;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat1.x = fma(u_xlat3.x, u_xlat16, (-u_xlat3.x));
    u_xlat1.x = fma(u_xlat1.x, u_xlat3.x, 1.0);
    u_xlat16 = u_xlat16 * 0.318309873;
    u_xlat1.x = fma(u_xlat1.x, u_xlat1.x, 1.00000001e-07);
    u_xlat16 = u_xlat16 / u_xlat1.x;
    u_xlat16 = u_xlat16 * u_xlat24;
    u_xlat16 = u_xlat16 * 3.14159274;
    u_xlat16 = max(u_xlat16, 9.99999975e-05);
    u_xlat8.y = sqrt(u_xlat16);
    u_xlat8.xy = float2(u_xlat26) * u_xlat8.xy;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlatb24 = u_xlat24!=0.0;
    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
    u_xlat16 = u_xlat24 * u_xlat8.y;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.xyz = u_xlat2.xyz * float3(u_xlat16);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat25 = u_xlat0.x * u_xlat0.x;
    u_xlat25 = u_xlat25 * u_xlat25;
    u_xlat0.x = u_xlat0.x * u_xlat25;
    u_xlat2.xyz = (-u_xlat4.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat2.xyz, u_xlat0.xxx, u_xlat4.xyz);
    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat5.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: POINT_COOKIE SHADOWS_CUBE SHADOWS_SOFT 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Matrix4x4 unity_WorldToLight at 192
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float3 TEXCOORD3 [[ user(TEXCOORD3) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat10;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat2);
    u_xlat2 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat2);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat2);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = rsqrt(u_xlat10);
    output.TEXCOORD1.xyz = float3(u_xlat10) * u_xlat1.xyz;
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3], input.POSITION0.wwww, u_xlat0);
    u_xlat1.xyz = u_xlat0.yyy * VGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat1.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, u_xlat0.xxx, u_xlat1.xyz);
    u_xlat0.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, u_xlat0.zzz, u_xlat1.xyz);
    output.TEXCOORD3.xyz = fma(VGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz, u_xlat0.www, u_xlat0.xyz);
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 4
Set 2D Texture "_LightTextureB0" to slot 1 sampler slot 3
Set CUBE Texture "_LightTexture0" to slot 2
Set 3D Texture "unity_ProbeVolumeSH" to slot 3 sampler slot 0
Set CUBE Texture "_ShadowMapTexture" to slot 4 sampler slot 1

Constant Buffer "FGlobals" (400 bytes) on slot 0 {
  Matrix4x4 unity_MatrixV at 112
  Matrix4x4 unity_ProbeVolumeWorldToObject at 192
  Matrix4x4 unity_WorldToLight at 304
  Vector3 _WorldSpaceCameraPos at 0
  Vector4 _WorldSpaceLightPos0 at 16
  Vector4 _LightPositionRange at 32
  Vector4 _LightProjectionParams at 48
  Vector4 unity_OcclusionMaskSelector at 64
  Vector4 _LightShadowData at 80
  Vector4 unity_ShadowFadeCenterAndType at 96
  Vector4 unity_ProbeVolumeParams at 176
  Vector3 unity_ProbeVolumeSizeInv at 256
  Vector3 unity_ProbeVolumeMin at 272
  Vector4 _LightColor0 at 288
  Float _Glossiness at 368
  Float _Metallic at 372
  Vector4 _Color at 384
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float3 _WorldSpaceCameraPos;
    float4 _WorldSpaceLightPos0;
    float4 _LightPositionRange;
    float4 _LightProjectionParams;
    float4 unity_OcclusionMaskSelector;
    float4 _LightShadowData;
    float4 unity_ShadowFadeCenterAndType;
    float4 hlslcc_mtx4x4unity_MatrixV[4];
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float4 _LightColor0;
    float4 hlslcc_mtx4x4unity_WorldToLight[4];
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
};

constexpr sampler _mtl_xl_shadow_sampler(address::clamp_to_edge, filter::linear, compare_func::greater_equal);
fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_ShadowMapTexture [[ sampler (1) ]],
    sampler sampler_LightTexture0 [[ sampler (2) ]],
    sampler sampler_LightTextureB0 [[ sampler (3) ]],
    sampler sampler_MainTex [[ sampler (4) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture2d<float, access::sample > _LightTextureB0 [[ texture(1) ]] ,
    texturecube<float, access::sample > _LightTexture0 [[ texture(2) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(3) ]] ,
    depthcube<float, access::sample > _ShadowMapTexture [[ texture(4) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    bool u_xlatb2;
    float3 u_xlat3;
    float3 u_xlat4;
    float3 u_xlat5;
    float3 u_xlat6;
    float4 u_xlat7;
    float3 u_xlat8;
    float3 u_xlat9;
    float u_xlat10;
    float3 u_xlat11;
    bool u_xlatb11;
    float u_xlat18;
    float u_xlat20;
    float u_xlat27;
    bool u_xlatb27;
    float u_xlat28;
    float u_xlat29;
    float u_xlat30;
    u_xlat0.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceLightPos0.xyz;
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat1.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat2.xyz = (-input.TEXCOORD2.xyz) + FGlobals._WorldSpaceCameraPos.xyzx.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat3.xyz = float3(u_xlat28) * u_xlat2.xyz;
    u_xlat4.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat5.xyz = u_xlat4.xyz * FGlobals._Color.xyz;
    u_xlat6.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_WorldToLight[1].xyz;
    u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[0].xyz, input.TEXCOORD2.xxx, u_xlat6.xyz);
    u_xlat6.xyz = fma(FGlobals.hlslcc_mtx4x4unity_WorldToLight[2].xyz, input.TEXCOORD2.zzz, u_xlat6.xyz);
    u_xlat6.xyz = u_xlat6.xyz + FGlobals.hlslcc_mtx4x4unity_WorldToLight[3].xyz;
    u_xlat7.x = FGlobals.hlslcc_mtx4x4unity_MatrixV[0].z;
    u_xlat7.y = FGlobals.hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.z = FGlobals.hlslcc_mtx4x4unity_MatrixV[2].z;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat7.xyz);
    u_xlat2.xyz = input.TEXCOORD2.xyz + (-FGlobals.unity_ShadowFadeCenterAndType.xyz);
    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = (-u_xlat28) + u_xlat2.x;
    u_xlat28 = fma(FGlobals.unity_ShadowFadeCenterAndType.w, u_xlat2.x, u_xlat28);
    u_xlat28 = fma(u_xlat28, FGlobals._LightShadowData.z, FGlobals._LightShadowData.w);
    u_xlat28 = clamp(u_xlat28, 0.0f, 1.0f);
    u_xlatb2 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb2){
        u_xlatb2 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat11.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat11.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat11.xyz);
        u_xlat11.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat11.xyz);
        u_xlat11.xyz = u_xlat11.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat11.xyz : input.TEXCOORD2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat11.x = fma(u_xlat2.y, 0.25, 0.75);
        u_xlat30 = fma(FGlobals.unity_ProbeVolumeParams.z, 0.5, 0.75);
        u_xlat2.x = max(u_xlat11.x, u_xlat30);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
    } else {
        u_xlat2.x = float(1.0);
        u_xlat2.y = float(1.0);
        u_xlat2.z = float(1.0);
        u_xlat2.w = float(1.0);
    }
    u_xlat2.x = dot(u_xlat2, FGlobals.unity_OcclusionMaskSelector);
    u_xlat2.x = clamp(u_xlat2.x, 0.0f, 1.0f);
    u_xlatb11 = u_xlat28<0.99000001;
    if(u_xlatb11){
        u_xlat11.xyz = input.TEXCOORD2.xyz + (-FGlobals._LightPositionRange.xyz);
        u_xlat30 = max(abs(u_xlat11.y), abs(u_xlat11.x));
        u_xlat30 = max(abs(u_xlat11.z), u_xlat30);
        u_xlat30 = u_xlat30 + (-FGlobals._LightProjectionParams.z);
        u_xlat30 = max(u_xlat30, 9.99999975e-06);
        u_xlat30 = u_xlat30 * FGlobals._LightProjectionParams.w;
        u_xlat30 = FGlobals._LightProjectionParams.y / u_xlat30;
        u_xlat30 = u_xlat30 + (-FGlobals._LightProjectionParams.x);
        u_xlat30 = (-u_xlat30) + 1.0;
        u_xlat7.xyz = u_xlat11.xyz + float3(0.0078125, 0.0078125, 0.0078125);
        u_xlat7.x = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat7.xyz, saturate(u_xlat30), level(0.0));
        u_xlat8.xyz = u_xlat11.xyz + float3(-0.0078125, -0.0078125, 0.0078125);
        u_xlat7.y = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat8.xyz, saturate(u_xlat30), level(0.0));
        u_xlat8.xyz = u_xlat11.xyz + float3(-0.0078125, 0.0078125, -0.0078125);
        u_xlat7.z = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat8.xyz, saturate(u_xlat30), level(0.0));
        u_xlat11.xyz = u_xlat11.xyz + float3(0.0078125, -0.0078125, -0.0078125);
        u_xlat7.w = _ShadowMapTexture.sample_compare(_mtl_xl_shadow_sampler, u_xlat11.xyz, saturate(u_xlat30), level(0.0));
        u_xlat11.x = dot(u_xlat7, float4(0.25, 0.25, 0.25, 0.25));
        u_xlat20 = (-FGlobals._LightShadowData.x) + 1.0;
        u_xlat11.x = fma(u_xlat11.x, u_xlat20, FGlobals._LightShadowData.x);
    } else {
        u_xlat11.x = 1.0;
    }
    u_xlat2.x = (-u_xlat11.x) + u_xlat2.x;
    u_xlat28 = fma(u_xlat28, u_xlat2.x, u_xlat11.x);
    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat2.x = _LightTextureB0.sample(sampler_LightTextureB0, u_xlat2.xx).x;
    u_xlat11.x = _LightTexture0.sample(sampler_LightTexture0, u_xlat6.xyz).w;
    u_xlat2.x = u_xlat11.x * u_xlat2.x;
    u_xlat28 = u_xlat28 * u_xlat2.x;
    u_xlat2.xyz = float3(u_xlat28) * FGlobals._LightColor0.xyz;
    u_xlat28 = dot(input.TEXCOORD1.xyz, input.TEXCOORD1.xyz);
    u_xlat28 = rsqrt(u_xlat28);
    u_xlat6.xyz = float3(u_xlat28) * input.TEXCOORD1.xyz;
    u_xlat4.xyz = fma(u_xlat4.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    u_xlat4.xyz = fma(float3(FGlobals._Metallic), u_xlat4.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat28 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat5.xyz = float3(u_xlat28) * u_xlat5.xyz;
    u_xlat28 = (-FGlobals._Glossiness) + 1.0;
    u_xlat0.xyz = fma(u_xlat0.xyz, float3(u_xlat27), u_xlat3.xyz);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = rsqrt(u_xlat27);
    u_xlat0.xyz = float3(u_xlat27) * u_xlat0.xyz;
    u_xlat27 = dot(u_xlat6.xyz, u_xlat3.xyz);
    u_xlat29 = dot(u_xlat6.xyz, u_xlat1.xyz);
    u_xlat29 = clamp(u_xlat29, 0.0f, 1.0f);
    u_xlat3.x = dot(u_xlat6.xyz, u_xlat0.xyz);
    u_xlat3.x = clamp(u_xlat3.x, 0.0f, 1.0f);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0f, 1.0f);
    u_xlat9.x = u_xlat0.x * u_xlat0.x;
    u_xlat9.x = dot(u_xlat9.xx, float2(u_xlat28));
    u_xlat9.x = u_xlat9.x + -0.5;
    u_xlat18 = (-u_xlat29) + 1.0;
    u_xlat1.x = u_xlat18 * u_xlat18;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat18 = u_xlat18 * u_xlat1.x;
    u_xlat18 = fma(u_xlat9.x, u_xlat18, 1.0);
    u_xlat1.x = -abs(u_xlat27) + 1.0;
    u_xlat10 = u_xlat1.x * u_xlat1.x;
    u_xlat10 = u_xlat10 * u_xlat10;
    u_xlat1.x = u_xlat1.x * u_xlat10;
    u_xlat9.x = fma(u_xlat9.x, u_xlat1.x, 1.0);
    u_xlat9.x = u_xlat9.x * u_xlat18;
    u_xlat18 = u_xlat28 * u_xlat28;
    u_xlat18 = max(u_xlat18, 0.00200000009);
    u_xlat1.x = (-u_xlat18) + 1.0;
    u_xlat10 = fma(abs(u_xlat27), u_xlat1.x, u_xlat18);
    u_xlat1.x = fma(u_xlat29, u_xlat1.x, u_xlat18);
    u_xlat27 = abs(u_xlat27) * u_xlat1.x;
    u_xlat27 = fma(u_xlat29, u_xlat10, u_xlat27);
    u_xlat27 = u_xlat27 + 9.99999975e-06;
    u_xlat27 = 0.5 / u_xlat27;
    u_xlat18 = u_xlat18 * u_xlat18;
    u_xlat1.x = fma(u_xlat3.x, u_xlat18, (-u_xlat3.x));
    u_xlat1.x = fma(u_xlat1.x, u_xlat3.x, 1.0);
    u_xlat18 = u_xlat18 * 0.318309873;
    u_xlat1.x = fma(u_xlat1.x, u_xlat1.x, 1.00000001e-07);
    u_xlat18 = u_xlat18 / u_xlat1.x;
    u_xlat18 = u_xlat18 * u_xlat27;
    u_xlat18 = u_xlat18 * 3.14159274;
    u_xlat18 = max(u_xlat18, 9.99999975e-05);
    u_xlat9.y = sqrt(u_xlat18);
    u_xlat9.xy = float2(u_xlat29) * u_xlat9.xy;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlatb27 = u_xlat27!=0.0;
    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
    u_xlat18 = u_xlat27 * u_xlat9.y;
    u_xlat1.xyz = u_xlat9.xxx * u_xlat2.xyz;
    u_xlat9.xyz = u_xlat2.xyz * float3(u_xlat18);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat28 = u_xlat0.x * u_xlat0.x;
    u_xlat28 = u_xlat28 * u_xlat28;
    u_xlat0.x = u_xlat0.x * u_xlat28;
    u_xlat2.xyz = (-u_xlat4.xyz) + float3(1.0, 1.0, 1.0);
    u_xlat2.xyz = fma(u_xlat2.xyz, u_xlat0.xxx, u_xlat4.xyz);
    u_xlat0.xyz = u_xlat9.xyz * u_xlat2.xyz;
    output.SV_Target0.xyz = fma(u_xlat5.xyz, u_xlat1.xyz, u_xlat0.xyz);
    output.SV_Target0.w = 1.0;
    return output;
}


 }
 Pass {
  Name "DEFERRED"
  Tags { "LIGHTMODE"="DEFERRED" "RenderType"="Opaque" }
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
Global Keywords: <none>
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (208 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Vector4 _MainTex_ST at 192
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0

Constant Buffer "FGlobals" (32 bytes) on slot 0 {
  Float _Glossiness at 0
  Float _Metallic at 4
  Vector4 _Color at 16
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    float4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    float4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    u_xlat0 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    output.SV_Target1.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    output.SV_Target0.xyz = float3(u_xlat0) * u_xlat1.xyz;
    output.SV_Target0.w = 1.0;
    output.SV_Target1.w = FGlobals._Glossiness;
    output.SV_Target2.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target2.w = 1.0;
    output.SV_Target3 = float4(1.0, 1.0, 1.0, 1.0);
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: LIGHTPROBE_SH 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 64
  Matrix4x4 unity_WorldToObject at 128
  Matrix4x4 unity_MatrixVP at 192
  Vector4 unity_SHBr at 0
  Vector4 unity_SHBg at 16
  Vector4 unity_SHBb at 32
  Vector4 unity_SHC at 48
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat6 = u_xlat0.y * u_xlat0.y;
    u_xlat6 = fma(u_xlat0.x, u_xlat0.x, (-u_xlat6));
    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat0.x = dot(VGlobals.unity_SHBr, u_xlat1);
    u_xlat0.y = dot(VGlobals.unity_SHBg, u_xlat1);
    u_xlat0.z = dot(VGlobals.unity_SHBb, u_xlat1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, float3(u_xlat6), u_xlat0.xyz);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 1 sampler slot 0

Constant Buffer "FGlobals" (192 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 64
  Vector4 unity_SHAr at 0
  Vector4 unity_SHAg at 16
  Vector4 unity_SHAb at 32
  Vector4 unity_ProbeVolumeParams at 48
  Vector3 unity_ProbeVolumeSizeInv at 128
  Vector3 unity_ProbeVolumeMin at 144
  Float _Glossiness at 160
  Float _Metallic at 164
  Vector4 _Color at 176
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    float4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    float4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float u_xlat8;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat19;
    u_xlat0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat0.xyz * FGlobals._Color.xyz;
    u_xlatb18 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb18){
        u_xlatb18 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat2.xyz);
        u_xlat2.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat2.xyz);
        u_xlat2.xyz = u_xlat2.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : input.TEXCOORD2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat18 = u_xlat2.y * 0.25;
        u_xlat19 = FGlobals.unity_ProbeVolumeParams.z * 0.5;
        u_xlat8 = fma((-FGlobals.unity_ProbeVolumeParams.z), 0.5, 0.25);
        u_xlat18 = max(u_xlat18, u_xlat19);
        u_xlat2.x = min(u_xlat8, u_xlat18);
        u_xlat3 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
        u_xlat4.xyz = u_xlat2.xzw + float3(0.25, 0.0, 0.0);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xyz);
        u_xlat2.xyz = u_xlat2.xzw + float3(0.5, 0.0, 0.0);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xyz);
        u_xlat5.xyz = input.TEXCOORD1.xyz;
        u_xlat5.w = 1.0;
        u_xlat3.x = dot(u_xlat3, u_xlat5);
        u_xlat3.y = dot(u_xlat4, u_xlat5);
        u_xlat3.z = dot(u_xlat2, u_xlat5);
    } else {
        u_xlat2.xyz = input.TEXCOORD1.xyz;
        u_xlat2.w = 1.0;
        u_xlat3.x = dot(FGlobals.unity_SHAr, u_xlat2);
        u_xlat3.y = dot(FGlobals.unity_SHAg, u_xlat2);
        u_xlat3.z = dot(FGlobals.unity_SHAb, u_xlat2);
    }
    u_xlat2.xyz = u_xlat3.xyz + input.TEXCOORD5.xyz;
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    output.SV_Target1.xyz = fma(float3(FGlobals._Metallic), u_xlat0.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.x = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat1.xyz));
    output.SV_Target0.xyz = u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
    output.SV_Target1.w = FGlobals._Glossiness;
    output.SV_Target2.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target2.w = 1.0;
    output.SV_Target3.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: UNITY_HDR_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (208 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 0
  Matrix4x4 unity_WorldToObject at 64
  Matrix4x4 unity_MatrixVP at 128
  Vector4 _MainTex_ST at 192
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    output.TEXCOORD1.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0

Constant Buffer "FGlobals" (32 bytes) on slot 0 {
  Float _Glossiness at 0
  Float _Metallic at 4
  Vector4 _Color at 16
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    float4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    float4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    u_xlat0 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    output.SV_Target1.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    output.SV_Target0.xyz = float3(u_xlat0) * u_xlat1.xyz;
    output.SV_Target0.w = 1.0;
    output.SV_Target1.w = FGlobals._Glossiness;
    output.SV_Target2.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target2.w = 1.0;
    output.SV_Target3 = float4(0.0, 0.0, 0.0, 1.0);
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: LIGHTPROBE_SH UNITY_HDR_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (272 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 64
  Matrix4x4 unity_WorldToObject at 128
  Matrix4x4 unity_MatrixVP at 192
  Vector4 unity_SHBr at 0
  Vector4 unity_SHBg at 16
  Vector4 unity_SHBb at 32
  Vector4 unity_SHC at 48
  Vector4 _MainTex_ST at 256
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 unity_SHBr;
    float4 unity_SHBg;
    float4 unity_SHBb;
    float4 unity_SHC;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4unity_WorldToObject[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat6;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat1 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    output.TEXCOORD2.xyz = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, input.POSITION0.www, u_xlat0.xyz);
    u_xlat0 = u_xlat1.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat1.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat1.zzzz, u_xlat0);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat1.wwww, u_xlat0);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat0.x = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(input.NORMAL0.xyz, VGlobals.hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = rsqrt(u_xlat6);
    u_xlat0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.TEXCOORD1.xyz = u_xlat0.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat6 = u_xlat0.y * u_xlat0.y;
    u_xlat6 = fma(u_xlat0.x, u_xlat0.x, (-u_xlat6));
    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
    u_xlat0.x = dot(VGlobals.unity_SHBr, u_xlat1);
    u_xlat0.y = dot(VGlobals.unity_SHBg, u_xlat1);
    u_xlat0.z = dot(VGlobals.unity_SHBb, u_xlat1);
    output.TEXCOORD5.xyz = fma(VGlobals.unity_SHC.xyz, float3(u_xlat6), u_xlat0.xyz);
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 1 sampler slot 0

Constant Buffer "FGlobals" (192 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 64
  Vector4 unity_SHAr at 0
  Vector4 unity_SHAg at 16
  Vector4 unity_SHAb at 32
  Vector4 unity_ProbeVolumeParams at 48
  Vector3 unity_ProbeVolumeSizeInv at 128
  Vector3 unity_ProbeVolumeMin at 144
  Float _Glossiness at 160
  Float _Metallic at 164
  Vector4 _Color at 176
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 unity_SHAr;
    float4 unity_SHAg;
    float4 unity_SHAb;
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    float4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    float4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float u_xlat8;
    float u_xlat18;
    bool u_xlatb18;
    float u_xlat19;
    u_xlat0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat0.xyz * FGlobals._Color.xyz;
    u_xlatb18 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb18){
        u_xlatb18 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat2.xyz);
        u_xlat2.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat2.xyz);
        u_xlat2.xyz = u_xlat2.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : input.TEXCOORD2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat18 = u_xlat2.y * 0.25;
        u_xlat19 = FGlobals.unity_ProbeVolumeParams.z * 0.5;
        u_xlat8 = fma((-FGlobals.unity_ProbeVolumeParams.z), 0.5, 0.25);
        u_xlat18 = max(u_xlat18, u_xlat19);
        u_xlat2.x = min(u_xlat8, u_xlat18);
        u_xlat3 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
        u_xlat4.xyz = u_xlat2.xzw + float3(0.25, 0.0, 0.0);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xyz);
        u_xlat2.xyz = u_xlat2.xzw + float3(0.5, 0.0, 0.0);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xyz);
        u_xlat5.xyz = input.TEXCOORD1.xyz;
        u_xlat5.w = 1.0;
        u_xlat3.x = dot(u_xlat3, u_xlat5);
        u_xlat3.y = dot(u_xlat4, u_xlat5);
        u_xlat3.z = dot(u_xlat2, u_xlat5);
    } else {
        u_xlat2.xyz = input.TEXCOORD1.xyz;
        u_xlat2.w = 1.0;
        u_xlat3.x = dot(FGlobals.unity_SHAr, u_xlat2);
        u_xlat3.y = dot(FGlobals.unity_SHAg, u_xlat2);
        u_xlat3.z = dot(FGlobals.unity_SHAb, u_xlat2);
    }
    u_xlat2.xyz = u_xlat3.xyz + input.TEXCOORD5.xyz;
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    output.SV_Target1.xyz = fma(float3(FGlobals._Metallic), u_xlat0.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.x = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.SV_Target3.xyz = u_xlat2.xyz * u_xlat0.xyz;
    output.SV_Target0.xyz = u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
    output.SV_Target1.w = FGlobals._Glossiness;
    output.SV_Target2.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target2.w = 1.0;
    output.SV_Target3.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: INSTANCING_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (80 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 0
  Vector4 _MainTex_ST at 64
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    float u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 0x3;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    output.TEXCOORD2.xyz = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat1 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat1);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = rsqrt(u_xlat0);
    output.TEXCOORD1.xyz = float3(u_xlat0) * u_xlat1.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0

Constant Buffer "FGlobals" (32 bytes) on slot 0 {
  Float _Glossiness at 0
  Float _Metallic at 4
  Vector4 _Color at 16
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    float4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    float4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    u_xlat0 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    output.SV_Target1.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    output.SV_Target0.xyz = float3(u_xlat0) * u_xlat1.xyz;
    output.SV_Target0.w = 1.0;
    output.SV_Target1.w = FGlobals._Glossiness;
    output.SV_Target2.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target2.w = 1.0;
    output.SV_Target3 = float4(1.0, 1.0, 1.0, 1.0);
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: INSTANCING_ON LIGHTPROBE_SH 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (80 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 0
  Vector4 _MainTex_ST at 64
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}
Constant Buffer "UnityInstancing_PerDraw2" (224 bytes) on slot 3 {
  Struct unity_Builtins2Array [112][2] at 0 {
    Vector4 unity_SHArArray at 0
    Vector4 unity_SHAgArray at 16
    Vector4 unity_SHAbArray at 32
    Vector4 unity_SHBrArray at 48
    Vector4 unity_SHBgArray at 64
    Vector4 unity_SHBbArray at 80
    Vector4 unity_SHCArray at 96
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct unity_Builtins2Array_Type
{
    float4 unity_SHArArray;
    float4 unity_SHAgArray;
    float4 unity_SHAbArray;
    float4 unity_SHBrArray;
    float4 unity_SHBgArray;
    float4 unity_SHBbArray;
    float4 unity_SHCArray;
};

struct UnityInstancing_PerDraw2_Type
{
    unity_Builtins2Array_Type unity_Builtins2Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    const constant unity_Builtins2Array_Type* UnityInstancing_PerDraw2 [[ buffer(3) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    int u_xlati4;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati4 = u_xlati0 << 0x3;
    u_xlati0 = u_xlati0 * 0x7;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    output.TEXCOORD2.xyz = fma(UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat1 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat1);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat4.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.x = u_xlat4.y * u_xlat4.y;
    u_xlat1.x = fma(u_xlat4.x, u_xlat4.x, (-u_xlat1.x));
    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat3.x = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBrArray, u_xlat2);
    u_xlat3.y = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBgArray, u_xlat2);
    u_xlat3.z = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBbArray, u_xlat2);
    output.TEXCOORD5.xyz = fma(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHCArray.xyz, u_xlat1.xxx, u_xlat3.xyz);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 1 sampler slot 0

Constant Buffer "FGlobals" (144 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 16
  Vector4 unity_ProbeVolumeParams at 0
  Vector3 unity_ProbeVolumeSizeInv at 80
  Vector3 unity_ProbeVolumeMin at 96
  Float _Glossiness at 112
  Float _Metallic at 116
  Vector4 _Color at 128
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw2" (224 bytes) on slot 2 {
  Struct unity_Builtins2Array [112][2] at 0 {
    Vector4 unity_SHArArray at 0
    Vector4 unity_SHAgArray at 16
    Vector4 unity_SHAbArray at 32
    Vector4 unity_SHBrArray at 48
    Vector4 unity_SHBgArray at 64
    Vector4 unity_SHBbArray at 80
    Vector4 unity_SHCArray at 96
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins2Array_Type
{
    float4 unity_SHArArray;
    float4 unity_SHAgArray;
    float4 unity_SHAbArray;
    float4 unity_SHBrArray;
    float4 unity_SHBgArray;
    float4 unity_SHBbArray;
    float4 unity_SHCArray;
};

struct UnityInstancing_PerDraw2_Type
{
    unity_Builtins2Array_Type unity_Builtins2Array[2];
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]]  [[ flat ]];
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    float4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    float4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins2Array_Type* UnityInstancing_PerDraw2 [[ buffer(2) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float u_xlat8;
    float u_xlat18;
    int u_xlati18;
    bool u_xlatb18;
    float u_xlat19;
    u_xlat0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat0.xyz * FGlobals._Color.xyz;
    u_xlatb18 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb18){
        u_xlatb18 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat2.xyz);
        u_xlat2.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat2.xyz);
        u_xlat2.xyz = u_xlat2.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : input.TEXCOORD2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat18 = u_xlat2.y * 0.25;
        u_xlat19 = FGlobals.unity_ProbeVolumeParams.z * 0.5;
        u_xlat8 = fma((-FGlobals.unity_ProbeVolumeParams.z), 0.5, 0.25);
        u_xlat18 = max(u_xlat18, u_xlat19);
        u_xlat2.x = min(u_xlat8, u_xlat18);
        u_xlat3 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
        u_xlat4.xyz = u_xlat2.xzw + float3(0.25, 0.0, 0.0);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xyz);
        u_xlat2.xyz = u_xlat2.xzw + float3(0.5, 0.0, 0.0);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xyz);
        u_xlat5.xyz = input.TEXCOORD1.xyz;
        u_xlat5.w = 1.0;
        u_xlat3.x = dot(u_xlat3, u_xlat5);
        u_xlat3.y = dot(u_xlat4, u_xlat5);
        u_xlat3.z = dot(u_xlat2, u_xlat5);
    } else {
        u_xlati18 = int(input.SV_InstanceID0) + UnityDrawCallInfo.unity_BaseInstanceID;
        u_xlati18 = u_xlati18 * 0x7;
        u_xlat2.xyz = input.TEXCOORD1.xyz;
        u_xlat2.w = 1.0;
        u_xlat3.x = dot(UnityInstancing_PerDraw2[u_xlati18 / 7].unity_SHArArray, u_xlat2);
        u_xlat3.y = dot(UnityInstancing_PerDraw2[u_xlati18 / 7].unity_SHAgArray, u_xlat2);
        u_xlat3.z = dot(UnityInstancing_PerDraw2[u_xlati18 / 7].unity_SHAbArray, u_xlat2);
    }
    u_xlat2.xyz = u_xlat3.xyz + input.TEXCOORD5.xyz;
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    output.SV_Target1.xyz = fma(float3(FGlobals._Metallic), u_xlat0.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.x = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xyz;
    output.SV_Target3.xyz = exp2((-u_xlat1.xyz));
    output.SV_Target0.xyz = u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
    output.SV_Target1.w = FGlobals._Glossiness;
    output.SV_Target2.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target2.w = 1.0;
    output.SV_Target3.w = 1.0;
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: INSTANCING_ON UNITY_HDR_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (80 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 0
  Vector4 _MainTex_ST at 64
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    float u_xlat0;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati0 = u_xlati0 << 0x3;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    output.TEXCOORD2.xyz = fma(UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat1 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat1);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati0 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat0 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0 = rsqrt(u_xlat0);
    output.TEXCOORD1.xyz = float3(u_xlat0) * u_xlat1.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0

Constant Buffer "FGlobals" (32 bytes) on slot 0 {
  Float _Glossiness at 0
  Float _Metallic at 4
  Vector4 _Color at 16
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    float4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    float4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float u_xlat0;
    float3 u_xlat1;
    float3 u_xlat2;
    u_xlat0 = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat2.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat2.xyz * FGlobals._Color.xyz;
    u_xlat2.xyz = fma(u_xlat2.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    output.SV_Target1.xyz = fma(float3(FGlobals._Metallic), u_xlat2.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    output.SV_Target0.xyz = float3(u_xlat0) * u_xlat1.xyz;
    output.SV_Target0.w = 1.0;
    output.SV_Target1.w = FGlobals._Glossiness;
    output.SV_Target2.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target2.w = 1.0;
    output.SV_Target3 = float4(0.0, 0.0, 0.0, 1.0);
    return output;
}


//////////////////////////////////////////////////////
Global Keywords: INSTANCING_ON LIGHTPROBE_SH UNITY_HDR_ON 
Local Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Normal"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (80 bytes) on slot 0 {
  Matrix4x4 unity_MatrixVP at 0
  Vector4 _MainTex_ST at 64
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw0" (256 bytes) on slot 2 {
  Struct unity_Builtins0Array [128][2] at 0 {
    Matrix4x4 unity_ObjectToWorldArray at 0
    Matrix4x4 unity_WorldToObjectArray at 64
  }
}
Constant Buffer "UnityInstancing_PerDraw2" (224 bytes) on slot 3 {
  Struct unity_Builtins2Array [112][2] at 0 {
    Vector4 unity_SHArArray at 0
    Vector4 unity_SHAgArray at 16
    Vector4 unity_SHAbArray at 32
    Vector4 unity_SHBrArray at 48
    Vector4 unity_SHBgArray at 64
    Vector4 unity_SHBbArray at 80
    Vector4 unity_SHCArray at 96
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

struct VGlobals_Type
{
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _MainTex_ST;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins0Array_Type
{
    float4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
    float4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};

struct UnityInstancing_PerDraw0_Type
{
    unity_Builtins0Array_Type unity_Builtins0Array[2];
};

struct unity_Builtins2Array_Type
{
    float4 unity_SHArArray;
    float4 unity_SHAgArray;
    float4 unity_SHAbArray;
    float4 unity_SHBrArray;
    float4 unity_SHBgArray;
    float4 unity_SHBbArray;
    float4 unity_SHCArray;
};

struct UnityInstancing_PerDraw2_Type
{
    unity_Builtins2Array_Type unity_Builtins2Array[2];
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float3 NORMAL0 [[ attribute(1) ]] ;
    float4 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]];
    float4 TEXCOORD4 [[ user(TEXCOORD4) ]];
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]];
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins0Array_Type* UnityInstancing_PerDraw0 [[ buffer(2) ]],
    const constant unity_Builtins2Array_Type* UnityInstancing_PerDraw2 [[ buffer(3) ]],
    uint mtl_InstanceID [[ instance_id ]],
    uint mtl_BaseInstance [[ base_instance ]],
    Mtl_VertexIn input [[ stage_in ]])
{
#if !UNITY_SUPPORT_INDIRECT_BUFFERS
    mtl_BaseInstance = 0;
#endif
    mtl_InstanceID = mtl_InstanceID - mtl_BaseInstance;
    Mtl_VertexOut output;
    int u_xlati0;
    float4 u_xlat1;
    float4 u_xlat2;
    float3 u_xlat3;
    float3 u_xlat4;
    int u_xlati4;
    u_xlati0 = int(mtl_InstanceID) + UnityDrawCallInfo.unity_BaseInstanceID;
    u_xlati4 = u_xlati0 << 0x3;
    u_xlati0 = u_xlati0 * 0x7;
    u_xlat1 = input.POSITION0.yyyy * UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0], input.POSITION0.xxxx, u_xlat1);
    u_xlat1 = fma(UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2], input.POSITION0.zzzz, u_xlat1);
    u_xlat2 = u_xlat1 + UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    output.TEXCOORD2.xyz = fma(UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xyz, input.POSITION0.www, u_xlat1.xyz);
    u_xlat1 = u_xlat2.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat2.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat2.zzzz, u_xlat1);
    output.mtl_Position = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat2.wwww, u_xlat1);
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    u_xlat1.x = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[0].xyz);
    u_xlat1.y = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[1].xyz);
    u_xlat1.z = dot(input.NORMAL0.xyz, UnityInstancing_PerDraw0[u_xlati4 / 8].hlslcc_mtx4x4unity_WorldToObjectArray[2].xyz);
    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat4.x = rsqrt(u_xlat4.x);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    output.TEXCOORD1.xyz = u_xlat4.xyz;
    output.TEXCOORD4 = float4(0.0, 0.0, 0.0, 0.0);
    u_xlat1.x = u_xlat4.y * u_xlat4.y;
    u_xlat1.x = fma(u_xlat4.x, u_xlat4.x, (-u_xlat1.x));
    u_xlat2 = u_xlat4.yzzx * u_xlat4.xyzz;
    u_xlat3.x = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBrArray, u_xlat2);
    u_xlat3.y = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBgArray, u_xlat2);
    u_xlat3.z = dot(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHBbArray, u_xlat2);
    output.TEXCOORD5.xyz = fma(UnityInstancing_PerDraw2[u_xlati0 / 7].unity_SHCArray.xyz, u_xlat1.xxx, u_xlat3.xyz);
    output.SV_InstanceID0 = mtl_InstanceID;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0 sampler slot 1
Set 3D Texture "unity_ProbeVolumeSH" to slot 1 sampler slot 0

Constant Buffer "FGlobals" (144 bytes) on slot 0 {
  Matrix4x4 unity_ProbeVolumeWorldToObject at 16
  Vector4 unity_ProbeVolumeParams at 0
  Vector3 unity_ProbeVolumeSizeInv at 80
  Vector3 unity_ProbeVolumeMin at 96
  Float _Glossiness at 112
  Float _Metallic at 116
  Vector4 _Color at 128
}
Constant Buffer "UnityDrawCallInfo" (8 bytes) on slot 1 {
  ScalarInt unity_BaseInstanceID at 0
}
Constant Buffer "UnityInstancing_PerDraw2" (224 bytes) on slot 2 {
  Struct unity_Builtins2Array [112][2] at 0 {
    Vector4 unity_SHArArray at 0
    Vector4 unity_SHAgArray at 16
    Vector4 unity_SHAbArray at 32
    Vector4 unity_SHBrArray at 48
    Vector4 unity_SHBgArray at 64
    Vector4 unity_SHBbArray at 80
    Vector4 unity_SHCArray at 96
  }
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;

#if !(__HAVE_FMA__)
#define fma(a,b,c) ((a) * (b) + (c))
#endif

#ifndef XLT_REMAP_O
	#define XLT_REMAP_O {0, 1, 2, 3, 4, 5, 6, 7}
#endif
constexpr constant uint xlt_remap_o[] = XLT_REMAP_O;
struct FGlobals_Type
{
    float4 unity_ProbeVolumeParams;
    float4 hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[4];
    float3 unity_ProbeVolumeSizeInv;
    float3 unity_ProbeVolumeMin;
    float _Glossiness;
    float _Metallic;
    float4 _Color;
};

struct UnityDrawCallInfo_Type
{
    int unity_BaseInstanceID;
    int unity_InstanceCount;
};

struct unity_Builtins2Array_Type
{
    float4 unity_SHArArray;
    float4 unity_SHAgArray;
    float4 unity_SHAbArray;
    float4 unity_SHBrArray;
    float4 unity_SHBgArray;
    float4 unity_SHBbArray;
    float4 unity_SHCArray;
};

struct UnityInstancing_PerDraw2_Type
{
    unity_Builtins2Array_Type unity_Builtins2Array[2];
};

struct Mtl_FragmentIn
{
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float3 TEXCOORD1 [[ user(TEXCOORD1) ]] ;
    float3 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
    float3 TEXCOORD5 [[ user(TEXCOORD5) ]] ;
    uint SV_InstanceID0 [[ user(SV_InstanceID0) ]]  [[ flat ]];
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(xlt_remap_o[0]) ]];
    float4 SV_Target1 [[ color(xlt_remap_o[1]) ]];
    float4 SV_Target2 [[ color(xlt_remap_o[2]) ]];
    float4 SV_Target3 [[ color(xlt_remap_o[3]) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    constant UnityDrawCallInfo_Type& UnityDrawCallInfo [[ buffer(1) ]],
    const constant unity_Builtins2Array_Type* UnityInstancing_PerDraw2 [[ buffer(2) ]],
    sampler samplerunity_ProbeVolumeSH [[ sampler (0) ]],
    sampler sampler_MainTex [[ sampler (1) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    texture3d<float, access::sample > unity_ProbeVolumeSH [[ texture(1) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float3 u_xlat0;
    float3 u_xlat1;
    float4 u_xlat2;
    float4 u_xlat3;
    float4 u_xlat4;
    float4 u_xlat5;
    float u_xlat8;
    float u_xlat18;
    int u_xlati18;
    bool u_xlatb18;
    float u_xlat19;
    u_xlat0.xyz = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat0.xyz * FGlobals._Color.xyz;
    u_xlatb18 = FGlobals.unity_ProbeVolumeParams.x==1.0;
    if(u_xlatb18){
        u_xlatb18 = FGlobals.unity_ProbeVolumeParams.y==1.0;
        u_xlat2.xyz = input.TEXCOORD2.yyy * FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[1].xyz;
        u_xlat2.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[0].xyz, input.TEXCOORD2.xxx, u_xlat2.xyz);
        u_xlat2.xyz = fma(FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[2].xyz, input.TEXCOORD2.zzz, u_xlat2.xyz);
        u_xlat2.xyz = u_xlat2.xyz + FGlobals.hlslcc_mtx4x4unity_ProbeVolumeWorldToObject[3].xyz;
        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : input.TEXCOORD2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-FGlobals.unity_ProbeVolumeMin.xyzx.xyz);
        u_xlat2.yzw = u_xlat2.xyz * FGlobals.unity_ProbeVolumeSizeInv.xyzx.xyz;
        u_xlat18 = u_xlat2.y * 0.25;
        u_xlat19 = FGlobals.unity_ProbeVolumeParams.z * 0.5;
        u_xlat8 = fma((-FGlobals.unity_ProbeVolumeParams.z), 0.5, 0.25);
        u_xlat18 = max(u_xlat18, u_xlat19);
        u_xlat2.x = min(u_xlat8, u_xlat18);
        u_xlat3 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xzw);
        u_xlat4.xyz = u_xlat2.xzw + float3(0.25, 0.0, 0.0);
        u_xlat4 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat4.xyz);
        u_xlat2.xyz = u_xlat2.xzw + float3(0.5, 0.0, 0.0);
        u_xlat2 = unity_ProbeVolumeSH.sample(samplerunity_ProbeVolumeSH, u_xlat2.xyz);
        u_xlat5.xyz = input.TEXCOORD1.xyz;
        u_xlat5.w = 1.0;
        u_xlat3.x = dot(u_xlat3, u_xlat5);
        u_xlat3.y = dot(u_xlat4, u_xlat5);
        u_xlat3.z = dot(u_xlat2, u_xlat5);
    } else {
        u_xlati18 = int(input.SV_InstanceID0) + UnityDrawCallInfo.unity_BaseInstanceID;
        u_xlati18 = u_xlati18 * 0x7;
        u_xlat2.xyz = input.TEXCOORD1.xyz;
        u_xlat2.w = 1.0;
        u_xlat3.x = dot(UnityInstancing_PerDraw2[u_xlati18 / 7].unity_SHArArray, u_xlat2);
        u_xlat3.y = dot(UnityInstancing_PerDraw2[u_xlati18 / 7].unity_SHAgArray, u_xlat2);
        u_xlat3.z = dot(UnityInstancing_PerDraw2[u_xlati18 / 7].unity_SHAbArray, u_xlat2);
    }
    u_xlat2.xyz = u_xlat3.xyz + input.TEXCOORD5.xyz;
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * float3(0.416666657, 0.416666657, 0.416666657);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat2.xyz = fma(u_xlat2.xyz, float3(1.05499995, 1.05499995, 1.05499995), float3(-0.0549999997, -0.0549999997, -0.0549999997));
    u_xlat2.xyz = max(u_xlat2.xyz, float3(0.0, 0.0, 0.0));
    u_xlat0.xyz = fma(u_xlat0.xyz, FGlobals._Color.xyz, float3(-0.220916301, -0.220916301, -0.220916301));
    output.SV_Target1.xyz = fma(float3(FGlobals._Metallic), u_xlat0.xyz, float3(0.220916301, 0.220916301, 0.220916301));
    u_xlat0.x = fma((-FGlobals._Metallic), 0.779083729, 0.779083729);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.SV_Target3.xyz = u_xlat2.xyz * u_xlat0.xyz;
    output.SV_Target0.xyz = u_xlat0.xyz;
    output.SV_Target0.w = 1.0;
    output.SV_Target1.w = FGlobals._Glossiness;
    output.SV_Target2.xyz = fma(input.TEXCOORD1.xyz, float3(0.5, 0.5, 0.5), float3(0.5, 0.5, 0.5));
    output.SV_Target2.w = 1.0;
    output.SV_Target3.w = 1.0;
    return output;
}


 }
}
Fallback "Diffuse"
}