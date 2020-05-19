Shader "NatureManufacture Shaders/Water/Water Swamp Vertex Color Flow Mobile"
{
    Properties
    {
        _GlobalTiling("Global Tiling", Range(0.001, 100)) = 1
        [ToggleUI]_UVVDirection1UDirection0("UV Direction - V(T) U(F)", Float) = 1
        _SlowWaterSpeed("Main Water Speed", Vector) = (1, 1, 0, 0)
        _CascadeMainSpeed("Cascade Main Speed", Vector) = (2, 2, 0, 0)
        _Detail1MainSpeed("Detail 1 Main Speed", Vector) = (1, 1, 0, 0)
        _EdgeFalloffMultiply("Edge Falloff Multiply", Float) = 5.19
        _EdgeFalloffPower("Edge Falloff Power", Float) = 0.74
        _CleanFalloffMultiply("Clean Falloff Multiply", Float) = 14.09
        _CleanFalloffPower("Clean Falloff Power", Float) = 0.32
        _ShalowColor("Shalow Color", Color) = (0.1521983, 0.1698113, 0.1289604, 0)
        _ShalowFalloffMultiply("Shalow Falloff Multiply", Float) = 6.03
        _ShalowFalloffPower("Shalow Falloff Power", Float) = 2.34
        _DeepColor("Deep Color", Color) = (0.1029411, 0.08306279, 0.01816609, 0)
        _WaterAlphaMultiply("Water Alpha Multiply", Float) = 0.66
        _WaterAlphaPower("Water Alpha Power", Float) = 1.39
        _WaterSmoothness("Water Smoothness", Range(0, 1)) = 0.9
        _WaterSpecularClose("Water Specular Close", Range(0, 1)) = 0.9
        _WaterSpecularFar("Water Specular Far", Range(0, 1)) = 0.9
        _WaterSpecularThreshold("Water Specular Threshold", Range(0, 10)) = 0.39
        _Distortion("Distortion", Range(0, 1)) = 0.1
        _BackfaceAlpha("Backface Alpha", Range(0, 1)) = 1
        [NoScaleOffset]_SlowWaterNormal("Water Normal", 2D) = "bump" {}
        _SlowWaterTiling("Water Tiling", Vector) = (3, 3, 0, 0)
        _SlowNormalScale("Water Normal Scale", Float) = 0.2
        _CascadeAngle("Cascade Angle", Range(0.001, 90)) = 15
        _CascadeAngleFalloff("Cascade Angle Falloff", Range(0, 80)) = 0.7
        _CascadeTiling("Cascade Tiling", Vector) = (2, 2, 0, 0)
        _CascadeNormalScale("Cascade Normal Scale", Float) = 0.7
        _CascadeTransparency("Cascade Transparency", Range(0, 1)) = 0
        [NoScaleOffset]_Detail1GSmDetail2ASm("Detail 1 (G)Sm Detail 2 (A)Sm", 2D) = "white" {}
        [NoScaleOffset]_DetailAlbedo("Detail 1 Albedo", 2D) = "white" {}
        _Detail1Tiling("Detail 1 Tiling", Vector) = (3, 3, 0, 0)
        _DetailAlbedoColor("Detail 1 Albedo Color", Color) = (1, 1, 1, 0)
        [NoScaleOffset]_DetailNormal("Detail 1 Normal", 2D) = "white" {}
        _DetailNormalScale("Detail 1 Normal Scale", Float) = 1
        _DetailSmoothness("Detail 1 Smoothness", Range(0, 1)) = 1
        _Detail1Specular("Detail 1 Specular", Range(0, 1)) = 0
        [NoScaleOffset]_Noise("Noise Detail 1 (G) Detail 2(A)", 2D) = "white" {}
        _NoiseTiling1("Detail 1 Noise Tiling", Vector) = (3, 3, 0, 0)
        _Detail1NoisePower("Detail 1 Noise Power", Range(0, 10)) = 5.48
        _Detail1NoiseMultiply("Detail 1 Noise Multiply", Range(0, 40)) = 5
        _WaterFlowUVRefresSpeed("Water Flow UV Refresh Speed", Range(0, 1)) = 0.059
        _CascadeFlowUVRefreshSpeed("Cascade Flow UV Refresh Speed", Range(0, 1)) = 0.25
        _Detail1FlowUVRefreshSpeed("Detail 1 Flow UV Refresh Speed", Range(0, 1)) = 0.059
        _AOPower("Water AO Power", Range(0, 1)) = 1
        _DetailAOPower("Detail 1 AO Power", Range(0, 1)) = 1
        [Toggle]_DISTORTION("Use Distortion", Float) = 0
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "Queue"="Transparent+0"
        }
        
        Pass
        {
            Name "Universal Forward"
            Tags 
            { 
                "LightMode" = "UniversalForward"
            }
           
            // Render State
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>
            
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_fog
            #pragma multi_compile_instancing
        
            // Keywords
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
            #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile _ _SHADOWS_SOFT
            #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
            #pragma shader_feature_local _ _DISTORTION_ON
            
            #if defined(_DISTORTION_ON)
                #define KEYWORD_PERMUTATION_0
            #else
                #define KEYWORD_PERMUTATION_1
            #endif
            
            
            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif
        
        
        
            #define _NORMAL_DROPOFF_TS 1
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD3
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS 
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD3
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_CULLFACE
        #endif
        
            #define SHADERPASS_FORWARD
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define REQUIRE_DEPTH_TEXTURE
            #endif
            #if defined(KEYWORD_PERMUTATION_0)
            #define REQUIRE_OPAQUE_TEXTURE
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            half _GlobalTiling;
            half _UVVDirection1UDirection0;
            half2 _SlowWaterSpeed;
            half2 _CascadeMainSpeed;
            half2 _Detail1MainSpeed;
            half _EdgeFalloffMultiply;
            half _EdgeFalloffPower;
            half _CleanFalloffMultiply;
            half _CleanFalloffPower;
            half4 _ShalowColor;
            half _ShalowFalloffMultiply;
            half _ShalowFalloffPower;
            half4 _DeepColor;
            half _WaterAlphaMultiply;
            half _WaterAlphaPower;
            half _WaterSmoothness;
            half _WaterSpecularClose;
            half _WaterSpecularFar;
            half _WaterSpecularThreshold;
            half _Distortion;
            half _BackfaceAlpha;
            half2 _SlowWaterTiling;
            half _SlowNormalScale;
            half _CascadeAngle;
            half _CascadeAngleFalloff;
            half2 _CascadeTiling;
            half _CascadeNormalScale;
            half _CascadeTransparency;
            half2 _Detail1Tiling;
            half4 _DetailAlbedoColor;
            half _DetailNormalScale;
            half _DetailSmoothness;
            half _Detail1Specular;
            half2 _NoiseTiling1;
            half _Detail1NoisePower;
            half _Detail1NoiseMultiply;
            half _WaterFlowUVRefresSpeed;
            half _CascadeFlowUVRefreshSpeed;
            half _Detail1FlowUVRefreshSpeed;
            half _AOPower;
            half _DetailAOPower;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); half4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_Detail1GSmDetail2ASm); SAMPLER(sampler_Detail1GSmDetail2ASm); half4 _Detail1GSmDetail2ASm_TexelSize;
            TEXTURE2D(_DetailAlbedo); SAMPLER(sampler_DetailAlbedo); half4 _DetailAlbedo_TexelSize;
            TEXTURE2D(_DetailNormal); SAMPLER(sampler_DetailNormal); half4 _DetailNormal_TexelSize;
            TEXTURE2D(_Noise); SAMPLER(sampler_Noise); half4 _Noise_TexelSize;
            SAMPLER(_SampleTexture2D_91308B7C_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_4508A259_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_31496932_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_BEDCCB97_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_B8ACE3F1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A1621BBD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_E54CB7DD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_35B340E9_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_AEBC8292_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9126225F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_3529CBB1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_463471CC_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Multiply_half(half2 A, half2 B, out half2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_half2(half Predicate, half2 True, half2 False, out half2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Multiply_half(half A, half B, out half Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_half(half A, half B, out half Out)
            {
                Out = A + B;
            }
            
            void Unity_Fraction_half(half In, out half Out)
            {
                Out = frac(In);
            }
            
            void Unity_Divide_half(half A, half B, out half Out)
            {
                Out = A / B;
            }
            
            void Unity_Add_half2(half2 A, half2 B, out half2 Out)
            {
                Out = A + B;
            }
            
            void Unity_NormalStrength_half(half3 In, half Strength, out half3 Out)
            {
                Out = half3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
            }
            
            void Unity_Absolute_half(half In, out half Out)
            {
                Out = abs(In);
            }
            
            void Unity_Lerp_half3(half3 A, half3 B, half3 T, out half3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Lerp_half4(half4 A, half4 B, half4 T, out half4 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Lerp_half(half A, half B, half T, out half Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Power_half(half A, half B, out half Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Clamp_half(half In, half Min, half Max, out half Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_OneMinus_half(half In, out half Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Subtract_half(half A, half B, out half Out)
            {
                Out = A - B;
            }
            
            void Unity_Normalize_half3(half3 In, out half3 Out)
            {
                Out = normalize(In);
            }
            
            void Unity_Combine_half(half R, half G, half B, half A, out half4 RGBA, out half3 RGB, out half2 RG)
            {
                RGBA = half4(R, G, B, A);
                RGB = half3(R, G, B);
                RG = half2(R, G);
            }
            
            void Unity_SceneColor_half(half4 UV, out half3 Out)
            {
                Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
            }
            
            void Unity_SceneDepth_Linear01_half(half4 UV, out half Out)
            {
                Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
            
            void Unity_Saturate_half(half In, out half Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Multiply_half(half3 A, half3 B, out half3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Multiply_half(half4 A, half4 B, out half4 Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_half(half Predicate, half True, half False, out half Out)
            {
                Out = lerp(False, True, Predicate);
            }
        
            // Graph Vertex
            // GraphVertex: <None>
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpacePosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 ScreenPosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 VertexColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 TimeParameters;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float FaceSign;
                #endif
            };
            
            struct SurfaceDescription
            {
                half3 Albedo;
                half3 Normal;
                half3 Emission;
                half3 Specular;
                half Smoothness;
                half Occlusion;
                half Alpha;
                half AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _ScreenPosition_590B4FA3_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_FC343CDD_Out_0 = _Distortion;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_half(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_AA9F78F6_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_half(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                half _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                half _Split_1CCC86B0_B_3 = 0;
                half _Split_1CCC86B0_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_D812D559_Out_0 = half2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_FA6538E6_Out_3;
                Unity_Branch_half2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_41D6C6C9_Out_2;
                Unity_Add_half(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_half(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_half(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_52173963_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_654AFB32_Out_2;
                Unity_Divide_half(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_B5F91807_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_half(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_half((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_7772C3BA_Out_2;
                Unity_Add_half2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_7772C3BA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_91308B7C_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_7772C3BA_Out_2);
                _SampleTexture2D_91308B7C_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_91308B7C_RGBA_0);
                half _SampleTexture2D_91308B7C_R_4 = _SampleTexture2D_91308B7C_RGBA_0.r;
                half _SampleTexture2D_91308B7C_G_5 = _SampleTexture2D_91308B7C_RGBA_0.g;
                half _SampleTexture2D_91308B7C_B_6 = _SampleTexture2D_91308B7C_RGBA_0.b;
                half _SampleTexture2D_91308B7C_A_7 = _SampleTexture2D_91308B7C_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_BE91B4F6_Out_0 = _SlowNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _NormalStrength_528ACD86_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_91308B7C_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_528ACD86_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_31890938_Out_2;
                Unity_Add_half(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_F03C9359_Out_1;
                Unity_Fraction_half(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_FE081078_Out_2;
                Unity_Multiply_half(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_C1F18389_Out_2;
                Unity_Add_half2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_C1F18389_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_4508A259_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_C1F18389_Out_2);
                _SampleTexture2D_4508A259_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_4508A259_RGBA_0);
                half _SampleTexture2D_4508A259_R_4 = _SampleTexture2D_4508A259_RGBA_0.r;
                half _SampleTexture2D_4508A259_G_5 = _SampleTexture2D_4508A259_RGBA_0.g;
                half _SampleTexture2D_4508A259_B_6 = _SampleTexture2D_4508A259_RGBA_0.b;
                half _SampleTexture2D_4508A259_A_7 = _SampleTexture2D_4508A259_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _NormalStrength_3BD81F5D_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_4508A259_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_3BD81F5D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_9431F443_Out_2;
                Unity_Add_half(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_483E3720_Out_2;
                Unity_Multiply_half(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_6685A82A_Out_1;
                Unity_Absolute_half(_Multiply_483E3720_Out_2, _Absolute_6685A82A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_356E067F_Out_3;
                Unity_Lerp_half3(_NormalStrength_528ACD86_Out_2, _NormalStrength_3BD81F5D_Out_2, (_Absolute_6685A82A_Out_1.xxx), _Lerp_356E067F_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_F5E0A69B_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_2DC0B257_Out_0 = _Detail1MainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_6E5EFE29_Out_0 = _Detail1Tiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_7748686D_Out_2;
                Unity_Multiply_half(_Property_2DC0B257_Out_0, _Property_6E5EFE29_Out_0, _Multiply_7748686D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_3FC112BC_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_AF306880_Out_2;
                Unity_Multiply_half(_Multiply_7748686D_Out_2, (_UV_3FC112BC_Out_0.xy), _Multiply_AF306880_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_B1FC6FBE_R_1 = _Multiply_AF306880_Out_2[0];
                half _Split_B1FC6FBE_G_2 = _Multiply_AF306880_Out_2[1];
                half _Split_B1FC6FBE_B_3 = 0;
                half _Split_B1FC6FBE_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_AD94E758_Out_0 = half2(_Split_B1FC6FBE_G_2, _Split_B1FC6FBE_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_65700BCC_Out_3;
                Unity_Branch_half2(_Property_F5E0A69B_Out_0, _Multiply_AF306880_Out_2, _Vector2_AD94E758_Out_0, _Branch_65700BCC_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_F1F3D035_Out_0 = _Detail1FlowUVRefreshSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A19D7537_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_F1F3D035_Out_0, _Multiply_A19D7537_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_28E3F138_Out_2;
                Unity_Add_half(_Multiply_A19D7537_Out_2, 1, _Add_28E3F138_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_D2DC6DD9_Out_1;
                Unity_Fraction_half(_Add_28E3F138_Out_2, _Fraction_D2DC6DD9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_5F61A5DA_Out_2;
                Unity_Multiply_half(_Branch_65700BCC_Out_3, (_Fraction_D2DC6DD9_Out_1.xx), _Multiply_5F61A5DA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_5D47C22C_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_4C511BD_Out_2;
                Unity_Divide_half(1, _Property_5D47C22C_Out_0, _Divide_4C511BD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_4B625890_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_A6640011_Out_2;
                Unity_Multiply_half(_Property_6E5EFE29_Out_0, (_UV_4B625890_Out_0.xy), _Multiply_A6640011_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_9324F9E4_Out_2;
                Unity_Multiply_half((_Divide_4C511BD_Out_2.xx), _Multiply_A6640011_Out_2, _Multiply_9324F9E4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_8A8E7455_Out_2;
                Unity_Add_half2(_Multiply_5F61A5DA_Out_2, _Multiply_9324F9E4_Out_2, _Add_8A8E7455_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_31496932_RGBA_0 = SAMPLE_TEXTURE2D(_DetailNormal, sampler_DetailNormal, _Add_8A8E7455_Out_2);
                _SampleTexture2D_31496932_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_31496932_RGBA_0);
                half _SampleTexture2D_31496932_R_4 = _SampleTexture2D_31496932_RGBA_0.r;
                half _SampleTexture2D_31496932_G_5 = _SampleTexture2D_31496932_RGBA_0.g;
                half _SampleTexture2D_31496932_B_6 = _SampleTexture2D_31496932_RGBA_0.b;
                half _SampleTexture2D_31496932_A_7 = _SampleTexture2D_31496932_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_5566E68B_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _NormalStrength_49B5F443_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_31496932_RGBA_0.xyz), _Property_5566E68B_Out_0, _NormalStrength_49B5F443_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_CBBBA061_Out_2;
                Unity_Add_half(_Multiply_A19D7537_Out_2, 0.5, _Add_CBBBA061_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_37B97A80_Out_1;
                Unity_Fraction_half(_Add_CBBBA061_Out_2, _Fraction_37B97A80_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_D8C05DAF_Out_2;
                Unity_Multiply_half(_Branch_65700BCC_Out_3, (_Fraction_37B97A80_Out_1.xx), _Multiply_D8C05DAF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_F35A6507_Out_2;
                Unity_Add_half2(_Multiply_9324F9E4_Out_2, _Multiply_D8C05DAF_Out_2, _Add_F35A6507_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_BEDCCB97_RGBA_0 = SAMPLE_TEXTURE2D(_DetailNormal, sampler_DetailNormal, _Add_F35A6507_Out_2);
                _SampleTexture2D_BEDCCB97_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_BEDCCB97_RGBA_0);
                half _SampleTexture2D_BEDCCB97_R_4 = _SampleTexture2D_BEDCCB97_RGBA_0.r;
                half _SampleTexture2D_BEDCCB97_G_5 = _SampleTexture2D_BEDCCB97_RGBA_0.g;
                half _SampleTexture2D_BEDCCB97_B_6 = _SampleTexture2D_BEDCCB97_RGBA_0.b;
                half _SampleTexture2D_BEDCCB97_A_7 = _SampleTexture2D_BEDCCB97_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _NormalStrength_C4CCB54D_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_BEDCCB97_RGBA_0.xyz), _Property_5566E68B_Out_0, _NormalStrength_C4CCB54D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_BC933749_Out_2;
                Unity_Add_half(_Fraction_D2DC6DD9_Out_1, -0.5, _Add_BC933749_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_DF41C813_Out_2;
                Unity_Multiply_half(_Add_BC933749_Out_2, 2, _Multiply_DF41C813_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_476B42D9_Out_1;
                Unity_Absolute_half(_Multiply_DF41C813_Out_2, _Absolute_476B42D9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_14477A5_Out_3;
                Unity_Lerp_half3(_NormalStrength_49B5F443_Out_2, _NormalStrength_C4CCB54D_Out_2, (_Absolute_476B42D9_Out_1.xxx), _Lerp_14477A5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_B8ACE3F1_RGBA_0 = SAMPLE_TEXTURE2D(_DetailAlbedo, sampler_DetailAlbedo, _Add_8A8E7455_Out_2);
                half _SampleTexture2D_B8ACE3F1_R_4 = _SampleTexture2D_B8ACE3F1_RGBA_0.r;
                half _SampleTexture2D_B8ACE3F1_G_5 = _SampleTexture2D_B8ACE3F1_RGBA_0.g;
                half _SampleTexture2D_B8ACE3F1_B_6 = _SampleTexture2D_B8ACE3F1_RGBA_0.b;
                half _SampleTexture2D_B8ACE3F1_A_7 = _SampleTexture2D_B8ACE3F1_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_A1621BBD_RGBA_0 = SAMPLE_TEXTURE2D(_DetailAlbedo, sampler_DetailAlbedo, _Add_F35A6507_Out_2);
                half _SampleTexture2D_A1621BBD_R_4 = _SampleTexture2D_A1621BBD_RGBA_0.r;
                half _SampleTexture2D_A1621BBD_G_5 = _SampleTexture2D_A1621BBD_RGBA_0.g;
                half _SampleTexture2D_A1621BBD_B_6 = _SampleTexture2D_A1621BBD_RGBA_0.b;
                half _SampleTexture2D_A1621BBD_A_7 = _SampleTexture2D_A1621BBD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Lerp_11CAC5B2_Out_3;
                Unity_Lerp_half4(_SampleTexture2D_B8ACE3F1_RGBA_0, _SampleTexture2D_A1621BBD_RGBA_0, (_Absolute_476B42D9_Out_1.xxxx), _Lerp_11CAC5B2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_2099A5DB_R_1 = _Lerp_11CAC5B2_Out_3[0];
                half _Split_2099A5DB_G_2 = _Lerp_11CAC5B2_Out_3[1];
                half _Split_2099A5DB_B_3 = _Lerp_11CAC5B2_Out_3[2];
                half _Split_2099A5DB_A_4 = _Lerp_11CAC5B2_Out_3[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_D4F6F844_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_A4A55C8D_Out_0 = _NoiseTiling1;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_6D76AFA6_Out_2;
                Unity_Multiply_half(_Property_2DC0B257_Out_0, _Property_A4A55C8D_Out_0, _Multiply_6D76AFA6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_F6117BE8_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_8B060916_Out_2;
                Unity_Multiply_half(_Multiply_6D76AFA6_Out_2, (_UV_F6117BE8_Out_0.xy), _Multiply_8B060916_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_A4B34BC7_R_1 = _Multiply_8B060916_Out_2[0];
                half _Split_A4B34BC7_G_2 = _Multiply_8B060916_Out_2[1];
                half _Split_A4B34BC7_B_3 = 0;
                half _Split_A4B34BC7_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_680633BC_Out_0 = half2(_Split_A4B34BC7_G_2, _Split_A4B34BC7_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_35279751_Out_3;
                Unity_Branch_half2(_Property_D4F6F844_Out_0, _Multiply_8B060916_Out_2, _Vector2_680633BC_Out_0, _Branch_35279751_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_DE608340_Out_2;
                Unity_Multiply_half(_Branch_35279751_Out_3, (_Fraction_D2DC6DD9_Out_1.xx), _Multiply_DE608340_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_56E8C0F2_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_8E603DE9_Out_2;
                Unity_Divide_half(1, _Property_56E8C0F2_Out_0, _Divide_8E603DE9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_D4E93B1E_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_42C43DD7_Out_2;
                Unity_Multiply_half(_Property_A4A55C8D_Out_0, (_UV_D4E93B1E_Out_0.xy), _Multiply_42C43DD7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_AE0BBFAF_Out_2;
                Unity_Multiply_half((_Divide_8E603DE9_Out_2.xx), _Multiply_42C43DD7_Out_2, _Multiply_AE0BBFAF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_56C76C69_Out_2;
                Unity_Add_half2(_Multiply_DE608340_Out_2, _Multiply_AE0BBFAF_Out_2, _Add_56C76C69_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_E54CB7DD_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_56C76C69_Out_2);
                half _SampleTexture2D_E54CB7DD_R_4 = _SampleTexture2D_E54CB7DD_RGBA_0.r;
                half _SampleTexture2D_E54CB7DD_G_5 = _SampleTexture2D_E54CB7DD_RGBA_0.g;
                half _SampleTexture2D_E54CB7DD_B_6 = _SampleTexture2D_E54CB7DD_RGBA_0.b;
                half _SampleTexture2D_E54CB7DD_A_7 = _SampleTexture2D_E54CB7DD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_A4082A4_Out_2;
                Unity_Multiply_half(_Branch_35279751_Out_3, (_Fraction_37B97A80_Out_1.xx), _Multiply_A4082A4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_F8B5ACD3_Out_2;
                Unity_Add_half2(_Multiply_A4082A4_Out_2, _Multiply_AE0BBFAF_Out_2, _Add_F8B5ACD3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_35B340E9_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_F8B5ACD3_Out_2);
                half _SampleTexture2D_35B340E9_R_4 = _SampleTexture2D_35B340E9_RGBA_0.r;
                half _SampleTexture2D_35B340E9_G_5 = _SampleTexture2D_35B340E9_RGBA_0.g;
                half _SampleTexture2D_35B340E9_B_6 = _SampleTexture2D_35B340E9_RGBA_0.b;
                half _SampleTexture2D_35B340E9_A_7 = _SampleTexture2D_35B340E9_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_6FEEAEA0_Out_3;
                Unity_Lerp_half(_SampleTexture2D_E54CB7DD_G_5, _SampleTexture2D_35B340E9_G_5, _Absolute_476B42D9_Out_1, _Lerp_6FEEAEA0_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_50C70389_Out_1;
                Unity_Absolute_half(_Lerp_6FEEAEA0_Out_3, _Absolute_50C70389_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C1134212_Out_0 = _Detail1NoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_483D9151_Out_2;
                Unity_Power_half(_Absolute_50C70389_Out_1, _Property_C1134212_Out_0, _Power_483D9151_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_8B0E8794_Out_0 = _Detail1NoiseMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_E26A26BB_Out_2;
                Unity_Multiply_half(_Power_483D9151_Out_2, _Property_8B0E8794_Out_0, _Multiply_E26A26BB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_805729EB_Out_3;
                Unity_Clamp_half(_Multiply_E26A26BB_Out_2, 0, 1, _Clamp_805729EB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_12157CAE_Out_2;
                Unity_Multiply_half(_Split_2099A5DB_A_4, _Clamp_805729EB_Out_3, _Multiply_12157CAE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_39572874_Out_3;
                Unity_Lerp_half(0, _Split_2099A5DB_A_4, _Multiply_12157CAE_Out_2, _Lerp_39572874_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_A40F2519_Out_3;
                Unity_Lerp_half3(_Lerp_356E067F_Out_3, _Lerp_14477A5_Out_3, (_Lerp_39572874_Out_3.xxx), _Lerp_A40F2519_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_FDE310C2_Out_0 = _CascadeMainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_87340130_Out_0 = _CascadeTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_half(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_106B410B_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_A639E196_Out_2;
                Unity_Multiply_half(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                half _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                half _Split_D288CE58_B_3 = 0;
                half _Split_D288CE58_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_76C74260_Out_0 = half2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_half2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_375B806D_Out_0 = _CascadeFlowUVRefreshSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_7EF542FE_Out_2;
                Unity_Add_half(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_5582502D_Out_1;
                Unity_Fraction_half(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_half(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_506342C2_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_E07C316A_Out_2;
                Unity_Divide_half(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_BEAE142D_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_half(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_half((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_188C8FD3_Out_2;
                Unity_Add_half2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_188C8FD3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_AEBC8292_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_188C8FD3_Out_2);
                _SampleTexture2D_AEBC8292_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AEBC8292_RGBA_0);
                half _SampleTexture2D_AEBC8292_R_4 = _SampleTexture2D_AEBC8292_RGBA_0.r;
                half _SampleTexture2D_AEBC8292_G_5 = _SampleTexture2D_AEBC8292_RGBA_0.g;
                half _SampleTexture2D_AEBC8292_B_6 = _SampleTexture2D_AEBC8292_RGBA_0.b;
                half _SampleTexture2D_AEBC8292_A_7 = _SampleTexture2D_AEBC8292_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_8A81F679_Out_0 = _CascadeNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _NormalStrength_94FC33DB_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_AEBC8292_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_94FC33DB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_42A4AEEC_Out_2;
                Unity_Add_half(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_3662A9DE_Out_1;
                Unity_Fraction_half(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_283B3646_Out_2;
                Unity_Multiply_half(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_3E5AC13E_Out_2;
                Unity_Add_half2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_3E5AC13E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_9126225F_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_3E5AC13E_Out_2);
                _SampleTexture2D_9126225F_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9126225F_RGBA_0);
                half _SampleTexture2D_9126225F_R_4 = _SampleTexture2D_9126225F_RGBA_0.r;
                half _SampleTexture2D_9126225F_G_5 = _SampleTexture2D_9126225F_RGBA_0.g;
                half _SampleTexture2D_9126225F_B_6 = _SampleTexture2D_9126225F_RGBA_0.b;
                half _SampleTexture2D_9126225F_A_7 = _SampleTexture2D_9126225F_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _NormalStrength_337B983B_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_9126225F_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_337B983B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_1044203D_Out_2;
                Unity_Add_half(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_half(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_D56AD49D_Out_1;
                Unity_Absolute_half(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_5B898C96_Out_3;
                Unity_Lerp_half3(_NormalStrength_94FC33DB_Out_2, _NormalStrength_337B983B_Out_2, (_Absolute_D56AD49D_Out_1.xxx), _Lerp_5B898C96_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                half _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                half _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                half _Split_C4B2F888_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_F22E389A_Out_1;
                Unity_Absolute_half(_Split_C4B2F888_G_2, _Absolute_F22E389A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7DFFA574_Out_3;
                Unity_Clamp_half(_Absolute_F22E389A_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C24EE4D_Out_0 = _CascadeAngle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_3235AB33_Out_2;
                Unity_Divide_half(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_57DB513_Out_1;
                Unity_OneMinus_half(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_B782DE16_Out_2;
                Unity_Subtract_half(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_half(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_BD74F0DD_Out_2;
                Unity_Divide_half(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A56B78D9_Out_2;
                Unity_Multiply_half(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_368478F5_Out_3;
                Unity_Clamp_half(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_half(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_438A66D_Out_1;
                Unity_Absolute_half(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_1F70A06C_Out_0 = _CascadeAngleFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_A86AE25B_Out_2;
                Unity_Power_half(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C9BB189_Out_3;
                Unity_Clamp_half(_Power_A86AE25B_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_BA2C71FD_Out_3;
                Unity_Lerp_half3(_Lerp_A40F2519_Out_3, _Lerp_5B898C96_Out_3, (_Clamp_C9BB189_Out_3.xxx), _Lerp_BA2C71FD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Normalize_C75C1ECE_Out_1;
                Unity_Normalize_half3(_Lerp_BA2C71FD_Out_3, _Normalize_C75C1ECE_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Split_6A7D546B_R_1 = _Normalize_C75C1ECE_Out_1[0];
                half _Split_6A7D546B_G_2 = _Normalize_C75C1ECE_Out_1[1];
                half _Split_6A7D546B_B_3 = _Normalize_C75C1ECE_Out_1[2];
                half _Split_6A7D546B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _Combine_E07639F2_RGBA_4;
                half3 _Combine_E07639F2_RGB_5;
                half2 _Combine_E07639F2_RG_6;
                Unity_Combine_half(_Split_6A7D546B_R_1, _Split_6A7D546B_G_2, 0, 0, _Combine_E07639F2_RGBA_4, _Combine_E07639F2_RGB_5, _Combine_E07639F2_RG_6);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_2F7622D8_Out_2;
                Unity_Multiply_half((_Property_FC343CDD_Out_0.xx), _Combine_E07639F2_RG_6, _Multiply_2F7622D8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_771FE10A_Out_2;
                Unity_Multiply_half((_ScreenPosition_590B4FA3_Out_0.xy), _Multiply_2F7622D8_Out_2, _Multiply_771FE10A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_996FBC6B_Out_2;
                Unity_Add_half2((_ScreenPosition_590B4FA3_Out_0.xy), _Multiply_771FE10A_Out_2, _Add_996FBC6B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _SceneColor_9C32DAB4_Out_1;
                Unity_SceneColor_half((half4(_Add_996FBC6B_Out_2, 0.0, 1.0)), _SceneColor_9C32DAB4_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_C4180B07_Out_0 = _DeepColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_B354F529_Out_0 = _ShalowColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _ScreenPosition_E4782AF8_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _SceneDepth_33F13F54_Out_1;
                Unity_SceneDepth_Linear01_half(_ScreenPosition_E4782AF8_Out_0, _SceneDepth_33F13F54_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_39A1673A_Out_2;
                Unity_Multiply_half(_SceneDepth_33F13F54_Out_1, _ProjectionParams.z, _Multiply_39A1673A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _ScreenPosition_35A77C4_Out_0 = IN.ScreenPosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_D36BBBDE_R_1 = _ScreenPosition_35A77C4_Out_0[0];
                half _Split_D36BBBDE_G_2 = _ScreenPosition_35A77C4_Out_0[1];
                half _Split_D36BBBDE_B_3 = _ScreenPosition_35A77C4_Out_0[2];
                half _Split_D36BBBDE_A_4 = _ScreenPosition_35A77C4_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_331D19CE_Out_2;
                Unity_Subtract_half(_Multiply_39A1673A_Out_2, _Split_D36BBBDE_A_4, _Subtract_331D19CE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_46A80510_Out_0 = _ShalowFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_55CDC796_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_46A80510_Out_0, _Multiply_55CDC796_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_DA749514_Out_1;
                Unity_Absolute_half(_Multiply_55CDC796_Out_2, _Absolute_DA749514_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_4D681D1C_Out_0 = _ShalowFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_F7AB70ED_Out_2;
                Unity_Multiply_half(_Property_4D681D1C_Out_0, -1, _Multiply_F7AB70ED_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_3270BF29_Out_2;
                Unity_Power_half(_Absolute_DA749514_Out_1, _Multiply_F7AB70ED_Out_2, _Power_3270BF29_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_BB1D3A49_Out_0 = _CascadeTransparency;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_6F5E4CCF_Out_2;
                Unity_Multiply_half(_Property_BB1D3A49_Out_0, _Clamp_C9BB189_Out_3, _Multiply_6F5E4CCF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_FE3B891E_Out_3;
                Unity_Lerp_half(_Power_3270BF29_Out_2, 100, _Multiply_6F5E4CCF_Out_2, _Lerp_FE3B891E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Saturate_47EA3698_Out_1;
                Unity_Saturate_half(_Lerp_FE3B891E_Out_3, _Saturate_47EA3698_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_FA371D5_Out_3;
                Unity_Clamp_half(_Saturate_47EA3698_Out_1, 0, 1, _Clamp_FA371D5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Lerp_E98C0337_Out_3;
                Unity_Lerp_half4(_Property_C4180B07_Out_0, _Property_B354F529_Out_0, (_Clamp_FA371D5_Out_3.xxxx), _Lerp_E98C0337_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Multiply_689418CF_Out_2;
                Unity_Multiply_half((_Lerp_E98C0337_Out_3.xyz), _SceneColor_9C32DAB4_Out_1, _Multiply_689418CF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_8B8E643D_Out_0 = _WaterAlphaMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_BF88B5F8_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_8B8E643D_Out_0, _Multiply_BF88B5F8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_53D1B29C_Out_3;
                Unity_Clamp_half(_Multiply_BF88B5F8_Out_2, 0, 1, _Clamp_53D1B29C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_EC47432B_Out_0 = _WaterAlphaPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Power_83812DD0_Out_2;
                Unity_Power_half(_Clamp_53D1B29C_Out_3, _Property_EC47432B_Out_0, _Power_83812DD0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_A62DB403_Out_3;
                Unity_Clamp_half(_Power_83812DD0_Out_2, 0, 1, _Clamp_A62DB403_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_BDDADE6B_Out_3;
                Unity_Lerp_half3(_Multiply_689418CF_Out_2, (_Lerp_E98C0337_Out_3.xyz), (_Clamp_A62DB403_Out_3.xxx), _Lerp_BDDADE6B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_312FB549_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_43A46A4A_Out_3;
                Unity_Clamp_half(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Absolute_97151155_Out_1;
                Unity_Absolute_half(_Clamp_43A46A4A_Out_3, _Absolute_97151155_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_D7C9F55F_Out_0 = _CleanFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Power_AD928E85_Out_2;
                Unity_Power_half(_Absolute_97151155_Out_1, _Property_D7C9F55F_Out_0, _Power_AD928E85_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_9B4149BD_Out_3;
                Unity_Clamp_half(_Power_AD928E85_Out_2, 0, 1, _Clamp_9B4149BD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_3B329D09_Out_3;
                Unity_Lerp_half3(_SceneColor_9C32DAB4_Out_1, _Lerp_BDDADE6B_Out_3, (_Clamp_9B4149BD_Out_3.xxx), _Lerp_3B329D09_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_DISTORTION_ON)
                half3 _UseDistortion_F844CC61_Out_0 = _Lerp_3B329D09_Out_3;
                #else
                half3 _UseDistortion_F844CC61_Out_0 = (_Lerp_E98C0337_Out_3.xyz);
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_F19A2B5F_Out_0 = _DetailAlbedoColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_E85EE897_Out_2;
                Unity_Multiply_half(_Lerp_11CAC5B2_Out_3, _Property_F19A2B5F_Out_0, _Multiply_E85EE897_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_F64B17F5_Out_3;
                Unity_Lerp_half3(_UseDistortion_F844CC61_Out_0, (_Multiply_E85EE897_Out_2.xyz), (_Lerp_39572874_Out_3.xxx), _Lerp_F64B17F5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_4F98523C_Out_3;
                Unity_Lerp_half3(_Lerp_F64B17F5_Out_3, _UseDistortion_F844CC61_Out_0, (_Clamp_C9BB189_Out_3.xxx), _Lerp_4F98523C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_1B6F286A_Out_0 = _WaterSpecularFar;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_383A5003_Out_0 = _WaterSpecularClose;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_94D1307E_Out_1;
                Unity_Absolute_half(_Clamp_FA371D5_Out_3, _Absolute_94D1307E_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_748ADF97_Out_0 = _WaterSpecularThreshold;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_D9A7E43F_Out_2;
                Unity_Power_half(_Absolute_94D1307E_Out_1, _Property_748ADF97_Out_0, _Power_D9A7E43F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_BFB13A67_Out_3;
                Unity_Lerp_half(_Property_1B6F286A_Out_0, _Property_383A5003_Out_0, _Power_D9A7E43F_Out_2, _Lerp_BFB13A67_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_FA7CE499_Out_0 = _Detail1Specular;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_9421F305_Out_2;
                Unity_Multiply_half(_Multiply_E85EE897_Out_2, (_Property_FA7CE499_Out_0.xxxx), _Multiply_9421F305_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_3529CBB1_RGBA_0 = SAMPLE_TEXTURE2D(_Detail1GSmDetail2ASm, sampler_Detail1GSmDetail2ASm, _Add_8A8E7455_Out_2);
                half _SampleTexture2D_3529CBB1_R_4 = _SampleTexture2D_3529CBB1_RGBA_0.r;
                half _SampleTexture2D_3529CBB1_G_5 = _SampleTexture2D_3529CBB1_RGBA_0.g;
                half _SampleTexture2D_3529CBB1_B_6 = _SampleTexture2D_3529CBB1_RGBA_0.b;
                half _SampleTexture2D_3529CBB1_A_7 = _SampleTexture2D_3529CBB1_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_463471CC_RGBA_0 = SAMPLE_TEXTURE2D(_Detail1GSmDetail2ASm, sampler_Detail1GSmDetail2ASm, _Add_F35A6507_Out_2);
                half _SampleTexture2D_463471CC_R_4 = _SampleTexture2D_463471CC_RGBA_0.r;
                half _SampleTexture2D_463471CC_G_5 = _SampleTexture2D_463471CC_RGBA_0.g;
                half _SampleTexture2D_463471CC_B_6 = _SampleTexture2D_463471CC_RGBA_0.b;
                half _SampleTexture2D_463471CC_A_7 = _SampleTexture2D_463471CC_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_CC6CFFCA_Out_3;
                Unity_Lerp_half(_SampleTexture2D_3529CBB1_G_5, _SampleTexture2D_463471CC_G_5, _Absolute_476B42D9_Out_1, _Lerp_CC6CFFCA_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_CA998263_Out_2;
                Unity_Multiply_half(_Multiply_9421F305_Out_2, (_Lerp_CC6CFFCA_Out_3.xxxx), _Multiply_CA998263_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Lerp_C8383D23_Out_3;
                Unity_Lerp_half4((_Lerp_BFB13A67_Out_3.xxxx), _Multiply_CA998263_Out_2, (_Lerp_39572874_Out_3.xxxx), _Lerp_C8383D23_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Lerp_4C220BDB_Out_3;
                Unity_Lerp_half4(_Lerp_C8383D23_Out_3, (_Lerp_BFB13A67_Out_3.xxxx), (_Clamp_C9BB189_Out_3.xxxx), _Lerp_4C220BDB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_EE79CD0D_Out_0 = _WaterSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_A47FA74D_Out_0 = _DetailSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_540C028C_Out_2;
                Unity_Multiply_half(_Property_A47FA74D_Out_0, _Lerp_CC6CFFCA_Out_3, _Multiply_540C028C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_A0E087E1_Out_3;
                Unity_Lerp_half(_Property_EE79CD0D_Out_0, _Multiply_540C028C_Out_2, _Lerp_39572874_Out_3, _Lerp_A0E087E1_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_5DE08151_Out_3;
                Unity_Lerp_half(_Lerp_A0E087E1_Out_3, _Property_EE79CD0D_Out_0, _Clamp_C9BB189_Out_3, _Lerp_5DE08151_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_A1F4E266_Out_0 = _AOPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_3C674080_Out_0 = _DetailAOPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_437BC2E_Out_3;
                Unity_Lerp_half(_Property_A1F4E266_Out_0, _Property_3C674080_Out_0, _Lerp_39572874_Out_3, _Lerp_437BC2E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_49BAFA18_Out_3;
                Unity_Lerp_half(_Lerp_437BC2E_Out_3, _Property_A1F4E266_Out_0, _Clamp_C9BB189_Out_3, _Lerp_49BAFA18_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_52B645B4_Out_0 = _EdgeFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_C4830DE7_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_52B645B4_Out_0, _Multiply_C4830DE7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_48A3004E_Out_3;
                Unity_Clamp_half(_Multiply_C4830DE7_Out_2, 0, 1, _Clamp_48A3004E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_D3964C1C_Out_1;
                Unity_Absolute_half(_Clamp_48A3004E_Out_3, _Absolute_D3964C1C_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_69C29CD0_Out_0 = _EdgeFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_B73FC60F_Out_2;
                Unity_Power_half(_Absolute_D3964C1C_Out_1, _Property_69C29CD0_Out_0, _Power_B73FC60F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_2EDE896F_Out_3;
                Unity_Clamp_half(_Power_B73FC60F_Out_2, 0, 1, _Clamp_2EDE896F_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_42E433A0_R_1 = IN.VertexColor[0];
                half _Split_42E433A0_G_2 = IN.VertexColor[1];
                half _Split_42E433A0_B_3 = IN.VertexColor[2];
                half _Split_42E433A0_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_73E319C1_Out_2;
                Unity_Multiply_half(_Clamp_2EDE896F_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_6C82272C_Out_0 = _BackfaceAlpha;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_EE3AF77D_Out_2;
                Unity_Multiply_half(_Property_6C82272C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Branch_6D78BA69_Out_3;
                Unity_Branch_half(_IsFrontFace_29CBC83C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2, _Branch_6D78BA69_Out_3);
                #endif
                surface.Albedo = _Lerp_4F98523C_Out_3;
                surface.Normal = _Lerp_BA2C71FD_Out_3;
                surface.Emission = IsGammaSpace() ? half3(0, 0, 0) : SRGBToLinear(half3(0, 0, 0));
                surface.Specular = (_Lerp_4C220BDB_Out_3.xyz);
                surface.Smoothness = _Lerp_5DE08151_Out_3;
                surface.Occlusion = _Lerp_49BAFA18_Out_3;
                surface.Alpha = _Branch_6D78BA69_Out_3;
                surface.AlphaClipThreshold = 0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionOS : POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalOS : NORMAL;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentOS : TANGENT;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0 : TEXCOORD0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv1 : TEXCOORD1;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv3 : TEXCOORD3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color : COLOR;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 positionCS : SV_POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 viewDirectionWS;
                #endif
                #if defined(LIGHTMAP_ON)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float2 lightmapUV;
                #endif
                #endif
                #if !defined(LIGHTMAP_ON)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 sh;
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 fogFactorAndVertexLight;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 shadowCoord;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #endif
            };
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                #if defined(LIGHTMAP_ON)
                #endif
                #if !defined(LIGHTMAP_ON)
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float3 interp00 : TEXCOORD0;
                float3 interp01 : TEXCOORD1;
                float4 interp02 : TEXCOORD2;
                float4 interp03 : TEXCOORD3;
                float4 interp04 : TEXCOORD4;
                float4 interp05 : TEXCOORD5;
                float3 interp06 : TEXCOORD6;
                float2 interp07 : TEXCOORD7;
                float3 interp08 : TEXCOORD8;
                float4 interp09 : TEXCOORD9;
                float4 interp10 : TEXCOORD10;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.tangentWS;
                output.interp03.xyzw = input.texCoord0;
                output.interp04.xyzw = input.texCoord3;
                output.interp05.xyzw = input.color;
                output.interp06.xyz = input.viewDirectionWS;
                #if defined(LIGHTMAP_ON)
                output.interp07.xy = input.lightmapUV;
                #endif
                #if !defined(LIGHTMAP_ON)
                output.interp08.xyz = input.sh;
                #endif
                output.interp09.xyzw = input.fogFactorAndVertexLight;
                output.interp10.xyzw = input.shadowCoord;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output = (Varyings)0;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.tangentWS = input.interp02.xyzw;
                output.texCoord0 = input.interp03.xyzw;
                output.texCoord3 = input.interp04.xyzw;
                output.color = input.interp05.xyzw;
                output.viewDirectionWS = input.interp06.xyz;
                #if defined(LIGHTMAP_ON)
                output.lightmapUV = input.interp07.xy;
                #endif
                #if !defined(LIGHTMAP_ON)
                output.sh = input.interp08.xyz;
                #endif
                output.fogFactorAndVertexLight = input.interp09.xyzw;
                output.shadowCoord = input.interp10.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            #endif
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 unnormalizedNormalWS = input.normalWS;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
            #endif
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
            #endif
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpacePosition =          input.positionWS;
            #endif
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv0 =                         input.texCoord0;
            #endif
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv3 =                         input.texCoord3;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.VertexColor =                 input.color;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            #endif
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
        
            ENDHLSL
        }
        
        Pass
        {
            Name "ShadowCaster"
            Tags 
            { 
                "LightMode" = "ShadowCaster"
            }
           
            // Render State
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>
            
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _DISTORTION_ON
            
            #if defined(_DISTORTION_ON)
                #define KEYWORD_PERMUTATION_0
            #else
                #define KEYWORD_PERMUTATION_1
            #endif
            
            
            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif
        
        
        
            #define _NORMAL_DROPOFF_TS 1
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS 
        #endif
        
        
        
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif
        
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_CULLFACE
        #endif
        
            #define SHADERPASS_SHADOWCASTER
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define REQUIRE_DEPTH_TEXTURE
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            half _GlobalTiling;
            half _UVVDirection1UDirection0;
            half2 _SlowWaterSpeed;
            half2 _CascadeMainSpeed;
            half2 _Detail1MainSpeed;
            half _EdgeFalloffMultiply;
            half _EdgeFalloffPower;
            half _CleanFalloffMultiply;
            half _CleanFalloffPower;
            half4 _ShalowColor;
            half _ShalowFalloffMultiply;
            half _ShalowFalloffPower;
            half4 _DeepColor;
            half _WaterAlphaMultiply;
            half _WaterAlphaPower;
            half _WaterSmoothness;
            half _WaterSpecularClose;
            half _WaterSpecularFar;
            half _WaterSpecularThreshold;
            half _Distortion;
            half _BackfaceAlpha;
            half2 _SlowWaterTiling;
            half _SlowNormalScale;
            half _CascadeAngle;
            half _CascadeAngleFalloff;
            half2 _CascadeTiling;
            half _CascadeNormalScale;
            half _CascadeTransparency;
            half2 _Detail1Tiling;
            half4 _DetailAlbedoColor;
            half _DetailNormalScale;
            half _DetailSmoothness;
            half _Detail1Specular;
            half2 _NoiseTiling1;
            half _Detail1NoisePower;
            half _Detail1NoiseMultiply;
            half _WaterFlowUVRefresSpeed;
            half _CascadeFlowUVRefreshSpeed;
            half _Detail1FlowUVRefreshSpeed;
            half _AOPower;
            half _DetailAOPower;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); half4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_Detail1GSmDetail2ASm); SAMPLER(sampler_Detail1GSmDetail2ASm); half4 _Detail1GSmDetail2ASm_TexelSize;
            TEXTURE2D(_DetailAlbedo); SAMPLER(sampler_DetailAlbedo); half4 _DetailAlbedo_TexelSize;
            TEXTURE2D(_DetailNormal); SAMPLER(sampler_DetailNormal); half4 _DetailNormal_TexelSize;
            TEXTURE2D(_Noise); SAMPLER(sampler_Noise); half4 _Noise_TexelSize;
        
            // Graph Functions
            
            void Unity_SceneDepth_Linear01_half(half4 UV, out half Out)
            {
                Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
            
            void Unity_Multiply_half(half A, half B, out half Out)
            {
                Out = A * B;
            }
            
            void Unity_Subtract_half(half A, half B, out half Out)
            {
                Out = A - B;
            }
            
            void Unity_Clamp_half(half In, half Min, half Max, out half Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Absolute_half(half In, out half Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_half(half A, half B, out half Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Branch_half(half Predicate, half True, half False, out half Out)
            {
                Out = lerp(False, True, Predicate);
            }
        
            // Graph Vertex
            // GraphVertex: <None>
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpacePosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 ScreenPosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 VertexColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float FaceSign;
                #endif
            };
            
            struct SurfaceDescription
            {
                half Alpha;
                half AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _ScreenPosition_E4782AF8_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _SceneDepth_33F13F54_Out_1;
                Unity_SceneDepth_Linear01_half(_ScreenPosition_E4782AF8_Out_0, _SceneDepth_33F13F54_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_39A1673A_Out_2;
                Unity_Multiply_half(_SceneDepth_33F13F54_Out_1, _ProjectionParams.z, _Multiply_39A1673A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _ScreenPosition_35A77C4_Out_0 = IN.ScreenPosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_D36BBBDE_R_1 = _ScreenPosition_35A77C4_Out_0[0];
                half _Split_D36BBBDE_G_2 = _ScreenPosition_35A77C4_Out_0[1];
                half _Split_D36BBBDE_B_3 = _ScreenPosition_35A77C4_Out_0[2];
                half _Split_D36BBBDE_A_4 = _ScreenPosition_35A77C4_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_331D19CE_Out_2;
                Unity_Subtract_half(_Multiply_39A1673A_Out_2, _Split_D36BBBDE_A_4, _Subtract_331D19CE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_52B645B4_Out_0 = _EdgeFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_C4830DE7_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_52B645B4_Out_0, _Multiply_C4830DE7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_48A3004E_Out_3;
                Unity_Clamp_half(_Multiply_C4830DE7_Out_2, 0, 1, _Clamp_48A3004E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_D3964C1C_Out_1;
                Unity_Absolute_half(_Clamp_48A3004E_Out_3, _Absolute_D3964C1C_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_69C29CD0_Out_0 = _EdgeFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_B73FC60F_Out_2;
                Unity_Power_half(_Absolute_D3964C1C_Out_1, _Property_69C29CD0_Out_0, _Power_B73FC60F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_2EDE896F_Out_3;
                Unity_Clamp_half(_Power_B73FC60F_Out_2, 0, 1, _Clamp_2EDE896F_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_42E433A0_R_1 = IN.VertexColor[0];
                half _Split_42E433A0_G_2 = IN.VertexColor[1];
                half _Split_42E433A0_B_3 = IN.VertexColor[2];
                half _Split_42E433A0_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_73E319C1_Out_2;
                Unity_Multiply_half(_Clamp_2EDE896F_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_6C82272C_Out_0 = _BackfaceAlpha;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_EE3AF77D_Out_2;
                Unity_Multiply_half(_Property_6C82272C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Branch_6D78BA69_Out_3;
                Unity_Branch_half(_IsFrontFace_29CBC83C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2, _Branch_6D78BA69_Out_3);
                #endif
                surface.Alpha = _Branch_6D78BA69_Out_3;
                surface.AlphaClipThreshold = 0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionOS : POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalOS : NORMAL;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentOS : TANGENT;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color : COLOR;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 positionCS : SV_POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #endif
            };
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float3 interp00 : TEXCOORD0;
                float4 interp01 : TEXCOORD1;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyzw = input.color;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output = (Varyings)0;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.color = input.interp01.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            #endif
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpacePosition =          input.positionWS;
            #endif
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            #endif
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.VertexColor =                 input.color;
            #endif
            
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
            ENDHLSL
        }
        
        Pass
        {
            Name "DepthOnly"
            Tags 
            { 
                "LightMode" = "DepthOnly"
            }
           
            // Render State
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            ZTest LEqual
            ZWrite On
            ColorMask 0
            
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _DISTORTION_ON
            
            #if defined(_DISTORTION_ON)
                #define KEYWORD_PERMUTATION_0
            #else
                #define KEYWORD_PERMUTATION_1
            #endif
            
            
            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif
        
        
        
            #define _NORMAL_DROPOFF_TS 1
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS 
        #endif
        
        
        
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif
        
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_CULLFACE
        #endif
        
            #define SHADERPASS_DEPTHONLY
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define REQUIRE_DEPTH_TEXTURE
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            half _GlobalTiling;
            half _UVVDirection1UDirection0;
            half2 _SlowWaterSpeed;
            half2 _CascadeMainSpeed;
            half2 _Detail1MainSpeed;
            half _EdgeFalloffMultiply;
            half _EdgeFalloffPower;
            half _CleanFalloffMultiply;
            half _CleanFalloffPower;
            half4 _ShalowColor;
            half _ShalowFalloffMultiply;
            half _ShalowFalloffPower;
            half4 _DeepColor;
            half _WaterAlphaMultiply;
            half _WaterAlphaPower;
            half _WaterSmoothness;
            half _WaterSpecularClose;
            half _WaterSpecularFar;
            half _WaterSpecularThreshold;
            half _Distortion;
            half _BackfaceAlpha;
            half2 _SlowWaterTiling;
            half _SlowNormalScale;
            half _CascadeAngle;
            half _CascadeAngleFalloff;
            half2 _CascadeTiling;
            half _CascadeNormalScale;
            half _CascadeTransparency;
            half2 _Detail1Tiling;
            half4 _DetailAlbedoColor;
            half _DetailNormalScale;
            half _DetailSmoothness;
            half _Detail1Specular;
            half2 _NoiseTiling1;
            half _Detail1NoisePower;
            half _Detail1NoiseMultiply;
            half _WaterFlowUVRefresSpeed;
            half _CascadeFlowUVRefreshSpeed;
            half _Detail1FlowUVRefreshSpeed;
            half _AOPower;
            half _DetailAOPower;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); half4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_Detail1GSmDetail2ASm); SAMPLER(sampler_Detail1GSmDetail2ASm); half4 _Detail1GSmDetail2ASm_TexelSize;
            TEXTURE2D(_DetailAlbedo); SAMPLER(sampler_DetailAlbedo); half4 _DetailAlbedo_TexelSize;
            TEXTURE2D(_DetailNormal); SAMPLER(sampler_DetailNormal); half4 _DetailNormal_TexelSize;
            TEXTURE2D(_Noise); SAMPLER(sampler_Noise); half4 _Noise_TexelSize;
        
            // Graph Functions
            
            void Unity_SceneDepth_Linear01_half(half4 UV, out half Out)
            {
                Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
            
            void Unity_Multiply_half(half A, half B, out half Out)
            {
                Out = A * B;
            }
            
            void Unity_Subtract_half(half A, half B, out half Out)
            {
                Out = A - B;
            }
            
            void Unity_Clamp_half(half In, half Min, half Max, out half Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_Absolute_half(half In, out half Out)
            {
                Out = abs(In);
            }
            
            void Unity_Power_half(half A, half B, out half Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Branch_half(half Predicate, half True, half False, out half Out)
            {
                Out = lerp(False, True, Predicate);
            }
        
            // Graph Vertex
            // GraphVertex: <None>
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpacePosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 ScreenPosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 VertexColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float FaceSign;
                #endif
            };
            
            struct SurfaceDescription
            {
                half Alpha;
                half AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _ScreenPosition_E4782AF8_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _SceneDepth_33F13F54_Out_1;
                Unity_SceneDepth_Linear01_half(_ScreenPosition_E4782AF8_Out_0, _SceneDepth_33F13F54_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_39A1673A_Out_2;
                Unity_Multiply_half(_SceneDepth_33F13F54_Out_1, _ProjectionParams.z, _Multiply_39A1673A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _ScreenPosition_35A77C4_Out_0 = IN.ScreenPosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_D36BBBDE_R_1 = _ScreenPosition_35A77C4_Out_0[0];
                half _Split_D36BBBDE_G_2 = _ScreenPosition_35A77C4_Out_0[1];
                half _Split_D36BBBDE_B_3 = _ScreenPosition_35A77C4_Out_0[2];
                half _Split_D36BBBDE_A_4 = _ScreenPosition_35A77C4_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_331D19CE_Out_2;
                Unity_Subtract_half(_Multiply_39A1673A_Out_2, _Split_D36BBBDE_A_4, _Subtract_331D19CE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_52B645B4_Out_0 = _EdgeFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_C4830DE7_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_52B645B4_Out_0, _Multiply_C4830DE7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_48A3004E_Out_3;
                Unity_Clamp_half(_Multiply_C4830DE7_Out_2, 0, 1, _Clamp_48A3004E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_D3964C1C_Out_1;
                Unity_Absolute_half(_Clamp_48A3004E_Out_3, _Absolute_D3964C1C_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_69C29CD0_Out_0 = _EdgeFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_B73FC60F_Out_2;
                Unity_Power_half(_Absolute_D3964C1C_Out_1, _Property_69C29CD0_Out_0, _Power_B73FC60F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_2EDE896F_Out_3;
                Unity_Clamp_half(_Power_B73FC60F_Out_2, 0, 1, _Clamp_2EDE896F_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_42E433A0_R_1 = IN.VertexColor[0];
                half _Split_42E433A0_G_2 = IN.VertexColor[1];
                half _Split_42E433A0_B_3 = IN.VertexColor[2];
                half _Split_42E433A0_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_73E319C1_Out_2;
                Unity_Multiply_half(_Clamp_2EDE896F_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_6C82272C_Out_0 = _BackfaceAlpha;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_EE3AF77D_Out_2;
                Unity_Multiply_half(_Property_6C82272C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Branch_6D78BA69_Out_3;
                Unity_Branch_half(_IsFrontFace_29CBC83C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2, _Branch_6D78BA69_Out_3);
                #endif
                surface.Alpha = _Branch_6D78BA69_Out_3;
                surface.AlphaClipThreshold = 0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionOS : POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalOS : NORMAL;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentOS : TANGENT;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color : COLOR;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 positionCS : SV_POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #endif
            };
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float3 interp00 : TEXCOORD0;
                float4 interp01 : TEXCOORD1;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyzw = input.color;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output = (Varyings)0;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.color = input.interp01.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            #endif
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpacePosition =          input.positionWS;
            #endif
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            #endif
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.VertexColor =                 input.color;
            #endif
            
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
            ENDHLSL
        }
        
        Pass
        {
            Name "Meta"
            Tags 
            { 
                "LightMode" = "Meta"
            }
           
            // Render State
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>
            
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
        
            // Keywords
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local _ _DISTORTION_ON
            
            #if defined(_DISTORTION_ON)
                #define KEYWORD_PERMUTATION_0
            #else
                #define KEYWORD_PERMUTATION_1
            #endif
            
            
            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif
        
        
        
            #define _NORMAL_DROPOFF_TS 1
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD2
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD3
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS 
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD3
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif
        
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_CULLFACE
        #endif
        
            #define SHADERPASS_META
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define REQUIRE_DEPTH_TEXTURE
            #endif
            #if defined(KEYWORD_PERMUTATION_0)
            #define REQUIRE_OPAQUE_TEXTURE
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            half _GlobalTiling;
            half _UVVDirection1UDirection0;
            half2 _SlowWaterSpeed;
            half2 _CascadeMainSpeed;
            half2 _Detail1MainSpeed;
            half _EdgeFalloffMultiply;
            half _EdgeFalloffPower;
            half _CleanFalloffMultiply;
            half _CleanFalloffPower;
            half4 _ShalowColor;
            half _ShalowFalloffMultiply;
            half _ShalowFalloffPower;
            half4 _DeepColor;
            half _WaterAlphaMultiply;
            half _WaterAlphaPower;
            half _WaterSmoothness;
            half _WaterSpecularClose;
            half _WaterSpecularFar;
            half _WaterSpecularThreshold;
            half _Distortion;
            half _BackfaceAlpha;
            half2 _SlowWaterTiling;
            half _SlowNormalScale;
            half _CascadeAngle;
            half _CascadeAngleFalloff;
            half2 _CascadeTiling;
            half _CascadeNormalScale;
            half _CascadeTransparency;
            half2 _Detail1Tiling;
            half4 _DetailAlbedoColor;
            half _DetailNormalScale;
            half _DetailSmoothness;
            half _Detail1Specular;
            half2 _NoiseTiling1;
            half _Detail1NoisePower;
            half _Detail1NoiseMultiply;
            half _WaterFlowUVRefresSpeed;
            half _CascadeFlowUVRefreshSpeed;
            half _Detail1FlowUVRefreshSpeed;
            half _AOPower;
            half _DetailAOPower;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); half4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_Detail1GSmDetail2ASm); SAMPLER(sampler_Detail1GSmDetail2ASm); half4 _Detail1GSmDetail2ASm_TexelSize;
            TEXTURE2D(_DetailAlbedo); SAMPLER(sampler_DetailAlbedo); half4 _DetailAlbedo_TexelSize;
            TEXTURE2D(_DetailNormal); SAMPLER(sampler_DetailNormal); half4 _DetailNormal_TexelSize;
            TEXTURE2D(_Noise); SAMPLER(sampler_Noise); half4 _Noise_TexelSize;
            SAMPLER(_SampleTexture2D_91308B7C_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_4508A259_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_31496932_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_BEDCCB97_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_B8ACE3F1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A1621BBD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_E54CB7DD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_35B340E9_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_AEBC8292_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9126225F_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Multiply_half(half2 A, half2 B, out half2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_half2(half Predicate, half2 True, half2 False, out half2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Multiply_half(half A, half B, out half Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_half(half A, half B, out half Out)
            {
                Out = A + B;
            }
            
            void Unity_Fraction_half(half In, out half Out)
            {
                Out = frac(In);
            }
            
            void Unity_Divide_half(half A, half B, out half Out)
            {
                Out = A / B;
            }
            
            void Unity_Add_half2(half2 A, half2 B, out half2 Out)
            {
                Out = A + B;
            }
            
            void Unity_NormalStrength_half(half3 In, half Strength, out half3 Out)
            {
                Out = half3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
            }
            
            void Unity_Absolute_half(half In, out half Out)
            {
                Out = abs(In);
            }
            
            void Unity_Lerp_half3(half3 A, half3 B, half3 T, out half3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Lerp_half4(half4 A, half4 B, half4 T, out half4 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Lerp_half(half A, half B, half T, out half Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Power_half(half A, half B, out half Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Clamp_half(half In, half Min, half Max, out half Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_OneMinus_half(half In, out half Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Subtract_half(half A, half B, out half Out)
            {
                Out = A - B;
            }
            
            void Unity_Normalize_half3(half3 In, out half3 Out)
            {
                Out = normalize(In);
            }
            
            void Unity_Combine_half(half R, half G, half B, half A, out half4 RGBA, out half3 RGB, out half2 RG)
            {
                RGBA = half4(R, G, B, A);
                RGB = half3(R, G, B);
                RG = half2(R, G);
            }
            
            void Unity_SceneColor_half(half4 UV, out half3 Out)
            {
                Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
            }
            
            void Unity_SceneDepth_Linear01_half(half4 UV, out half Out)
            {
                Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
            
            void Unity_Saturate_half(half In, out half Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Multiply_half(half3 A, half3 B, out half3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Multiply_half(half4 A, half4 B, out half4 Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_half(half Predicate, half True, half False, out half Out)
            {
                Out = lerp(False, True, Predicate);
            }
        
            // Graph Vertex
            // GraphVertex: <None>
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpacePosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 ScreenPosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 VertexColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 TimeParameters;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float FaceSign;
                #endif
            };
            
            struct SurfaceDescription
            {
                half3 Albedo;
                half3 Emission;
                half Alpha;
                half AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _ScreenPosition_590B4FA3_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_FC343CDD_Out_0 = _Distortion;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_half(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _UV_AA9F78F6_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_half(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                half _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                half _Split_1CCC86B0_B_3 = 0;
                half _Split_1CCC86B0_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Vector2_D812D559_Out_0 = half2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Branch_FA6538E6_Out_3;
                Unity_Branch_half2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_41D6C6C9_Out_2;
                Unity_Add_half(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_half(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_half(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_52173963_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Divide_654AFB32_Out_2;
                Unity_Divide_half(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _UV_B5F91807_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_half(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_half((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_7772C3BA_Out_2;
                Unity_Add_half2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_7772C3BA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_91308B7C_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_7772C3BA_Out_2);
                _SampleTexture2D_91308B7C_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_91308B7C_RGBA_0);
                half _SampleTexture2D_91308B7C_R_4 = _SampleTexture2D_91308B7C_RGBA_0.r;
                half _SampleTexture2D_91308B7C_G_5 = _SampleTexture2D_91308B7C_RGBA_0.g;
                half _SampleTexture2D_91308B7C_B_6 = _SampleTexture2D_91308B7C_RGBA_0.b;
                half _SampleTexture2D_91308B7C_A_7 = _SampleTexture2D_91308B7C_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_BE91B4F6_Out_0 = _SlowNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_528ACD86_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_91308B7C_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_528ACD86_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_31890938_Out_2;
                Unity_Add_half(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Fraction_F03C9359_Out_1;
                Unity_Fraction_half(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_FE081078_Out_2;
                Unity_Multiply_half(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_C1F18389_Out_2;
                Unity_Add_half2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_C1F18389_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_4508A259_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_C1F18389_Out_2);
                _SampleTexture2D_4508A259_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_4508A259_RGBA_0);
                half _SampleTexture2D_4508A259_R_4 = _SampleTexture2D_4508A259_RGBA_0.r;
                half _SampleTexture2D_4508A259_G_5 = _SampleTexture2D_4508A259_RGBA_0.g;
                half _SampleTexture2D_4508A259_B_6 = _SampleTexture2D_4508A259_RGBA_0.b;
                half _SampleTexture2D_4508A259_A_7 = _SampleTexture2D_4508A259_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_3BD81F5D_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_4508A259_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_3BD81F5D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_9431F443_Out_2;
                Unity_Add_half(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_483E3720_Out_2;
                Unity_Multiply_half(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Absolute_6685A82A_Out_1;
                Unity_Absolute_half(_Multiply_483E3720_Out_2, _Absolute_6685A82A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_356E067F_Out_3;
                Unity_Lerp_half3(_NormalStrength_528ACD86_Out_2, _NormalStrength_3BD81F5D_Out_2, (_Absolute_6685A82A_Out_1.xxx), _Lerp_356E067F_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_F5E0A69B_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_2DC0B257_Out_0 = _Detail1MainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_6E5EFE29_Out_0 = _Detail1Tiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_7748686D_Out_2;
                Unity_Multiply_half(_Property_2DC0B257_Out_0, _Property_6E5EFE29_Out_0, _Multiply_7748686D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_3FC112BC_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_AF306880_Out_2;
                Unity_Multiply_half(_Multiply_7748686D_Out_2, (_UV_3FC112BC_Out_0.xy), _Multiply_AF306880_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_B1FC6FBE_R_1 = _Multiply_AF306880_Out_2[0];
                half _Split_B1FC6FBE_G_2 = _Multiply_AF306880_Out_2[1];
                half _Split_B1FC6FBE_B_3 = 0;
                half _Split_B1FC6FBE_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_AD94E758_Out_0 = half2(_Split_B1FC6FBE_G_2, _Split_B1FC6FBE_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_65700BCC_Out_3;
                Unity_Branch_half2(_Property_F5E0A69B_Out_0, _Multiply_AF306880_Out_2, _Vector2_AD94E758_Out_0, _Branch_65700BCC_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_F1F3D035_Out_0 = _Detail1FlowUVRefreshSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A19D7537_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_F1F3D035_Out_0, _Multiply_A19D7537_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_28E3F138_Out_2;
                Unity_Add_half(_Multiply_A19D7537_Out_2, 1, _Add_28E3F138_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_D2DC6DD9_Out_1;
                Unity_Fraction_half(_Add_28E3F138_Out_2, _Fraction_D2DC6DD9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_5F61A5DA_Out_2;
                Unity_Multiply_half(_Branch_65700BCC_Out_3, (_Fraction_D2DC6DD9_Out_1.xx), _Multiply_5F61A5DA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_5D47C22C_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_4C511BD_Out_2;
                Unity_Divide_half(1, _Property_5D47C22C_Out_0, _Divide_4C511BD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_4B625890_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_A6640011_Out_2;
                Unity_Multiply_half(_Property_6E5EFE29_Out_0, (_UV_4B625890_Out_0.xy), _Multiply_A6640011_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_9324F9E4_Out_2;
                Unity_Multiply_half((_Divide_4C511BD_Out_2.xx), _Multiply_A6640011_Out_2, _Multiply_9324F9E4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_8A8E7455_Out_2;
                Unity_Add_half2(_Multiply_5F61A5DA_Out_2, _Multiply_9324F9E4_Out_2, _Add_8A8E7455_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_31496932_RGBA_0 = SAMPLE_TEXTURE2D(_DetailNormal, sampler_DetailNormal, _Add_8A8E7455_Out_2);
                _SampleTexture2D_31496932_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_31496932_RGBA_0);
                half _SampleTexture2D_31496932_R_4 = _SampleTexture2D_31496932_RGBA_0.r;
                half _SampleTexture2D_31496932_G_5 = _SampleTexture2D_31496932_RGBA_0.g;
                half _SampleTexture2D_31496932_B_6 = _SampleTexture2D_31496932_RGBA_0.b;
                half _SampleTexture2D_31496932_A_7 = _SampleTexture2D_31496932_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_5566E68B_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_49B5F443_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_31496932_RGBA_0.xyz), _Property_5566E68B_Out_0, _NormalStrength_49B5F443_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_CBBBA061_Out_2;
                Unity_Add_half(_Multiply_A19D7537_Out_2, 0.5, _Add_CBBBA061_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_37B97A80_Out_1;
                Unity_Fraction_half(_Add_CBBBA061_Out_2, _Fraction_37B97A80_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_D8C05DAF_Out_2;
                Unity_Multiply_half(_Branch_65700BCC_Out_3, (_Fraction_37B97A80_Out_1.xx), _Multiply_D8C05DAF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_F35A6507_Out_2;
                Unity_Add_half2(_Multiply_9324F9E4_Out_2, _Multiply_D8C05DAF_Out_2, _Add_F35A6507_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_BEDCCB97_RGBA_0 = SAMPLE_TEXTURE2D(_DetailNormal, sampler_DetailNormal, _Add_F35A6507_Out_2);
                _SampleTexture2D_BEDCCB97_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_BEDCCB97_RGBA_0);
                half _SampleTexture2D_BEDCCB97_R_4 = _SampleTexture2D_BEDCCB97_RGBA_0.r;
                half _SampleTexture2D_BEDCCB97_G_5 = _SampleTexture2D_BEDCCB97_RGBA_0.g;
                half _SampleTexture2D_BEDCCB97_B_6 = _SampleTexture2D_BEDCCB97_RGBA_0.b;
                half _SampleTexture2D_BEDCCB97_A_7 = _SampleTexture2D_BEDCCB97_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_C4CCB54D_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_BEDCCB97_RGBA_0.xyz), _Property_5566E68B_Out_0, _NormalStrength_C4CCB54D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_BC933749_Out_2;
                Unity_Add_half(_Fraction_D2DC6DD9_Out_1, -0.5, _Add_BC933749_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_DF41C813_Out_2;
                Unity_Multiply_half(_Add_BC933749_Out_2, 2, _Multiply_DF41C813_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_476B42D9_Out_1;
                Unity_Absolute_half(_Multiply_DF41C813_Out_2, _Absolute_476B42D9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_14477A5_Out_3;
                Unity_Lerp_half3(_NormalStrength_49B5F443_Out_2, _NormalStrength_C4CCB54D_Out_2, (_Absolute_476B42D9_Out_1.xxx), _Lerp_14477A5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_B8ACE3F1_RGBA_0 = SAMPLE_TEXTURE2D(_DetailAlbedo, sampler_DetailAlbedo, _Add_8A8E7455_Out_2);
                half _SampleTexture2D_B8ACE3F1_R_4 = _SampleTexture2D_B8ACE3F1_RGBA_0.r;
                half _SampleTexture2D_B8ACE3F1_G_5 = _SampleTexture2D_B8ACE3F1_RGBA_0.g;
                half _SampleTexture2D_B8ACE3F1_B_6 = _SampleTexture2D_B8ACE3F1_RGBA_0.b;
                half _SampleTexture2D_B8ACE3F1_A_7 = _SampleTexture2D_B8ACE3F1_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_A1621BBD_RGBA_0 = SAMPLE_TEXTURE2D(_DetailAlbedo, sampler_DetailAlbedo, _Add_F35A6507_Out_2);
                half _SampleTexture2D_A1621BBD_R_4 = _SampleTexture2D_A1621BBD_RGBA_0.r;
                half _SampleTexture2D_A1621BBD_G_5 = _SampleTexture2D_A1621BBD_RGBA_0.g;
                half _SampleTexture2D_A1621BBD_B_6 = _SampleTexture2D_A1621BBD_RGBA_0.b;
                half _SampleTexture2D_A1621BBD_A_7 = _SampleTexture2D_A1621BBD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Lerp_11CAC5B2_Out_3;
                Unity_Lerp_half4(_SampleTexture2D_B8ACE3F1_RGBA_0, _SampleTexture2D_A1621BBD_RGBA_0, (_Absolute_476B42D9_Out_1.xxxx), _Lerp_11CAC5B2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_2099A5DB_R_1 = _Lerp_11CAC5B2_Out_3[0];
                half _Split_2099A5DB_G_2 = _Lerp_11CAC5B2_Out_3[1];
                half _Split_2099A5DB_B_3 = _Lerp_11CAC5B2_Out_3[2];
                half _Split_2099A5DB_A_4 = _Lerp_11CAC5B2_Out_3[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_D4F6F844_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_A4A55C8D_Out_0 = _NoiseTiling1;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_6D76AFA6_Out_2;
                Unity_Multiply_half(_Property_2DC0B257_Out_0, _Property_A4A55C8D_Out_0, _Multiply_6D76AFA6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_F6117BE8_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_8B060916_Out_2;
                Unity_Multiply_half(_Multiply_6D76AFA6_Out_2, (_UV_F6117BE8_Out_0.xy), _Multiply_8B060916_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_A4B34BC7_R_1 = _Multiply_8B060916_Out_2[0];
                half _Split_A4B34BC7_G_2 = _Multiply_8B060916_Out_2[1];
                half _Split_A4B34BC7_B_3 = 0;
                half _Split_A4B34BC7_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_680633BC_Out_0 = half2(_Split_A4B34BC7_G_2, _Split_A4B34BC7_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_35279751_Out_3;
                Unity_Branch_half2(_Property_D4F6F844_Out_0, _Multiply_8B060916_Out_2, _Vector2_680633BC_Out_0, _Branch_35279751_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_DE608340_Out_2;
                Unity_Multiply_half(_Branch_35279751_Out_3, (_Fraction_D2DC6DD9_Out_1.xx), _Multiply_DE608340_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_56E8C0F2_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_8E603DE9_Out_2;
                Unity_Divide_half(1, _Property_56E8C0F2_Out_0, _Divide_8E603DE9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_D4E93B1E_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_42C43DD7_Out_2;
                Unity_Multiply_half(_Property_A4A55C8D_Out_0, (_UV_D4E93B1E_Out_0.xy), _Multiply_42C43DD7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_AE0BBFAF_Out_2;
                Unity_Multiply_half((_Divide_8E603DE9_Out_2.xx), _Multiply_42C43DD7_Out_2, _Multiply_AE0BBFAF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_56C76C69_Out_2;
                Unity_Add_half2(_Multiply_DE608340_Out_2, _Multiply_AE0BBFAF_Out_2, _Add_56C76C69_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_E54CB7DD_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_56C76C69_Out_2);
                half _SampleTexture2D_E54CB7DD_R_4 = _SampleTexture2D_E54CB7DD_RGBA_0.r;
                half _SampleTexture2D_E54CB7DD_G_5 = _SampleTexture2D_E54CB7DD_RGBA_0.g;
                half _SampleTexture2D_E54CB7DD_B_6 = _SampleTexture2D_E54CB7DD_RGBA_0.b;
                half _SampleTexture2D_E54CB7DD_A_7 = _SampleTexture2D_E54CB7DD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_A4082A4_Out_2;
                Unity_Multiply_half(_Branch_35279751_Out_3, (_Fraction_37B97A80_Out_1.xx), _Multiply_A4082A4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_F8B5ACD3_Out_2;
                Unity_Add_half2(_Multiply_A4082A4_Out_2, _Multiply_AE0BBFAF_Out_2, _Add_F8B5ACD3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_35B340E9_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_F8B5ACD3_Out_2);
                half _SampleTexture2D_35B340E9_R_4 = _SampleTexture2D_35B340E9_RGBA_0.r;
                half _SampleTexture2D_35B340E9_G_5 = _SampleTexture2D_35B340E9_RGBA_0.g;
                half _SampleTexture2D_35B340E9_B_6 = _SampleTexture2D_35B340E9_RGBA_0.b;
                half _SampleTexture2D_35B340E9_A_7 = _SampleTexture2D_35B340E9_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_6FEEAEA0_Out_3;
                Unity_Lerp_half(_SampleTexture2D_E54CB7DD_G_5, _SampleTexture2D_35B340E9_G_5, _Absolute_476B42D9_Out_1, _Lerp_6FEEAEA0_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_50C70389_Out_1;
                Unity_Absolute_half(_Lerp_6FEEAEA0_Out_3, _Absolute_50C70389_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C1134212_Out_0 = _Detail1NoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_483D9151_Out_2;
                Unity_Power_half(_Absolute_50C70389_Out_1, _Property_C1134212_Out_0, _Power_483D9151_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_8B0E8794_Out_0 = _Detail1NoiseMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_E26A26BB_Out_2;
                Unity_Multiply_half(_Power_483D9151_Out_2, _Property_8B0E8794_Out_0, _Multiply_E26A26BB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_805729EB_Out_3;
                Unity_Clamp_half(_Multiply_E26A26BB_Out_2, 0, 1, _Clamp_805729EB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_12157CAE_Out_2;
                Unity_Multiply_half(_Split_2099A5DB_A_4, _Clamp_805729EB_Out_3, _Multiply_12157CAE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_39572874_Out_3;
                Unity_Lerp_half(0, _Split_2099A5DB_A_4, _Multiply_12157CAE_Out_2, _Lerp_39572874_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_A40F2519_Out_3;
                Unity_Lerp_half3(_Lerp_356E067F_Out_3, _Lerp_14477A5_Out_3, (_Lerp_39572874_Out_3.xxx), _Lerp_A40F2519_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Property_FDE310C2_Out_0 = _CascadeMainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Property_87340130_Out_0 = _CascadeTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_half(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _UV_106B410B_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_A639E196_Out_2;
                Unity_Multiply_half(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                half _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                half _Split_D288CE58_B_3 = 0;
                half _Split_D288CE58_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Vector2_76C74260_Out_0 = half2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_half2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_375B806D_Out_0 = _CascadeFlowUVRefreshSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_7EF542FE_Out_2;
                Unity_Add_half(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Fraction_5582502D_Out_1;
                Unity_Fraction_half(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_half(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_506342C2_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Divide_E07C316A_Out_2;
                Unity_Divide_half(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _UV_BEAE142D_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_half(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_half((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_188C8FD3_Out_2;
                Unity_Add_half2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_188C8FD3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_AEBC8292_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_188C8FD3_Out_2);
                _SampleTexture2D_AEBC8292_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AEBC8292_RGBA_0);
                half _SampleTexture2D_AEBC8292_R_4 = _SampleTexture2D_AEBC8292_RGBA_0.r;
                half _SampleTexture2D_AEBC8292_G_5 = _SampleTexture2D_AEBC8292_RGBA_0.g;
                half _SampleTexture2D_AEBC8292_B_6 = _SampleTexture2D_AEBC8292_RGBA_0.b;
                half _SampleTexture2D_AEBC8292_A_7 = _SampleTexture2D_AEBC8292_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_8A81F679_Out_0 = _CascadeNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_94FC33DB_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_AEBC8292_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_94FC33DB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_42A4AEEC_Out_2;
                Unity_Add_half(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Fraction_3662A9DE_Out_1;
                Unity_Fraction_half(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_283B3646_Out_2;
                Unity_Multiply_half(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_3E5AC13E_Out_2;
                Unity_Add_half2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_3E5AC13E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_9126225F_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_3E5AC13E_Out_2);
                _SampleTexture2D_9126225F_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9126225F_RGBA_0);
                half _SampleTexture2D_9126225F_R_4 = _SampleTexture2D_9126225F_RGBA_0.r;
                half _SampleTexture2D_9126225F_G_5 = _SampleTexture2D_9126225F_RGBA_0.g;
                half _SampleTexture2D_9126225F_B_6 = _SampleTexture2D_9126225F_RGBA_0.b;
                half _SampleTexture2D_9126225F_A_7 = _SampleTexture2D_9126225F_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_337B983B_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_9126225F_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_337B983B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_1044203D_Out_2;
                Unity_Add_half(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_half(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Absolute_D56AD49D_Out_1;
                Unity_Absolute_half(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_5B898C96_Out_3;
                Unity_Lerp_half3(_NormalStrength_94FC33DB_Out_2, _NormalStrength_337B983B_Out_2, (_Absolute_D56AD49D_Out_1.xxx), _Lerp_5B898C96_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                half _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                half _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                half _Split_C4B2F888_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_F22E389A_Out_1;
                Unity_Absolute_half(_Split_C4B2F888_G_2, _Absolute_F22E389A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7DFFA574_Out_3;
                Unity_Clamp_half(_Absolute_F22E389A_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C24EE4D_Out_0 = _CascadeAngle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_3235AB33_Out_2;
                Unity_Divide_half(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_57DB513_Out_1;
                Unity_OneMinus_half(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_B782DE16_Out_2;
                Unity_Subtract_half(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_half(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_BD74F0DD_Out_2;
                Unity_Divide_half(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A56B78D9_Out_2;
                Unity_Multiply_half(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_368478F5_Out_3;
                Unity_Clamp_half(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_half(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_438A66D_Out_1;
                Unity_Absolute_half(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_1F70A06C_Out_0 = _CascadeAngleFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_A86AE25B_Out_2;
                Unity_Power_half(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C9BB189_Out_3;
                Unity_Clamp_half(_Power_A86AE25B_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_BA2C71FD_Out_3;
                Unity_Lerp_half3(_Lerp_A40F2519_Out_3, _Lerp_5B898C96_Out_3, (_Clamp_C9BB189_Out_3.xxx), _Lerp_BA2C71FD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Normalize_C75C1ECE_Out_1;
                Unity_Normalize_half3(_Lerp_BA2C71FD_Out_3, _Normalize_C75C1ECE_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Split_6A7D546B_R_1 = _Normalize_C75C1ECE_Out_1[0];
                half _Split_6A7D546B_G_2 = _Normalize_C75C1ECE_Out_1[1];
                half _Split_6A7D546B_B_3 = _Normalize_C75C1ECE_Out_1[2];
                half _Split_6A7D546B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _Combine_E07639F2_RGBA_4;
                half3 _Combine_E07639F2_RGB_5;
                half2 _Combine_E07639F2_RG_6;
                Unity_Combine_half(_Split_6A7D546B_R_1, _Split_6A7D546B_G_2, 0, 0, _Combine_E07639F2_RGBA_4, _Combine_E07639F2_RGB_5, _Combine_E07639F2_RG_6);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_2F7622D8_Out_2;
                Unity_Multiply_half((_Property_FC343CDD_Out_0.xx), _Combine_E07639F2_RG_6, _Multiply_2F7622D8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_771FE10A_Out_2;
                Unity_Multiply_half((_ScreenPosition_590B4FA3_Out_0.xy), _Multiply_2F7622D8_Out_2, _Multiply_771FE10A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_996FBC6B_Out_2;
                Unity_Add_half2((_ScreenPosition_590B4FA3_Out_0.xy), _Multiply_771FE10A_Out_2, _Add_996FBC6B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _SceneColor_9C32DAB4_Out_1;
                Unity_SceneColor_half((half4(_Add_996FBC6B_Out_2, 0.0, 1.0)), _SceneColor_9C32DAB4_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_C4180B07_Out_0 = _DeepColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_B354F529_Out_0 = _ShalowColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _ScreenPosition_E4782AF8_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _SceneDepth_33F13F54_Out_1;
                Unity_SceneDepth_Linear01_half(_ScreenPosition_E4782AF8_Out_0, _SceneDepth_33F13F54_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_39A1673A_Out_2;
                Unity_Multiply_half(_SceneDepth_33F13F54_Out_1, _ProjectionParams.z, _Multiply_39A1673A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _ScreenPosition_35A77C4_Out_0 = IN.ScreenPosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_D36BBBDE_R_1 = _ScreenPosition_35A77C4_Out_0[0];
                half _Split_D36BBBDE_G_2 = _ScreenPosition_35A77C4_Out_0[1];
                half _Split_D36BBBDE_B_3 = _ScreenPosition_35A77C4_Out_0[2];
                half _Split_D36BBBDE_A_4 = _ScreenPosition_35A77C4_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_331D19CE_Out_2;
                Unity_Subtract_half(_Multiply_39A1673A_Out_2, _Split_D36BBBDE_A_4, _Subtract_331D19CE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_46A80510_Out_0 = _ShalowFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_55CDC796_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_46A80510_Out_0, _Multiply_55CDC796_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_DA749514_Out_1;
                Unity_Absolute_half(_Multiply_55CDC796_Out_2, _Absolute_DA749514_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_4D681D1C_Out_0 = _ShalowFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_F7AB70ED_Out_2;
                Unity_Multiply_half(_Property_4D681D1C_Out_0, -1, _Multiply_F7AB70ED_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_3270BF29_Out_2;
                Unity_Power_half(_Absolute_DA749514_Out_1, _Multiply_F7AB70ED_Out_2, _Power_3270BF29_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_BB1D3A49_Out_0 = _CascadeTransparency;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_6F5E4CCF_Out_2;
                Unity_Multiply_half(_Property_BB1D3A49_Out_0, _Clamp_C9BB189_Out_3, _Multiply_6F5E4CCF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_FE3B891E_Out_3;
                Unity_Lerp_half(_Power_3270BF29_Out_2, 100, _Multiply_6F5E4CCF_Out_2, _Lerp_FE3B891E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Saturate_47EA3698_Out_1;
                Unity_Saturate_half(_Lerp_FE3B891E_Out_3, _Saturate_47EA3698_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_FA371D5_Out_3;
                Unity_Clamp_half(_Saturate_47EA3698_Out_1, 0, 1, _Clamp_FA371D5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Lerp_E98C0337_Out_3;
                Unity_Lerp_half4(_Property_C4180B07_Out_0, _Property_B354F529_Out_0, (_Clamp_FA371D5_Out_3.xxxx), _Lerp_E98C0337_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Multiply_689418CF_Out_2;
                Unity_Multiply_half((_Lerp_E98C0337_Out_3.xyz), _SceneColor_9C32DAB4_Out_1, _Multiply_689418CF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_8B8E643D_Out_0 = _WaterAlphaMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_BF88B5F8_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_8B8E643D_Out_0, _Multiply_BF88B5F8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_53D1B29C_Out_3;
                Unity_Clamp_half(_Multiply_BF88B5F8_Out_2, 0, 1, _Clamp_53D1B29C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_EC47432B_Out_0 = _WaterAlphaPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Power_83812DD0_Out_2;
                Unity_Power_half(_Clamp_53D1B29C_Out_3, _Property_EC47432B_Out_0, _Power_83812DD0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_A62DB403_Out_3;
                Unity_Clamp_half(_Power_83812DD0_Out_2, 0, 1, _Clamp_A62DB403_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_BDDADE6B_Out_3;
                Unity_Lerp_half3(_Multiply_689418CF_Out_2, (_Lerp_E98C0337_Out_3.xyz), (_Clamp_A62DB403_Out_3.xxx), _Lerp_BDDADE6B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_312FB549_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_43A46A4A_Out_3;
                Unity_Clamp_half(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Absolute_97151155_Out_1;
                Unity_Absolute_half(_Clamp_43A46A4A_Out_3, _Absolute_97151155_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_D7C9F55F_Out_0 = _CleanFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Power_AD928E85_Out_2;
                Unity_Power_half(_Absolute_97151155_Out_1, _Property_D7C9F55F_Out_0, _Power_AD928E85_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_9B4149BD_Out_3;
                Unity_Clamp_half(_Power_AD928E85_Out_2, 0, 1, _Clamp_9B4149BD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_3B329D09_Out_3;
                Unity_Lerp_half3(_SceneColor_9C32DAB4_Out_1, _Lerp_BDDADE6B_Out_3, (_Clamp_9B4149BD_Out_3.xxx), _Lerp_3B329D09_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_DISTORTION_ON)
                half3 _UseDistortion_F844CC61_Out_0 = _Lerp_3B329D09_Out_3;
                #else
                half3 _UseDistortion_F844CC61_Out_0 = (_Lerp_E98C0337_Out_3.xyz);
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_F19A2B5F_Out_0 = _DetailAlbedoColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_E85EE897_Out_2;
                Unity_Multiply_half(_Lerp_11CAC5B2_Out_3, _Property_F19A2B5F_Out_0, _Multiply_E85EE897_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_F64B17F5_Out_3;
                Unity_Lerp_half3(_UseDistortion_F844CC61_Out_0, (_Multiply_E85EE897_Out_2.xyz), (_Lerp_39572874_Out_3.xxx), _Lerp_F64B17F5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_4F98523C_Out_3;
                Unity_Lerp_half3(_Lerp_F64B17F5_Out_3, _UseDistortion_F844CC61_Out_0, (_Clamp_C9BB189_Out_3.xxx), _Lerp_4F98523C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_52B645B4_Out_0 = _EdgeFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_C4830DE7_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_52B645B4_Out_0, _Multiply_C4830DE7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_48A3004E_Out_3;
                Unity_Clamp_half(_Multiply_C4830DE7_Out_2, 0, 1, _Clamp_48A3004E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_D3964C1C_Out_1;
                Unity_Absolute_half(_Clamp_48A3004E_Out_3, _Absolute_D3964C1C_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_69C29CD0_Out_0 = _EdgeFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_B73FC60F_Out_2;
                Unity_Power_half(_Absolute_D3964C1C_Out_1, _Property_69C29CD0_Out_0, _Power_B73FC60F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_2EDE896F_Out_3;
                Unity_Clamp_half(_Power_B73FC60F_Out_2, 0, 1, _Clamp_2EDE896F_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_42E433A0_R_1 = IN.VertexColor[0];
                half _Split_42E433A0_G_2 = IN.VertexColor[1];
                half _Split_42E433A0_B_3 = IN.VertexColor[2];
                half _Split_42E433A0_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_73E319C1_Out_2;
                Unity_Multiply_half(_Clamp_2EDE896F_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_6C82272C_Out_0 = _BackfaceAlpha;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_EE3AF77D_Out_2;
                Unity_Multiply_half(_Property_6C82272C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Branch_6D78BA69_Out_3;
                Unity_Branch_half(_IsFrontFace_29CBC83C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2, _Branch_6D78BA69_Out_3);
                #endif
                surface.Albedo = _Lerp_4F98523C_Out_3;
                surface.Emission = IsGammaSpace() ? half3(0, 0, 0) : SRGBToLinear(half3(0, 0, 0));
                surface.Alpha = _Branch_6D78BA69_Out_3;
                surface.AlphaClipThreshold = 0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionOS : POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalOS : NORMAL;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentOS : TANGENT;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0 : TEXCOORD0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv1 : TEXCOORD1;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv2 : TEXCOORD2;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv3 : TEXCOORD3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color : COLOR;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 positionCS : SV_POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #endif
            };
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float3 interp00 : TEXCOORD0;
                float3 interp01 : TEXCOORD1;
                float4 interp02 : TEXCOORD2;
                float4 interp03 : TEXCOORD3;
                float4 interp04 : TEXCOORD4;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.texCoord0;
                output.interp03.xyzw = input.texCoord3;
                output.interp04.xyzw = input.color;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output = (Varyings)0;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.texCoord0 = input.interp02.xyzw;
                output.texCoord3 = input.interp03.xyzw;
                output.color = input.interp04.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            #endif
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 unnormalizedNormalWS = input.normalWS;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
            #endif
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
            #endif
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpacePosition =          input.positionWS;
            #endif
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv0 =                         input.texCoord0;
            #endif
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv3 =                         input.texCoord3;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.VertexColor =                 input.color;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            #endif
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
        
            ENDHLSL
        }
        
        Pass
        {
            // Name: <None>
            Tags 
            { 
                "LightMode" = "Universal2D"
            }
           
            // Render State
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            Cull Off
            ZTest LEqual
            ZWrite On
            // ColorMask: <None>
            
        
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
        
            // Debug
            // <None>
        
            // --------------------------------------------------
            // Pass
        
            // Pragmas
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0
            #pragma multi_compile_instancing
        
            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature_local _ _DISTORTION_ON
            
            #if defined(_DISTORTION_ON)
                #define KEYWORD_PERMUTATION_0
            #else
                #define KEYWORD_PERMUTATION_1
            #endif
            
            
            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif
        
        
        
            #define _NORMAL_DROPOFF_TS 1
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD3
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_COLOR
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS 
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD3
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_COLOR
        #endif
        
        
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_CULLFACE
        #endif
        
            #define SHADERPASS_2D
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #define REQUIRE_DEPTH_TEXTURE
            #endif
            #if defined(KEYWORD_PERMUTATION_0)
            #define REQUIRE_OPAQUE_TEXTURE
            #endif
        
            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/ShaderVariablesFunctions.hlsl"
        
            // --------------------------------------------------
            // Graph
        
            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
            half _GlobalTiling;
            half _UVVDirection1UDirection0;
            half2 _SlowWaterSpeed;
            half2 _CascadeMainSpeed;
            half2 _Detail1MainSpeed;
            half _EdgeFalloffMultiply;
            half _EdgeFalloffPower;
            half _CleanFalloffMultiply;
            half _CleanFalloffPower;
            half4 _ShalowColor;
            half _ShalowFalloffMultiply;
            half _ShalowFalloffPower;
            half4 _DeepColor;
            half _WaterAlphaMultiply;
            half _WaterAlphaPower;
            half _WaterSmoothness;
            half _WaterSpecularClose;
            half _WaterSpecularFar;
            half _WaterSpecularThreshold;
            half _Distortion;
            half _BackfaceAlpha;
            half2 _SlowWaterTiling;
            half _SlowNormalScale;
            half _CascadeAngle;
            half _CascadeAngleFalloff;
            half2 _CascadeTiling;
            half _CascadeNormalScale;
            half _CascadeTransparency;
            half2 _Detail1Tiling;
            half4 _DetailAlbedoColor;
            half _DetailNormalScale;
            half _DetailSmoothness;
            half _Detail1Specular;
            half2 _NoiseTiling1;
            half _Detail1NoisePower;
            half _Detail1NoiseMultiply;
            half _WaterFlowUVRefresSpeed;
            half _CascadeFlowUVRefreshSpeed;
            half _Detail1FlowUVRefreshSpeed;
            half _AOPower;
            half _DetailAOPower;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); half4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_Detail1GSmDetail2ASm); SAMPLER(sampler_Detail1GSmDetail2ASm); half4 _Detail1GSmDetail2ASm_TexelSize;
            TEXTURE2D(_DetailAlbedo); SAMPLER(sampler_DetailAlbedo); half4 _DetailAlbedo_TexelSize;
            TEXTURE2D(_DetailNormal); SAMPLER(sampler_DetailNormal); half4 _DetailNormal_TexelSize;
            TEXTURE2D(_Noise); SAMPLER(sampler_Noise); half4 _Noise_TexelSize;
            SAMPLER(_SampleTexture2D_91308B7C_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_4508A259_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_31496932_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_BEDCCB97_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_B8ACE3F1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A1621BBD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_E54CB7DD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_35B340E9_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_AEBC8292_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9126225F_Sampler_3_Linear_Repeat);
        
            // Graph Functions
            
            void Unity_Multiply_half(half2 A, half2 B, out half2 Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_half2(half Predicate, half2 True, half2 False, out half2 Out)
            {
                Out = lerp(False, True, Predicate);
            }
            
            void Unity_Multiply_half(half A, half B, out half Out)
            {
                Out = A * B;
            }
            
            void Unity_Add_half(half A, half B, out half Out)
            {
                Out = A + B;
            }
            
            void Unity_Fraction_half(half In, out half Out)
            {
                Out = frac(In);
            }
            
            void Unity_Divide_half(half A, half B, out half Out)
            {
                Out = A / B;
            }
            
            void Unity_Add_half2(half2 A, half2 B, out half2 Out)
            {
                Out = A + B;
            }
            
            void Unity_NormalStrength_half(half3 In, half Strength, out half3 Out)
            {
                Out = half3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
            }
            
            void Unity_Absolute_half(half In, out half Out)
            {
                Out = abs(In);
            }
            
            void Unity_Lerp_half3(half3 A, half3 B, half3 T, out half3 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Lerp_half4(half4 A, half4 B, half4 T, out half4 Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Lerp_half(half A, half B, half T, out half Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Power_half(half A, half B, out half Out)
            {
                Out = pow(A, B);
            }
            
            void Unity_Clamp_half(half In, half Min, half Max, out half Out)
            {
                Out = clamp(In, Min, Max);
            }
            
            void Unity_OneMinus_half(half In, out half Out)
            {
                Out = 1 - In;
            }
            
            void Unity_Subtract_half(half A, half B, out half Out)
            {
                Out = A - B;
            }
            
            void Unity_Normalize_half3(half3 In, out half3 Out)
            {
                Out = normalize(In);
            }
            
            void Unity_Combine_half(half R, half G, half B, half A, out half4 RGBA, out half3 RGB, out half2 RG)
            {
                RGBA = half4(R, G, B, A);
                RGB = half3(R, G, B);
                RG = half2(R, G);
            }
            
            void Unity_SceneColor_half(half4 UV, out half3 Out)
            {
                Out = SHADERGRAPH_SAMPLE_SCENE_COLOR(UV.xy);
            }
            
            void Unity_SceneDepth_Linear01_half(half4 UV, out half Out)
            {
                Out = Linear01Depth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
            }
            
            void Unity_Saturate_half(half In, out half Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Multiply_half(half3 A, half3 B, out half3 Out)
            {
                Out = A * B;
            }
            
            void Unity_Multiply_half(half4 A, half4 B, out half4 Out)
            {
                Out = A * B;
            }
            
            void Unity_Branch_half(half Predicate, half True, half False, out half Out)
            {
                Out = lerp(False, True, Predicate);
            }
        
            // Graph Vertex
            // GraphVertex: <None>
            
            // Graph Pixel
            struct SurfaceDescriptionInputs
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpaceNormal;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 WorldSpacePosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 ScreenPosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 VertexColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 TimeParameters;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float FaceSign;
                #endif
            };
            
            struct SurfaceDescription
            {
                half3 Albedo;
                half Alpha;
                half AlphaClipThreshold;
            };
            
            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _ScreenPosition_590B4FA3_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_FC343CDD_Out_0 = _Distortion;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_94DAE2B7_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Property_34229B7_Out_0 = _SlowWaterSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Property_77068FF2_Out_0 = _SlowWaterTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_2B8AF4FA_Out_2;
                Unity_Multiply_half(_Property_34229B7_Out_0, _Property_77068FF2_Out_0, _Multiply_2B8AF4FA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _UV_AA9F78F6_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_F43FFA9D_Out_2;
                Unity_Multiply_half(_Multiply_2B8AF4FA_Out_2, (_UV_AA9F78F6_Out_0.xy), _Multiply_F43FFA9D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Split_1CCC86B0_R_1 = _Multiply_F43FFA9D_Out_2[0];
                half _Split_1CCC86B0_G_2 = _Multiply_F43FFA9D_Out_2[1];
                half _Split_1CCC86B0_B_3 = 0;
                half _Split_1CCC86B0_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Vector2_D812D559_Out_0 = half2(_Split_1CCC86B0_G_2, _Split_1CCC86B0_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Branch_FA6538E6_Out_3;
                Unity_Branch_half2(_Property_94DAE2B7_Out_0, _Multiply_F43FFA9D_Out_2, _Vector2_D812D559_Out_0, _Branch_FA6538E6_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_61A97ACD_Out_0 = _WaterFlowUVRefresSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_3E4E17C1_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_61A97ACD_Out_0, _Multiply_3E4E17C1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_41D6C6C9_Out_2;
                Unity_Add_half(_Multiply_3E4E17C1_Out_2, 1, _Add_41D6C6C9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Fraction_7B9D3CF1_Out_1;
                Unity_Fraction_half(_Add_41D6C6C9_Out_2, _Fraction_7B9D3CF1_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_85DC5862_Out_2;
                Unity_Multiply_half(_Branch_FA6538E6_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_85DC5862_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_52173963_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Divide_654AFB32_Out_2;
                Unity_Divide_half(1, _Property_52173963_Out_0, _Divide_654AFB32_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _UV_B5F91807_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_B26DE032_Out_2;
                Unity_Multiply_half(_Property_77068FF2_Out_0, (_UV_B5F91807_Out_0.xy), _Multiply_B26DE032_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_8D1BC883_Out_2;
                Unity_Multiply_half((_Divide_654AFB32_Out_2.xx), _Multiply_B26DE032_Out_2, _Multiply_8D1BC883_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_7772C3BA_Out_2;
                Unity_Add_half2(_Multiply_85DC5862_Out_2, _Multiply_8D1BC883_Out_2, _Add_7772C3BA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_91308B7C_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_7772C3BA_Out_2);
                _SampleTexture2D_91308B7C_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_91308B7C_RGBA_0);
                half _SampleTexture2D_91308B7C_R_4 = _SampleTexture2D_91308B7C_RGBA_0.r;
                half _SampleTexture2D_91308B7C_G_5 = _SampleTexture2D_91308B7C_RGBA_0.g;
                half _SampleTexture2D_91308B7C_B_6 = _SampleTexture2D_91308B7C_RGBA_0.b;
                half _SampleTexture2D_91308B7C_A_7 = _SampleTexture2D_91308B7C_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_BE91B4F6_Out_0 = _SlowNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_528ACD86_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_91308B7C_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_528ACD86_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_31890938_Out_2;
                Unity_Add_half(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Fraction_F03C9359_Out_1;
                Unity_Fraction_half(_Add_31890938_Out_2, _Fraction_F03C9359_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_FE081078_Out_2;
                Unity_Multiply_half(_Branch_FA6538E6_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_FE081078_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_C1F18389_Out_2;
                Unity_Add_half2(_Multiply_8D1BC883_Out_2, _Multiply_FE081078_Out_2, _Add_C1F18389_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_4508A259_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_C1F18389_Out_2);
                _SampleTexture2D_4508A259_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_4508A259_RGBA_0);
                half _SampleTexture2D_4508A259_R_4 = _SampleTexture2D_4508A259_RGBA_0.r;
                half _SampleTexture2D_4508A259_G_5 = _SampleTexture2D_4508A259_RGBA_0.g;
                half _SampleTexture2D_4508A259_B_6 = _SampleTexture2D_4508A259_RGBA_0.b;
                half _SampleTexture2D_4508A259_A_7 = _SampleTexture2D_4508A259_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_3BD81F5D_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_4508A259_RGBA_0.xyz), _Property_BE91B4F6_Out_0, _NormalStrength_3BD81F5D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_9431F443_Out_2;
                Unity_Add_half(_Fraction_7B9D3CF1_Out_1, -0.5, _Add_9431F443_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_483E3720_Out_2;
                Unity_Multiply_half(_Add_9431F443_Out_2, 2, _Multiply_483E3720_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Absolute_6685A82A_Out_1;
                Unity_Absolute_half(_Multiply_483E3720_Out_2, _Absolute_6685A82A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_356E067F_Out_3;
                Unity_Lerp_half3(_NormalStrength_528ACD86_Out_2, _NormalStrength_3BD81F5D_Out_2, (_Absolute_6685A82A_Out_1.xxx), _Lerp_356E067F_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_F5E0A69B_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_2DC0B257_Out_0 = _Detail1MainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_6E5EFE29_Out_0 = _Detail1Tiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_7748686D_Out_2;
                Unity_Multiply_half(_Property_2DC0B257_Out_0, _Property_6E5EFE29_Out_0, _Multiply_7748686D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_3FC112BC_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_AF306880_Out_2;
                Unity_Multiply_half(_Multiply_7748686D_Out_2, (_UV_3FC112BC_Out_0.xy), _Multiply_AF306880_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_B1FC6FBE_R_1 = _Multiply_AF306880_Out_2[0];
                half _Split_B1FC6FBE_G_2 = _Multiply_AF306880_Out_2[1];
                half _Split_B1FC6FBE_B_3 = 0;
                half _Split_B1FC6FBE_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_AD94E758_Out_0 = half2(_Split_B1FC6FBE_G_2, _Split_B1FC6FBE_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_65700BCC_Out_3;
                Unity_Branch_half2(_Property_F5E0A69B_Out_0, _Multiply_AF306880_Out_2, _Vector2_AD94E758_Out_0, _Branch_65700BCC_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_F1F3D035_Out_0 = _Detail1FlowUVRefreshSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A19D7537_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_F1F3D035_Out_0, _Multiply_A19D7537_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_28E3F138_Out_2;
                Unity_Add_half(_Multiply_A19D7537_Out_2, 1, _Add_28E3F138_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_D2DC6DD9_Out_1;
                Unity_Fraction_half(_Add_28E3F138_Out_2, _Fraction_D2DC6DD9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_5F61A5DA_Out_2;
                Unity_Multiply_half(_Branch_65700BCC_Out_3, (_Fraction_D2DC6DD9_Out_1.xx), _Multiply_5F61A5DA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_5D47C22C_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_4C511BD_Out_2;
                Unity_Divide_half(1, _Property_5D47C22C_Out_0, _Divide_4C511BD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_4B625890_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_A6640011_Out_2;
                Unity_Multiply_half(_Property_6E5EFE29_Out_0, (_UV_4B625890_Out_0.xy), _Multiply_A6640011_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_9324F9E4_Out_2;
                Unity_Multiply_half((_Divide_4C511BD_Out_2.xx), _Multiply_A6640011_Out_2, _Multiply_9324F9E4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_8A8E7455_Out_2;
                Unity_Add_half2(_Multiply_5F61A5DA_Out_2, _Multiply_9324F9E4_Out_2, _Add_8A8E7455_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_31496932_RGBA_0 = SAMPLE_TEXTURE2D(_DetailNormal, sampler_DetailNormal, _Add_8A8E7455_Out_2);
                _SampleTexture2D_31496932_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_31496932_RGBA_0);
                half _SampleTexture2D_31496932_R_4 = _SampleTexture2D_31496932_RGBA_0.r;
                half _SampleTexture2D_31496932_G_5 = _SampleTexture2D_31496932_RGBA_0.g;
                half _SampleTexture2D_31496932_B_6 = _SampleTexture2D_31496932_RGBA_0.b;
                half _SampleTexture2D_31496932_A_7 = _SampleTexture2D_31496932_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_5566E68B_Out_0 = _DetailNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_49B5F443_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_31496932_RGBA_0.xyz), _Property_5566E68B_Out_0, _NormalStrength_49B5F443_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_CBBBA061_Out_2;
                Unity_Add_half(_Multiply_A19D7537_Out_2, 0.5, _Add_CBBBA061_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_37B97A80_Out_1;
                Unity_Fraction_half(_Add_CBBBA061_Out_2, _Fraction_37B97A80_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_D8C05DAF_Out_2;
                Unity_Multiply_half(_Branch_65700BCC_Out_3, (_Fraction_37B97A80_Out_1.xx), _Multiply_D8C05DAF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_F35A6507_Out_2;
                Unity_Add_half2(_Multiply_9324F9E4_Out_2, _Multiply_D8C05DAF_Out_2, _Add_F35A6507_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_BEDCCB97_RGBA_0 = SAMPLE_TEXTURE2D(_DetailNormal, sampler_DetailNormal, _Add_F35A6507_Out_2);
                _SampleTexture2D_BEDCCB97_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_BEDCCB97_RGBA_0);
                half _SampleTexture2D_BEDCCB97_R_4 = _SampleTexture2D_BEDCCB97_RGBA_0.r;
                half _SampleTexture2D_BEDCCB97_G_5 = _SampleTexture2D_BEDCCB97_RGBA_0.g;
                half _SampleTexture2D_BEDCCB97_B_6 = _SampleTexture2D_BEDCCB97_RGBA_0.b;
                half _SampleTexture2D_BEDCCB97_A_7 = _SampleTexture2D_BEDCCB97_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_C4CCB54D_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_BEDCCB97_RGBA_0.xyz), _Property_5566E68B_Out_0, _NormalStrength_C4CCB54D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_BC933749_Out_2;
                Unity_Add_half(_Fraction_D2DC6DD9_Out_1, -0.5, _Add_BC933749_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_DF41C813_Out_2;
                Unity_Multiply_half(_Add_BC933749_Out_2, 2, _Multiply_DF41C813_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_476B42D9_Out_1;
                Unity_Absolute_half(_Multiply_DF41C813_Out_2, _Absolute_476B42D9_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_14477A5_Out_3;
                Unity_Lerp_half3(_NormalStrength_49B5F443_Out_2, _NormalStrength_C4CCB54D_Out_2, (_Absolute_476B42D9_Out_1.xxx), _Lerp_14477A5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_B8ACE3F1_RGBA_0 = SAMPLE_TEXTURE2D(_DetailAlbedo, sampler_DetailAlbedo, _Add_8A8E7455_Out_2);
                half _SampleTexture2D_B8ACE3F1_R_4 = _SampleTexture2D_B8ACE3F1_RGBA_0.r;
                half _SampleTexture2D_B8ACE3F1_G_5 = _SampleTexture2D_B8ACE3F1_RGBA_0.g;
                half _SampleTexture2D_B8ACE3F1_B_6 = _SampleTexture2D_B8ACE3F1_RGBA_0.b;
                half _SampleTexture2D_B8ACE3F1_A_7 = _SampleTexture2D_B8ACE3F1_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_A1621BBD_RGBA_0 = SAMPLE_TEXTURE2D(_DetailAlbedo, sampler_DetailAlbedo, _Add_F35A6507_Out_2);
                half _SampleTexture2D_A1621BBD_R_4 = _SampleTexture2D_A1621BBD_RGBA_0.r;
                half _SampleTexture2D_A1621BBD_G_5 = _SampleTexture2D_A1621BBD_RGBA_0.g;
                half _SampleTexture2D_A1621BBD_B_6 = _SampleTexture2D_A1621BBD_RGBA_0.b;
                half _SampleTexture2D_A1621BBD_A_7 = _SampleTexture2D_A1621BBD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Lerp_11CAC5B2_Out_3;
                Unity_Lerp_half4(_SampleTexture2D_B8ACE3F1_RGBA_0, _SampleTexture2D_A1621BBD_RGBA_0, (_Absolute_476B42D9_Out_1.xxxx), _Lerp_11CAC5B2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_2099A5DB_R_1 = _Lerp_11CAC5B2_Out_3[0];
                half _Split_2099A5DB_G_2 = _Lerp_11CAC5B2_Out_3[1];
                half _Split_2099A5DB_B_3 = _Lerp_11CAC5B2_Out_3[2];
                half _Split_2099A5DB_A_4 = _Lerp_11CAC5B2_Out_3[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_D4F6F844_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_A4A55C8D_Out_0 = _NoiseTiling1;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_6D76AFA6_Out_2;
                Unity_Multiply_half(_Property_2DC0B257_Out_0, _Property_A4A55C8D_Out_0, _Multiply_6D76AFA6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_F6117BE8_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_8B060916_Out_2;
                Unity_Multiply_half(_Multiply_6D76AFA6_Out_2, (_UV_F6117BE8_Out_0.xy), _Multiply_8B060916_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_A4B34BC7_R_1 = _Multiply_8B060916_Out_2[0];
                half _Split_A4B34BC7_G_2 = _Multiply_8B060916_Out_2[1];
                half _Split_A4B34BC7_B_3 = 0;
                half _Split_A4B34BC7_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_680633BC_Out_0 = half2(_Split_A4B34BC7_G_2, _Split_A4B34BC7_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_35279751_Out_3;
                Unity_Branch_half2(_Property_D4F6F844_Out_0, _Multiply_8B060916_Out_2, _Vector2_680633BC_Out_0, _Branch_35279751_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_DE608340_Out_2;
                Unity_Multiply_half(_Branch_35279751_Out_3, (_Fraction_D2DC6DD9_Out_1.xx), _Multiply_DE608340_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_56E8C0F2_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_8E603DE9_Out_2;
                Unity_Divide_half(1, _Property_56E8C0F2_Out_0, _Divide_8E603DE9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_D4E93B1E_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_42C43DD7_Out_2;
                Unity_Multiply_half(_Property_A4A55C8D_Out_0, (_UV_D4E93B1E_Out_0.xy), _Multiply_42C43DD7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_AE0BBFAF_Out_2;
                Unity_Multiply_half((_Divide_8E603DE9_Out_2.xx), _Multiply_42C43DD7_Out_2, _Multiply_AE0BBFAF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_56C76C69_Out_2;
                Unity_Add_half2(_Multiply_DE608340_Out_2, _Multiply_AE0BBFAF_Out_2, _Add_56C76C69_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_E54CB7DD_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_56C76C69_Out_2);
                half _SampleTexture2D_E54CB7DD_R_4 = _SampleTexture2D_E54CB7DD_RGBA_0.r;
                half _SampleTexture2D_E54CB7DD_G_5 = _SampleTexture2D_E54CB7DD_RGBA_0.g;
                half _SampleTexture2D_E54CB7DD_B_6 = _SampleTexture2D_E54CB7DD_RGBA_0.b;
                half _SampleTexture2D_E54CB7DD_A_7 = _SampleTexture2D_E54CB7DD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_A4082A4_Out_2;
                Unity_Multiply_half(_Branch_35279751_Out_3, (_Fraction_37B97A80_Out_1.xx), _Multiply_A4082A4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_F8B5ACD3_Out_2;
                Unity_Add_half2(_Multiply_A4082A4_Out_2, _Multiply_AE0BBFAF_Out_2, _Add_F8B5ACD3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_35B340E9_RGBA_0 = SAMPLE_TEXTURE2D(_Noise, sampler_Noise, _Add_F8B5ACD3_Out_2);
                half _SampleTexture2D_35B340E9_R_4 = _SampleTexture2D_35B340E9_RGBA_0.r;
                half _SampleTexture2D_35B340E9_G_5 = _SampleTexture2D_35B340E9_RGBA_0.g;
                half _SampleTexture2D_35B340E9_B_6 = _SampleTexture2D_35B340E9_RGBA_0.b;
                half _SampleTexture2D_35B340E9_A_7 = _SampleTexture2D_35B340E9_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_6FEEAEA0_Out_3;
                Unity_Lerp_half(_SampleTexture2D_E54CB7DD_G_5, _SampleTexture2D_35B340E9_G_5, _Absolute_476B42D9_Out_1, _Lerp_6FEEAEA0_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_50C70389_Out_1;
                Unity_Absolute_half(_Lerp_6FEEAEA0_Out_3, _Absolute_50C70389_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C1134212_Out_0 = _Detail1NoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_483D9151_Out_2;
                Unity_Power_half(_Absolute_50C70389_Out_1, _Property_C1134212_Out_0, _Power_483D9151_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_8B0E8794_Out_0 = _Detail1NoiseMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_E26A26BB_Out_2;
                Unity_Multiply_half(_Power_483D9151_Out_2, _Property_8B0E8794_Out_0, _Multiply_E26A26BB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_805729EB_Out_3;
                Unity_Clamp_half(_Multiply_E26A26BB_Out_2, 0, 1, _Clamp_805729EB_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_12157CAE_Out_2;
                Unity_Multiply_half(_Split_2099A5DB_A_4, _Clamp_805729EB_Out_3, _Multiply_12157CAE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_39572874_Out_3;
                Unity_Lerp_half(0, _Split_2099A5DB_A_4, _Multiply_12157CAE_Out_2, _Lerp_39572874_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_A40F2519_Out_3;
                Unity_Lerp_half3(_Lerp_356E067F_Out_3, _Lerp_14477A5_Out_3, (_Lerp_39572874_Out_3.xxx), _Lerp_A40F2519_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Property_FDE310C2_Out_0 = _CascadeMainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Property_87340130_Out_0 = _CascadeTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_F782F5C5_Out_2;
                Unity_Multiply_half(_Property_FDE310C2_Out_0, _Property_87340130_Out_0, _Multiply_F782F5C5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _UV_106B410B_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_A639E196_Out_2;
                Unity_Multiply_half(_Multiply_F782F5C5_Out_2, (_UV_106B410B_Out_0.xy), _Multiply_A639E196_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Split_D288CE58_R_1 = _Multiply_A639E196_Out_2[0];
                half _Split_D288CE58_G_2 = _Multiply_A639E196_Out_2[1];
                half _Split_D288CE58_B_3 = 0;
                half _Split_D288CE58_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Vector2_76C74260_Out_0 = half2(_Split_D288CE58_G_2, _Split_D288CE58_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Branch_C8E5B20A_Out_3;
                Unity_Branch_half2(_Property_707D3429_Out_0, _Multiply_A639E196_Out_2, _Vector2_76C74260_Out_0, _Branch_C8E5B20A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_375B806D_Out_0 = _CascadeFlowUVRefreshSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_5E54EFDE_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_375B806D_Out_0, _Multiply_5E54EFDE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_7EF542FE_Out_2;
                Unity_Add_half(_Multiply_5E54EFDE_Out_2, 1, _Add_7EF542FE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Fraction_5582502D_Out_1;
                Unity_Fraction_half(_Add_7EF542FE_Out_2, _Fraction_5582502D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_7CD24720_Out_2;
                Unity_Multiply_half(_Branch_C8E5B20A_Out_3, (_Fraction_5582502D_Out_1.xx), _Multiply_7CD24720_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_506342C2_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Divide_E07C316A_Out_2;
                Unity_Divide_half(1, _Property_506342C2_Out_0, _Divide_E07C316A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _UV_BEAE142D_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_9EC0B167_Out_2;
                Unity_Multiply_half(_Property_87340130_Out_0, (_UV_BEAE142D_Out_0.xy), _Multiply_9EC0B167_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_2C61B039_Out_2;
                Unity_Multiply_half((_Divide_E07C316A_Out_2.xx), _Multiply_9EC0B167_Out_2, _Multiply_2C61B039_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_188C8FD3_Out_2;
                Unity_Add_half2(_Multiply_7CD24720_Out_2, _Multiply_2C61B039_Out_2, _Add_188C8FD3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_AEBC8292_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_188C8FD3_Out_2);
                _SampleTexture2D_AEBC8292_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AEBC8292_RGBA_0);
                half _SampleTexture2D_AEBC8292_R_4 = _SampleTexture2D_AEBC8292_RGBA_0.r;
                half _SampleTexture2D_AEBC8292_G_5 = _SampleTexture2D_AEBC8292_RGBA_0.g;
                half _SampleTexture2D_AEBC8292_B_6 = _SampleTexture2D_AEBC8292_RGBA_0.b;
                half _SampleTexture2D_AEBC8292_A_7 = _SampleTexture2D_AEBC8292_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_8A81F679_Out_0 = _CascadeNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_94FC33DB_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_AEBC8292_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_94FC33DB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_42A4AEEC_Out_2;
                Unity_Add_half(_Multiply_5E54EFDE_Out_2, 0.5, _Add_42A4AEEC_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Fraction_3662A9DE_Out_1;
                Unity_Fraction_half(_Add_42A4AEEC_Out_2, _Fraction_3662A9DE_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_283B3646_Out_2;
                Unity_Multiply_half(_Branch_C8E5B20A_Out_3, (_Fraction_3662A9DE_Out_1.xx), _Multiply_283B3646_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_3E5AC13E_Out_2;
                Unity_Add_half2(_Multiply_2C61B039_Out_2, _Multiply_283B3646_Out_2, _Add_3E5AC13E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_9126225F_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_3E5AC13E_Out_2);
                _SampleTexture2D_9126225F_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_9126225F_RGBA_0);
                half _SampleTexture2D_9126225F_R_4 = _SampleTexture2D_9126225F_RGBA_0.r;
                half _SampleTexture2D_9126225F_G_5 = _SampleTexture2D_9126225F_RGBA_0.g;
                half _SampleTexture2D_9126225F_B_6 = _SampleTexture2D_9126225F_RGBA_0.b;
                half _SampleTexture2D_9126225F_A_7 = _SampleTexture2D_9126225F_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_337B983B_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_9126225F_RGBA_0.xyz), _Property_8A81F679_Out_0, _NormalStrength_337B983B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Add_1044203D_Out_2;
                Unity_Add_half(_Fraction_5582502D_Out_1, -0.5, _Add_1044203D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_24BCA4B0_Out_2;
                Unity_Multiply_half(_Add_1044203D_Out_2, 2, _Multiply_24BCA4B0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Absolute_D56AD49D_Out_1;
                Unity_Absolute_half(_Multiply_24BCA4B0_Out_2, _Absolute_D56AD49D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_5B898C96_Out_3;
                Unity_Lerp_half3(_NormalStrength_94FC33DB_Out_2, _NormalStrength_337B983B_Out_2, (_Absolute_D56AD49D_Out_1.xxx), _Lerp_5B898C96_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_C4B2F888_R_1 = IN.WorldSpaceNormal[0];
                half _Split_C4B2F888_G_2 = IN.WorldSpaceNormal[1];
                half _Split_C4B2F888_B_3 = IN.WorldSpaceNormal[2];
                half _Split_C4B2F888_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_F22E389A_Out_1;
                Unity_Absolute_half(_Split_C4B2F888_G_2, _Absolute_F22E389A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7DFFA574_Out_3;
                Unity_Clamp_half(_Absolute_F22E389A_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C24EE4D_Out_0 = _CascadeAngle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_3235AB33_Out_2;
                Unity_Divide_half(_Property_C24EE4D_Out_0, 45, _Divide_3235AB33_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_57DB513_Out_1;
                Unity_OneMinus_half(_Divide_3235AB33_Out_2, _OneMinus_57DB513_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_B782DE16_Out_2;
                Unity_Subtract_half(_Clamp_7DFFA574_Out_3, _OneMinus_57DB513_Out_1, _Subtract_B782DE16_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_9A0C7E5B_Out_3;
                Unity_Clamp_half(_Subtract_B782DE16_Out_2, 0, 2, _Clamp_9A0C7E5B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_BD74F0DD_Out_2;
                Unity_Divide_half(1, _Divide_3235AB33_Out_2, _Divide_BD74F0DD_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A56B78D9_Out_2;
                Unity_Multiply_half(_Clamp_9A0C7E5B_Out_3, _Divide_BD74F0DD_Out_2, _Multiply_A56B78D9_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_368478F5_Out_3;
                Unity_Clamp_half(_Multiply_A56B78D9_Out_2, 0, 1, _Clamp_368478F5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_E852EA22_Out_1;
                Unity_OneMinus_half(_Clamp_368478F5_Out_3, _OneMinus_E852EA22_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_438A66D_Out_1;
                Unity_Absolute_half(_OneMinus_E852EA22_Out_1, _Absolute_438A66D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_1F70A06C_Out_0 = _CascadeAngleFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_A86AE25B_Out_2;
                Unity_Power_half(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C9BB189_Out_3;
                Unity_Clamp_half(_Power_A86AE25B_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_BA2C71FD_Out_3;
                Unity_Lerp_half3(_Lerp_A40F2519_Out_3, _Lerp_5B898C96_Out_3, (_Clamp_C9BB189_Out_3.xxx), _Lerp_BA2C71FD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Normalize_C75C1ECE_Out_1;
                Unity_Normalize_half3(_Lerp_BA2C71FD_Out_3, _Normalize_C75C1ECE_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Split_6A7D546B_R_1 = _Normalize_C75C1ECE_Out_1[0];
                half _Split_6A7D546B_G_2 = _Normalize_C75C1ECE_Out_1[1];
                half _Split_6A7D546B_B_3 = _Normalize_C75C1ECE_Out_1[2];
                half _Split_6A7D546B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _Combine_E07639F2_RGBA_4;
                half3 _Combine_E07639F2_RGB_5;
                half2 _Combine_E07639F2_RG_6;
                Unity_Combine_half(_Split_6A7D546B_R_1, _Split_6A7D546B_G_2, 0, 0, _Combine_E07639F2_RGBA_4, _Combine_E07639F2_RGB_5, _Combine_E07639F2_RG_6);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_2F7622D8_Out_2;
                Unity_Multiply_half((_Property_FC343CDD_Out_0.xx), _Combine_E07639F2_RG_6, _Multiply_2F7622D8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Multiply_771FE10A_Out_2;
                Unity_Multiply_half((_ScreenPosition_590B4FA3_Out_0.xy), _Multiply_2F7622D8_Out_2, _Multiply_771FE10A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_996FBC6B_Out_2;
                Unity_Add_half2((_ScreenPosition_590B4FA3_Out_0.xy), _Multiply_771FE10A_Out_2, _Add_996FBC6B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _SceneColor_9C32DAB4_Out_1;
                Unity_SceneColor_half((half4(_Add_996FBC6B_Out_2, 0.0, 1.0)), _SceneColor_9C32DAB4_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_C4180B07_Out_0 = _DeepColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_B354F529_Out_0 = _ShalowColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _ScreenPosition_E4782AF8_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _SceneDepth_33F13F54_Out_1;
                Unity_SceneDepth_Linear01_half(_ScreenPosition_E4782AF8_Out_0, _SceneDepth_33F13F54_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_39A1673A_Out_2;
                Unity_Multiply_half(_SceneDepth_33F13F54_Out_1, _ProjectionParams.z, _Multiply_39A1673A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _ScreenPosition_35A77C4_Out_0 = IN.ScreenPosition;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_D36BBBDE_R_1 = _ScreenPosition_35A77C4_Out_0[0];
                half _Split_D36BBBDE_G_2 = _ScreenPosition_35A77C4_Out_0[1];
                half _Split_D36BBBDE_B_3 = _ScreenPosition_35A77C4_Out_0[2];
                half _Split_D36BBBDE_A_4 = _ScreenPosition_35A77C4_Out_0[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_331D19CE_Out_2;
                Unity_Subtract_half(_Multiply_39A1673A_Out_2, _Split_D36BBBDE_A_4, _Subtract_331D19CE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_46A80510_Out_0 = _ShalowFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_55CDC796_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_46A80510_Out_0, _Multiply_55CDC796_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_DA749514_Out_1;
                Unity_Absolute_half(_Multiply_55CDC796_Out_2, _Absolute_DA749514_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_4D681D1C_Out_0 = _ShalowFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_F7AB70ED_Out_2;
                Unity_Multiply_half(_Property_4D681D1C_Out_0, -1, _Multiply_F7AB70ED_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_3270BF29_Out_2;
                Unity_Power_half(_Absolute_DA749514_Out_1, _Multiply_F7AB70ED_Out_2, _Power_3270BF29_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_BB1D3A49_Out_0 = _CascadeTransparency;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_6F5E4CCF_Out_2;
                Unity_Multiply_half(_Property_BB1D3A49_Out_0, _Clamp_C9BB189_Out_3, _Multiply_6F5E4CCF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_FE3B891E_Out_3;
                Unity_Lerp_half(_Power_3270BF29_Out_2, 100, _Multiply_6F5E4CCF_Out_2, _Lerp_FE3B891E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Saturate_47EA3698_Out_1;
                Unity_Saturate_half(_Lerp_FE3B891E_Out_3, _Saturate_47EA3698_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_FA371D5_Out_3;
                Unity_Clamp_half(_Saturate_47EA3698_Out_1, 0, 1, _Clamp_FA371D5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Lerp_E98C0337_Out_3;
                Unity_Lerp_half4(_Property_C4180B07_Out_0, _Property_B354F529_Out_0, (_Clamp_FA371D5_Out_3.xxxx), _Lerp_E98C0337_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Multiply_689418CF_Out_2;
                Unity_Multiply_half((_Lerp_E98C0337_Out_3.xyz), _SceneColor_9C32DAB4_Out_1, _Multiply_689418CF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_8B8E643D_Out_0 = _WaterAlphaMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_BF88B5F8_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_8B8E643D_Out_0, _Multiply_BF88B5F8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_53D1B29C_Out_3;
                Unity_Clamp_half(_Multiply_BF88B5F8_Out_2, 0, 1, _Clamp_53D1B29C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_EC47432B_Out_0 = _WaterAlphaPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Power_83812DD0_Out_2;
                Unity_Power_half(_Clamp_53D1B29C_Out_3, _Property_EC47432B_Out_0, _Power_83812DD0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_A62DB403_Out_3;
                Unity_Clamp_half(_Power_83812DD0_Out_2, 0, 1, _Clamp_A62DB403_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_BDDADE6B_Out_3;
                Unity_Lerp_half3(_Multiply_689418CF_Out_2, (_Lerp_E98C0337_Out_3.xyz), (_Clamp_A62DB403_Out_3.xxx), _Lerp_BDDADE6B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_312FB549_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_43A46A4A_Out_3;
                Unity_Clamp_half(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Absolute_97151155_Out_1;
                Unity_Absolute_half(_Clamp_43A46A4A_Out_3, _Absolute_97151155_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_D7C9F55F_Out_0 = _CleanFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Power_AD928E85_Out_2;
                Unity_Power_half(_Absolute_97151155_Out_1, _Property_D7C9F55F_Out_0, _Power_AD928E85_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_9B4149BD_Out_3;
                Unity_Clamp_half(_Power_AD928E85_Out_2, 0, 1, _Clamp_9B4149BD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_3B329D09_Out_3;
                Unity_Lerp_half3(_SceneColor_9C32DAB4_Out_1, _Lerp_BDDADE6B_Out_3, (_Clamp_9B4149BD_Out_3.xxx), _Lerp_3B329D09_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_DISTORTION_ON)
                half3 _UseDistortion_F844CC61_Out_0 = _Lerp_3B329D09_Out_3;
                #else
                half3 _UseDistortion_F844CC61_Out_0 = (_Lerp_E98C0337_Out_3.xyz);
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_F19A2B5F_Out_0 = _DetailAlbedoColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_E85EE897_Out_2;
                Unity_Multiply_half(_Lerp_11CAC5B2_Out_3, _Property_F19A2B5F_Out_0, _Multiply_E85EE897_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_F64B17F5_Out_3;
                Unity_Lerp_half3(_UseDistortion_F844CC61_Out_0, (_Multiply_E85EE897_Out_2.xyz), (_Lerp_39572874_Out_3.xxx), _Lerp_F64B17F5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_4F98523C_Out_3;
                Unity_Lerp_half3(_Lerp_F64B17F5_Out_3, _UseDistortion_F844CC61_Out_0, (_Clamp_C9BB189_Out_3.xxx), _Lerp_4F98523C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_52B645B4_Out_0 = _EdgeFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_C4830DE7_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_52B645B4_Out_0, _Multiply_C4830DE7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_48A3004E_Out_3;
                Unity_Clamp_half(_Multiply_C4830DE7_Out_2, 0, 1, _Clamp_48A3004E_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_D3964C1C_Out_1;
                Unity_Absolute_half(_Clamp_48A3004E_Out_3, _Absolute_D3964C1C_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_69C29CD0_Out_0 = _EdgeFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_B73FC60F_Out_2;
                Unity_Power_half(_Absolute_D3964C1C_Out_1, _Property_69C29CD0_Out_0, _Power_B73FC60F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_2EDE896F_Out_3;
                Unity_Clamp_half(_Power_B73FC60F_Out_2, 0, 1, _Clamp_2EDE896F_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_42E433A0_R_1 = IN.VertexColor[0];
                half _Split_42E433A0_G_2 = IN.VertexColor[1];
                half _Split_42E433A0_B_3 = IN.VertexColor[2];
                half _Split_42E433A0_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_73E319C1_Out_2;
                Unity_Multiply_half(_Clamp_2EDE896F_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_6C82272C_Out_0 = _BackfaceAlpha;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_EE3AF77D_Out_2;
                Unity_Multiply_half(_Property_6C82272C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Branch_6D78BA69_Out_3;
                Unity_Branch_half(_IsFrontFace_29CBC83C_Out_0, _Multiply_73E319C1_Out_2, _Multiply_EE3AF77D_Out_2, _Branch_6D78BA69_Out_3);
                #endif
                surface.Albedo = _Lerp_4F98523C_Out_3;
                surface.Alpha = _Branch_6D78BA69_Out_3;
                surface.AlphaClipThreshold = 0;
                return surface;
            }
        
            // --------------------------------------------------
            // Structs and Packing
        
            // Generated Type: Attributes
            struct Attributes
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionOS : POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalOS : NORMAL;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 tangentOS : TANGENT;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv0 : TEXCOORD0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 uv3 : TEXCOORD3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color : COLOR;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : INSTANCEID_SEMANTIC;
                #endif
                #endif
            };
        
            // Generated Type: Varyings
            struct Varyings
            {
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 positionCS : SV_POSITION;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 positionWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float3 normalWS;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 texCoord3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                float4 color;
                #endif
                #if UNITY_ANY_INSTANCING_ENABLED
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #endif
            };
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // Generated Type: PackedVaryings
            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                #if UNITY_ANY_INSTANCING_ENABLED
                uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                float3 interp00 : TEXCOORD0;
                float3 interp01 : TEXCOORD1;
                float4 interp02 : TEXCOORD2;
                float4 interp03 : TEXCOORD3;
                float4 interp04 : TEXCOORD4;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };
            
            // Packed Type: Varyings
            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output = (PackedVaryings)0;
                output.positionCS = input.positionCS;
                output.interp00.xyz = input.positionWS;
                output.interp01.xyz = input.normalWS;
                output.interp02.xyzw = input.texCoord0;
                output.interp03.xyzw = input.texCoord3;
                output.interp04.xyzw = input.color;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            
            // Unpacked Type: Varyings
            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output = (Varyings)0;
                output.positionCS = input.positionCS;
                output.positionWS = input.interp00.xyz;
                output.normalWS = input.interp01.xyz;
                output.texCoord0 = input.interp02.xyzw;
                output.texCoord3 = input.interp03.xyzw;
                output.color = input.interp04.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
                output.instanceID = input.instanceID;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
                output.cullFace = input.cullFace;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
                output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
                output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                return output;
            }
            #endif
        
            // --------------------------------------------------
            // Build Graph Inputs
        
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 unnormalizedNormalWS = input.normalWS;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            const float renormFactor = 1.0 / length(unnormalizedNormalWS);
            #endif
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
            #endif
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.WorldSpacePosition =          input.positionWS;
            #endif
            
            
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv0 =                         input.texCoord0;
            #endif
            
            
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.uv3 =                         input.texCoord3;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.VertexColor =                 input.color;
            #endif
            
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
            #endif
            
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
            #else
            #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            #endif
            
            #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
            
                return output;
            }
            
        
            // --------------------------------------------------
            // Main
        
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
        
            ENDHLSL
        }
        
    }
    CustomEditor "UnityEditor.ShaderGraph.PBRMasterGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}
