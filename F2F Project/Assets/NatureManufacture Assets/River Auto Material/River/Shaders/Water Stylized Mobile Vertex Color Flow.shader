 Shader "NatureManufacture Shaders/Water/Water Stylized Mobile Vertex Color Flow"
{
    Properties
    {
        _GlobalTiling("Global Tiling", Range(0.001, 100)) = 1
        [ToggleUI]_UVVDirection1UDirection0("UV Direction - V(T) U(F)", Float) = 1
        _SlowWaterSpeed("Main Water Speed", Vector) = (0.3, 0.3, 0, 0)
        _SmallCascadeMainSpeed("Small Cascade Main Speed", Vector) = (1, 1, 0, 0)
        _BigCascadeMainSpeed("Big Cascade Main Speed", Vector) = (0.9, 0.9, 0, 0)
        _EdgeFalloffMultiply("Edge Falloff Multiply", Float) = 5.19
        _EdgeFalloffPower("Edge Falloff Power", Float) = 0.74
        _CleanFalloffMultiply("Clean Falloff Multiply", Float) = 1.29
        _CleanFalloffPower("Clean Falloff Power", Float) = 0.38
        _ShalowColor("Shalow Color", Color) = (0, 0.4811321, 0.4625075, 0)
        _ShalowFalloffMultiply("Shalow Falloff Multiply", Float) = 1.043
        _ShalowFalloffPower("Shalow Falloff Power", Float) = 3.9
        _DeepColor("Deep Color", Color) = (0.006274463, 0.306972, 0.4433962, 0)
        _WaterAlphaMultiply("Water Alpha Multiply", Float) = 0.66
        _WaterAlphaPower("Water Alpha Power", Float) = 1.39
        _OutlinePower("Outline Power", Range(0, 1)) = 0
        _OutlineFalloffBorder("Outline Falloff Border", Range(0, 200)) = 100
        _Outline_Color("Outline Color", Color) = (1, 1, 1, 0)
        _WaterSmoothness("Water Smoothness", Range(0, 1)) = 0.9
        _WaterSpecularClose("Water Specular Close", Range(0, 1)) = 0.9
        _WaterSpecularFar("Water Specular Far", Range(0, 1)) = 0.9
        _WaterSpecularThreshold("Water Specular Threshold", Range(0, 10)) = 0.39
        _Distortion("Distortion", Range(0, 1)) = 0.1
        _BackfaceAlpha("Backface Alpha", Range(0, 1)) = 0.85
        [NoScaleOffset]_SlowWaterNormal("Water Normal", 2D) = "bump" {}
        _SlowWaterTiling("Water Tiling", Vector) = (1, 1, 0, 0)
        _SlowNormalScale("Water Normal Scale", Float) = 0.3
        _FarNormalPower("Far Normal Power", Range(0, 1)) = 0.5
        _SmallCascadeAngle("Small Cascade Angle", Range(0.001, 90)) = 0.6
        _SmallCascadeAngleFalloff("Small Cascade Angle Falloff", Range(0, 80)) = 2
        _SmallCascadeTiling("Small Cascade Tiling", Vector) = (2, 2, 0, 0)
        _SmallCascadeNormalScale("Small Cascade Normal Scale", Float) = 0.5
        _SmallCascadeColor("Small Cascade Color", Vector) = (20, 20, 20, 0)
        _SmallCascadeFoamFalloff("Small Cascade Foam Falloff", Range(0, 10)) = 4.11
        _SmallCascadeSmoothness("Small Cascade Smoothness", Range(0, 1)) = 0
        _SmallCascadeSpecular("Small Cascade Specular", Range(0, 1)) = 0.8
        _BigCascadeAngle("Big Cascade Angle", Range(0.001, 90)) = 10.2
        _BigCascadeAngleFalloff("Big Cascade Angle Falloff", Range(0, 80)) = 2.3
        _BigCascadeNormalScale("Big Cascade Normal Scale", Float) = 0.6
        _BigCascadeTiling("Big Cascade Tiling", Vector) = (1, 1, 0, 0)
        _BigCascadeSmoothness("Big Cascade Smoothness", Range(0, 1)) = 0
        _BigCascadeSpecular("Big Cascade Specular", Range(0, 1)) = 0.84
        _BigCascadeColor("Big Cascade Color", Vector) = (20, 20, 20, 0)
        Big_Cascade_Foam_Falloff("Big Cascade Foam Falloff", Range(0, 10)) = 2.86
        _BigCascadeTransparency("Big Cascade Transparency", Range(0, 1)) = 0.005
        _SmallCascadeNoisePower("Small Cascade Noise Power", Range(0, 10)) = 8.4
        _BigCascadeNoisePower("Big Cascade Noise Power", Range(0, 10)) = 10
        _SmallCascadeNoiseMultiply("Small Cascade Noise Multiply", Range(0, 40)) = 28.7
        _BigCascadeNoiseMultiply("Big Cascade Noise Multiply", Range(0, 40)) = 20
        _FoamColor("Foam Color", Vector) = (20, 20, 20, 0)
        _FoamTiling("Foam Tiling", Vector) = (3, 3, 0, 0)
        _FoamSpeed("Foam Speed", Vector) = (0.3, 0.3, 0, 0)
        _FoamDepth("Foam Depth", Range(0, 10)) = 0.99
        _FoamFalloff("Foam Falloff", Range(-100, 0)) = -15.3
        _FoamSmoothness("Foam Smoothness", Range(0, 1)) = 0
        _FoamSpecular("Foam Specular", Range(0, 1)) = 0
        _NoiseTiling("Noise Tiling", Vector) = (2, 2, 0, 0)
        _NoiseSpeed("Noise Speed", Vector) = (3, 3, 0, 0)
        _AOPower("AO Power", Range(0, 1)) = 1
        _WaterFlowUVRefresSpeed("Water Flow UV Refresh Speed", Range(0, 1)) = 0.15
        _SmallCascadeFlowUVRefreshSpeed("Small Cascade Flow UV Refresh Speed", Range(0, 1)) = 0.4
        _BigCascadeFlowUVRefreshSpeed("Big Cascade Flow UV Refresh Speed", Range(0, 1)) = 0.6
        [NoScaleOffset]_CascadesTexturesRGFoamBNoiseA("Cascades Textures (RG) Foam (B) Noise (A)", 2D) = "white" {}
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
            half2 _SmallCascadeMainSpeed;
            half2 _BigCascadeMainSpeed;
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
            half _OutlinePower;
            half _OutlineFalloffBorder;
            half4 _Outline_Color;
            half _WaterSmoothness;
            half _WaterSpecularClose;
            half _WaterSpecularFar;
            half _WaterSpecularThreshold;
            half _Distortion;
            half _BackfaceAlpha;
            half2 _SlowWaterTiling;
            half _SlowNormalScale;
            half _FarNormalPower;
            half _SmallCascadeAngle;
            half _SmallCascadeAngleFalloff;
            half2 _SmallCascadeTiling;
            half _SmallCascadeNormalScale;
            half4 _SmallCascadeColor;
            half _SmallCascadeFoamFalloff;
            half _SmallCascadeSmoothness;
            half _SmallCascadeSpecular;
            half _BigCascadeAngle;
            half _BigCascadeAngleFalloff;
            half _BigCascadeNormalScale;
            half2 _BigCascadeTiling;
            half _BigCascadeSmoothness;
            half _BigCascadeSpecular;
            half4 _BigCascadeColor;
            half Big_Cascade_Foam_Falloff;
            half _BigCascadeTransparency;
            half _SmallCascadeNoisePower;
            half _BigCascadeNoisePower;
            half _SmallCascadeNoiseMultiply;
            half _BigCascadeNoiseMultiply;
            half4 _FoamColor;
            half2 _FoamTiling;
            half2 _FoamSpeed;
            half _FoamDepth;
            half _FoamFalloff;
            half _FoamSmoothness;
            half _FoamSpecular;
            half2 _NoiseTiling;
            half2 _NoiseSpeed;
            half _AOPower;
            half _WaterFlowUVRefresSpeed;
            half _SmallCascadeFlowUVRefreshSpeed;
            half _BigCascadeFlowUVRefreshSpeed;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); half4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_CascadesTexturesRGFoamBNoiseA); SAMPLER(sampler_CascadesTexturesRGFoamBNoiseA); half4 _CascadesTexturesRGFoamBNoiseA_TexelSize;
            SAMPLER(_SampleTexture2D_91308B7C_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_4508A259_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_AEBC8292_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9126225F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6ABE710E_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6FC3A421_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D6FF940D_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_80481243_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_B8ACE3F1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A1621BBD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D803AB07_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_198CC76A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_387AEB22_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9FEF114B_Sampler_3_Linear_Repeat);
        
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
            
            void Unity_Power_half(half A, half B, out half Out)
            {
                Out = pow(A, B);
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
            
            void Unity_Lerp_half(half A, half B, half T, out half Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Saturate_half(half In, out half Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Lerp_half4(half4 A, half4 B, half4 T, out half4 Out)
            {
                Out = lerp(A, B, T);
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
                half4 _ScreenPosition_1B148032_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
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
                half _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_87340130_Out_0 = _SmallCascadeTiling;
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
                half _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
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
                half _Property_8A81F679_Out_0 = _SmallCascadeNormalScale;
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
                half _Absolute_47687D69_Out_1;
                Unity_Absolute_half(_Split_C4B2F888_G_2, _Absolute_47687D69_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7DFFA574_Out_3;
                Unity_Clamp_half(_Absolute_47687D69_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
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
                half _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_A86AE25B_Out_2;
                Unity_Power_half(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                half _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                half _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                half _Split_7AAAB3D7_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_A4D565CD_Out_1;
                Unity_Absolute_half(_Split_7AAAB3D7_G_2, _Absolute_A4D565CD_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_half(_Absolute_A4D565CD_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_EAB4CFE5_Out_2;
                Unity_Divide_half(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_half(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_half(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_F34F3E95_Out_3;
                Unity_Clamp_half(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_2BCCE84_Out_2;
                Unity_Divide_half(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_half(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C5CAE82_Out_3;
                Unity_Clamp_half(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_half(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_19F078F3_Out_1;
                Unity_Absolute_half(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_8825055A_Out_2;
                Unity_Power_half(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_half(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_half(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C9BB189_Out_3;
                Unity_Clamp_half(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_BA2C71FD_Out_3;
                Unity_Lerp_half3(_Lerp_356E067F_Out_3, _Lerp_5B898C96_Out_3, (_Clamp_C9BB189_Out_3.xxx), _Lerp_BA2C71FD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_half(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_C884DDDE_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_half(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                half _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                half _Split_9358BE5B_B_3 = 0;
                half _Split_9358BE5B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_992266D4_Out_0 = half2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_DD741EC2_Out_3;
                Unity_Branch_half2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_B7675A94_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_B3DB86EF_Out_2;
                Unity_Add_half(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_half(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_half(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_DAA63F9C_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_4B6448D6_Out_2;
                Unity_Divide_half(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_2E4D7348_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_half(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_half((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_D29A7CEF_Out_2;
                Unity_Add_half2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_D29A7CEF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_6ABE710E_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_D29A7CEF_Out_2);
                _SampleTexture2D_6ABE710E_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6ABE710E_RGBA_0);
                half _SampleTexture2D_6ABE710E_R_4 = _SampleTexture2D_6ABE710E_RGBA_0.r;
                half _SampleTexture2D_6ABE710E_G_5 = _SampleTexture2D_6ABE710E_RGBA_0.g;
                half _SampleTexture2D_6ABE710E_B_6 = _SampleTexture2D_6ABE710E_RGBA_0.b;
                half _SampleTexture2D_6ABE710E_A_7 = _SampleTexture2D_6ABE710E_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_944CEF1C_Out_0 = _BigCascadeNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _NormalStrength_8AA324A2_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_6ABE710E_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8AA324A2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_DD0F4500_Out_2;
                Unity_Add_half(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_641D15D3_Out_1;
                Unity_Fraction_half(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_half(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_47CB0CEA_Out_2;
                Unity_Add_half2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_47CB0CEA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_6FC3A421_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_47CB0CEA_Out_2);
                _SampleTexture2D_6FC3A421_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6FC3A421_RGBA_0);
                half _SampleTexture2D_6FC3A421_R_4 = _SampleTexture2D_6FC3A421_RGBA_0.r;
                half _SampleTexture2D_6FC3A421_G_5 = _SampleTexture2D_6FC3A421_RGBA_0.g;
                half _SampleTexture2D_6FC3A421_B_6 = _SampleTexture2D_6FC3A421_RGBA_0.b;
                half _SampleTexture2D_6FC3A421_A_7 = _SampleTexture2D_6FC3A421_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _NormalStrength_8264A1B8_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_6FC3A421_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8264A1B8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_E6ED65B6_Out_2;
                Unity_Add_half(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_E9A08C0_Out_2;
                Unity_Multiply_half(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_half(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_F884F066_Out_3;
                Unity_Lerp_half3(_NormalStrength_8AA324A2_Out_2, _NormalStrength_8264A1B8_Out_2, (_Absolute_19D4C5A5_Out_1.xxx), _Lerp_F884F066_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_C8A32E85_Out_3;
                Unity_Lerp_half3(_Lerp_BA2C71FD_Out_3, _Lerp_F884F066_Out_3, (_Clamp_C3D0E6D0_Out_3.xxx), _Lerp_C8A32E85_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Normalize_17DCA406_Out_1;
                Unity_Normalize_half3(_Lerp_C8A32E85_Out_3, _Normalize_17DCA406_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Split_6A7D546B_R_1 = _Normalize_17DCA406_Out_1[0];
                half _Split_6A7D546B_G_2 = _Normalize_17DCA406_Out_1[1];
                half _Split_6A7D546B_B_3 = _Normalize_17DCA406_Out_1[2];
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
                half2 _Multiply_9F154179_Out_2;
                Unity_Multiply_half((_ScreenPosition_1B148032_Out_0.xy), _Multiply_2F7622D8_Out_2, _Multiply_9F154179_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_FCAE1710_Out_2;
                Unity_Add_half2((_ScreenPosition_1B148032_Out_0.xy), _Multiply_9F154179_Out_2, _Add_FCAE1710_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _SceneColor_E03F9940_Out_1;
                Unity_SceneColor_half((half4(_Add_FCAE1710_Out_2, 0.0, 1.0)), _SceneColor_E03F9940_Out_1);
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
                half _Property_BB1D3A49_Out_0 = _BigCascadeTransparency;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_6F5E4CCF_Out_2;
                Unity_Multiply_half(_Property_BB1D3A49_Out_0, _Clamp_C3D0E6D0_Out_3, _Multiply_6F5E4CCF_Out_2);
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
                half3 _Multiply_D633B72E_Out_2;
                Unity_Multiply_half((_Lerp_E98C0337_Out_3.xyz), _SceneColor_E03F9940_Out_1, _Multiply_D633B72E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_2DF52B0F_Out_0 = _WaterAlphaMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_D96AFE24_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_2DF52B0F_Out_0, _Multiply_D96AFE24_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_2E6740E7_Out_3;
                Unity_Clamp_half(_Multiply_D96AFE24_Out_2, 0, 1, _Clamp_2E6740E7_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_AD172459_Out_0 = _WaterAlphaPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Power_754E3B26_Out_2;
                Unity_Power_half(_Clamp_2E6740E7_Out_3, _Property_AD172459_Out_0, _Power_754E3B26_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_A1957B81_Out_3;
                Unity_Clamp_half(_Power_754E3B26_Out_2, 0, 1, _Clamp_A1957B81_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_E9A0ECDE_Out_3;
                Unity_Lerp_half3(_Multiply_D633B72E_Out_2, (_Lerp_E98C0337_Out_3.xyz), (_Clamp_A1957B81_Out_3.xxx), _Lerp_E9A0ECDE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_312FB549_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_43A46A4A_Out_3;
                Unity_Clamp_half(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
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
                half3 _Lerp_801DA607_Out_3;
                Unity_Lerp_half3(_SceneColor_E03F9940_Out_1, _Lerp_E9A0ECDE_Out_3, (_Clamp_9B4149BD_Out_3.xxx), _Lerp_801DA607_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_DISTORTION_ON)
                half3 _UseDistortion_B8368C60_Out_0 = _Lerp_801DA607_Out_3;
                #else
                half3 _UseDistortion_B8368C60_Out_0 = (_Lerp_E98C0337_Out_3.xyz);
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_13996939_Out_0 = _FoamColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_6A3E12E9_Out_0 = _FoamDepth;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_D65144A5_Out_2;
                Unity_Add_half(_Subtract_331D19CE_Out_2, _Property_6A3E12E9_Out_0, _Add_D65144A5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_236EA369_Out_1;
                Unity_Absolute_half(_Add_D65144A5_Out_2, _Absolute_236EA369_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_5092872F_Out_0 = _FoamFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_C278752C_Out_2;
                Unity_Power_half(_Absolute_236EA369_Out_1, _Property_5092872F_Out_0, _Power_C278752C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Saturate_F768EEA6_Out_1;
                Unity_Saturate_half(_Power_C278752C_Out_2, _Saturate_F768EEA6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_A8CF8708_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_25764F01_Out_0 = _FoamSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_3E47978_Out_0 = _FoamTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_DE80E1D6_Out_2;
                Unity_Multiply_half(_Property_25764F01_Out_0, _Property_3E47978_Out_0, _Multiply_DE80E1D6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_E1385FB5_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_3C9DE3D3_Out_2;
                Unity_Multiply_half(_Multiply_DE80E1D6_Out_2, (_UV_E1385FB5_Out_0.xy), _Multiply_3C9DE3D3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_90264A5B_R_1 = _Multiply_3C9DE3D3_Out_2[0];
                half _Split_90264A5B_G_2 = _Multiply_3C9DE3D3_Out_2[1];
                half _Split_90264A5B_B_3 = 0;
                half _Split_90264A5B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_8C003284_Out_0 = half2(_Split_90264A5B_G_2, _Split_90264A5B_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_81C13B1A_Out_3;
                Unity_Branch_half2(_Property_A8CF8708_Out_0, _Multiply_3C9DE3D3_Out_2, _Vector2_8C003284_Out_0, _Branch_81C13B1A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_F37F0047_Out_2;
                Unity_Multiply_half(_Branch_81C13B1A_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_F37F0047_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_70842CE7_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_D13271E5_Out_2;
                Unity_Divide_half(1, _Property_70842CE7_Out_0, _Divide_D13271E5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_E210B498_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_38B9004E_Out_2;
                Unity_Multiply_half(_Property_3E47978_Out_0, (_UV_E210B498_Out_0.xy), _Multiply_38B9004E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_FED7B7C8_Out_2;
                Unity_Multiply_half((_Divide_D13271E5_Out_2.xx), _Multiply_38B9004E_Out_2, _Multiply_FED7B7C8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_F1148D00_Out_2;
                Unity_Add_half2(_Multiply_F37F0047_Out_2, _Multiply_FED7B7C8_Out_2, _Add_F1148D00_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_D6FF940D_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_F1148D00_Out_2);
                half _SampleTexture2D_D6FF940D_R_4 = _SampleTexture2D_D6FF940D_RGBA_0.r;
                half _SampleTexture2D_D6FF940D_G_5 = _SampleTexture2D_D6FF940D_RGBA_0.g;
                half _SampleTexture2D_D6FF940D_B_6 = _SampleTexture2D_D6FF940D_RGBA_0.b;
                half _SampleTexture2D_D6FF940D_A_7 = _SampleTexture2D_D6FF940D_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_3FB3476F_Out_2;
                Unity_Multiply_half(_Branch_81C13B1A_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_3FB3476F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_7633CAE7_Out_2;
                Unity_Add_half2(_Multiply_FED7B7C8_Out_2, _Multiply_3FB3476F_Out_2, _Add_7633CAE7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_80481243_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_7633CAE7_Out_2);
                half _SampleTexture2D_80481243_R_4 = _SampleTexture2D_80481243_RGBA_0.r;
                half _SampleTexture2D_80481243_G_5 = _SampleTexture2D_80481243_RGBA_0.g;
                half _SampleTexture2D_80481243_B_6 = _SampleTexture2D_80481243_RGBA_0.b;
                half _SampleTexture2D_80481243_A_7 = _SampleTexture2D_80481243_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_408AE005_Out_3;
                Unity_Lerp_half(_SampleTexture2D_D6FF940D_B_6, _SampleTexture2D_80481243_B_6, _Absolute_6685A82A_Out_1, _Lerp_408AE005_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_CE5D1661_Out_2;
                Unity_Multiply_half(_Saturate_F768EEA6_Out_1, _Lerp_408AE005_Out_3, _Multiply_CE5D1661_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_25030EB5_Out_3;
                Unity_Lerp_half(_Multiply_CE5D1661_Out_2, 0, _Clamp_C3D0E6D0_Out_3, _Lerp_25030EB5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_CDFBCC47_Out_3;
                Unity_Clamp_half(_Lerp_25030EB5_Out_3, 0, 1, _Clamp_CDFBCC47_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_6998DF58_Out_3;
                Unity_Lerp_half3(_UseDistortion_B8368C60_Out_0, (_Property_13996939_Out_0.xyz), (_Clamp_CDFBCC47_Out_3.xxx), _Lerp_6998DF58_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_B8ACE3F1_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_188C8FD3_Out_2);
                half _SampleTexture2D_B8ACE3F1_R_4 = _SampleTexture2D_B8ACE3F1_RGBA_0.r;
                half _SampleTexture2D_B8ACE3F1_G_5 = _SampleTexture2D_B8ACE3F1_RGBA_0.g;
                half _SampleTexture2D_B8ACE3F1_B_6 = _SampleTexture2D_B8ACE3F1_RGBA_0.b;
                half _SampleTexture2D_B8ACE3F1_A_7 = _SampleTexture2D_B8ACE3F1_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_A1621BBD_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_3E5AC13E_Out_2);
                half _SampleTexture2D_A1621BBD_R_4 = _SampleTexture2D_A1621BBD_RGBA_0.r;
                half _SampleTexture2D_A1621BBD_G_5 = _SampleTexture2D_A1621BBD_RGBA_0.g;
                half _SampleTexture2D_A1621BBD_B_6 = _SampleTexture2D_A1621BBD_RGBA_0.b;
                half _SampleTexture2D_A1621BBD_A_7 = _SampleTexture2D_A1621BBD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_3B18082_Out_3;
                Unity_Lerp_half(_SampleTexture2D_B8ACE3F1_R_4, _SampleTexture2D_A1621BBD_R_4, _Absolute_D56AD49D_Out_1, _Lerp_3B18082_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_50DF1CAB_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_A4A55C8D_Out_0 = _NoiseSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_986C2E1B_Out_0 = _NoiseTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_778A9500_Out_2;
                Unity_Multiply_half(_Property_A4A55C8D_Out_0, _Property_986C2E1B_Out_0, _Multiply_778A9500_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_4A477E20_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_E53528CB_Out_2;
                Unity_Multiply_half(_Multiply_778A9500_Out_2, (_UV_4A477E20_Out_0.xy), _Multiply_E53528CB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_A3C5F2B5_R_1 = _Multiply_E53528CB_Out_2[0];
                half _Split_A3C5F2B5_G_2 = _Multiply_E53528CB_Out_2[1];
                half _Split_A3C5F2B5_B_3 = 0;
                half _Split_A3C5F2B5_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_6D67D273_Out_0 = half2(_Split_A3C5F2B5_G_2, _Split_A3C5F2B5_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_EDA2C0E3_Out_3;
                Unity_Branch_half2(_Property_50DF1CAB_Out_0, _Multiply_E53528CB_Out_2, _Vector2_6D67D273_Out_0, _Branch_EDA2C0E3_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_12A5FB28_Out_1;
                Unity_Fraction_half(_Add_7EF542FE_Out_2, _Fraction_12A5FB28_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_39A54641_Out_2;
                Unity_Multiply_half(_Branch_EDA2C0E3_Out_3, (_Fraction_12A5FB28_Out_1.xx), _Multiply_39A54641_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_82193ED3_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_411EED11_Out_2;
                Unity_Divide_half(1, _Property_82193ED3_Out_0, _Divide_411EED11_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_F9D3A262_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_9C31F9C2_Out_2;
                Unity_Multiply_half(_Property_986C2E1B_Out_0, (_UV_F9D3A262_Out_0.xy), _Multiply_9C31F9C2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_E6E2F026_Out_2;
                Unity_Multiply_half((_Divide_411EED11_Out_2.xx), _Multiply_9C31F9C2_Out_2, _Multiply_E6E2F026_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_BADC8439_Out_2;
                Unity_Add_half2(_Multiply_39A54641_Out_2, _Multiply_E6E2F026_Out_2, _Add_BADC8439_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_D803AB07_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_BADC8439_Out_2);
                half _SampleTexture2D_D803AB07_R_4 = _SampleTexture2D_D803AB07_RGBA_0.r;
                half _SampleTexture2D_D803AB07_G_5 = _SampleTexture2D_D803AB07_RGBA_0.g;
                half _SampleTexture2D_D803AB07_B_6 = _SampleTexture2D_D803AB07_RGBA_0.b;
                half _SampleTexture2D_D803AB07_A_7 = _SampleTexture2D_D803AB07_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_9E406053_Out_1;
                Unity_Fraction_half(_Add_42A4AEEC_Out_2, _Fraction_9E406053_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_EEA6AA5B_Out_2;
                Unity_Multiply_half(_Branch_EDA2C0E3_Out_3, (_Fraction_9E406053_Out_1.xx), _Multiply_EEA6AA5B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_9509D7CE_Out_2;
                Unity_Add_half2(_Multiply_E6E2F026_Out_2, _Multiply_EEA6AA5B_Out_2, _Add_9509D7CE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_198CC76A_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_9509D7CE_Out_2);
                half _SampleTexture2D_198CC76A_R_4 = _SampleTexture2D_198CC76A_RGBA_0.r;
                half _SampleTexture2D_198CC76A_G_5 = _SampleTexture2D_198CC76A_RGBA_0.g;
                half _SampleTexture2D_198CC76A_B_6 = _SampleTexture2D_198CC76A_RGBA_0.b;
                half _SampleTexture2D_198CC76A_A_7 = _SampleTexture2D_198CC76A_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_51CEF3BF_Out_3;
                Unity_Lerp_half(_SampleTexture2D_D803AB07_A_7, _SampleTexture2D_198CC76A_A_7, _Absolute_D56AD49D_Out_1, _Lerp_51CEF3BF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_38E6503D_Out_1;
                Unity_Absolute_half(_Lerp_51CEF3BF_Out_3, _Absolute_38E6503D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C1134212_Out_0 = _SmallCascadeNoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_483D9151_Out_2;
                Unity_Power_half(_Absolute_38E6503D_Out_1, _Property_C1134212_Out_0, _Power_483D9151_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_8B0E8794_Out_0 = _SmallCascadeNoiseMultiply;
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
                half _Lerp_39572874_Out_3;
                Unity_Lerp_half(0, _Lerp_3B18082_Out_3, _Clamp_805729EB_Out_3, _Lerp_39572874_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_997BA4E8_Out_0 = _SmallCascadeColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_E85EE897_Out_2;
                Unity_Multiply_half((_Lerp_39572874_Out_3.xxxx), _Property_997BA4E8_Out_0, _Multiply_E85EE897_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_5DF2B9D0_Out_1;
                Unity_Absolute_half(_Lerp_3B18082_Out_3, _Absolute_5DF2B9D0_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_97A26DCC_Out_0 = _SmallCascadeFoamFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_328AD5E3_Out_2;
                Unity_Power_half(_Absolute_5DF2B9D0_Out_1, _Property_97A26DCC_Out_0, _Power_328AD5E3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_33692D9C_Out_3;
                Unity_Clamp_half(_Power_328AD5E3_Out_2, 0, 1, _Clamp_33692D9C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_8877E3D4_Out_3;
                Unity_Lerp_half(0, _Clamp_33692D9C_Out_3, _Clamp_C9BB189_Out_3, _Lerp_8877E3D4_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_4F98523C_Out_3;
                Unity_Lerp_half3(_Lerp_6998DF58_Out_3, (_Multiply_E85EE897_Out_2.xyz), (_Lerp_8877E3D4_Out_3.xxx), _Lerp_4F98523C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_387AEB22_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_D29A7CEF_Out_2);
                half _SampleTexture2D_387AEB22_R_4 = _SampleTexture2D_387AEB22_RGBA_0.r;
                half _SampleTexture2D_387AEB22_G_5 = _SampleTexture2D_387AEB22_RGBA_0.g;
                half _SampleTexture2D_387AEB22_B_6 = _SampleTexture2D_387AEB22_RGBA_0.b;
                half _SampleTexture2D_387AEB22_A_7 = _SampleTexture2D_387AEB22_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_9FEF114B_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_47CB0CEA_Out_2);
                half _SampleTexture2D_9FEF114B_R_4 = _SampleTexture2D_9FEF114B_RGBA_0.r;
                half _SampleTexture2D_9FEF114B_G_5 = _SampleTexture2D_9FEF114B_RGBA_0.g;
                half _SampleTexture2D_9FEF114B_B_6 = _SampleTexture2D_9FEF114B_RGBA_0.b;
                half _SampleTexture2D_9FEF114B_A_7 = _SampleTexture2D_9FEF114B_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_8DF0FC6B_Out_3;
                Unity_Lerp_half(_SampleTexture2D_387AEB22_G_5, _SampleTexture2D_9FEF114B_G_5, _Absolute_19D4C5A5_Out_1, _Lerp_8DF0FC6B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_2D163AB3_Out_2;
                Unity_Multiply_half(0.5, _Lerp_8DF0FC6B_Out_3, _Multiply_2D163AB3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_5515474F_Out_0 = _BigCascadeNoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_E5773568_Out_2;
                Unity_Power_half(_Absolute_38E6503D_Out_1, _Property_5515474F_Out_0, _Power_E5773568_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_2C8FB0D9_Out_0 = _BigCascadeNoiseMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_9128FAF6_Out_2;
                Unity_Multiply_half(_Power_E5773568_Out_2, _Property_2C8FB0D9_Out_0, _Multiply_9128FAF6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_1E99CDDE_Out_3;
                Unity_Clamp_half(_Multiply_9128FAF6_Out_2, 0, 1, _Clamp_1E99CDDE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_50210667_Out_3;
                Unity_Lerp_half(_Multiply_2D163AB3_Out_2, _Lerp_8DF0FC6B_Out_3, _Clamp_1E99CDDE_Out_3, _Lerp_50210667_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_70B53B1D_Out_0 = _BigCascadeColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_630AB59_Out_2;
                Unity_Multiply_half((_Lerp_50210667_Out_3.xxxx), _Property_70B53B1D_Out_0, _Multiply_630AB59_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_E807A97_Out_1;
                Unity_Absolute_half(_Lerp_8DF0FC6B_Out_3, _Absolute_E807A97_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_97864BE9_Out_0 = Big_Cascade_Foam_Falloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_F37DBF08_Out_2;
                Unity_Power_half(_Absolute_E807A97_Out_1, _Property_97864BE9_Out_0, _Power_F37DBF08_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_142C06F9_Out_3;
                Unity_Clamp_half(_Power_F37DBF08_Out_2, 0, 1, _Clamp_142C06F9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_6316FED8_Out_3;
                Unity_Lerp_half(0, _Clamp_142C06F9_Out_3, _Clamp_C3D0E6D0_Out_3, _Lerp_6316FED8_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_96C773B7_Out_3;
                Unity_Lerp_half3(_Lerp_4F98523C_Out_3, (_Multiply_630AB59_Out_2.xyz), (_Lerp_6316FED8_Out_3.xxx), _Lerp_96C773B7_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_399CF5F0_Out_0 = _OutlinePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_F19BF3EF_Out_1;
                Unity_OneMinus_half(_Property_399CF5F0_Out_0, _OneMinus_F19BF3EF_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_53102B82_Out_2;
                Unity_Add_half(_Subtract_331D19CE_Out_2, _OneMinus_F19BF3EF_Out_1, _Add_53102B82_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_8CE6A8BB_Out_1;
                Unity_Absolute_half(_Add_53102B82_Out_2, _Absolute_8CE6A8BB_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_BCFC6E6B_Out_0 = _OutlineFalloffBorder;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_D4C2721A_Out_1;
                Unity_OneMinus_half(_Property_BCFC6E6B_Out_0, _OneMinus_D4C2721A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_DC867686_Out_2;
                Unity_Power_half(_Absolute_8CE6A8BB_Out_1, _OneMinus_D4C2721A_Out_1, _Power_DC867686_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_A6F1C350_Out_3;
                Unity_Clamp_half(_Power_DC867686_Out_2, 0, 1, _Clamp_A6F1C350_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_C59730BD_Out_0 = _Outline_Color;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_54E8D4E2_Out_2;
                Unity_Multiply_half((_Clamp_A6F1C350_Out_3.xxxx), _Property_C59730BD_Out_0, _Multiply_54E8D4E2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_42E433A0_R_1 = IN.VertexColor[0];
                half _Split_42E433A0_G_2 = IN.VertexColor[1];
                half _Split_42E433A0_B_3 = IN.VertexColor[2];
                half _Split_42E433A0_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_8996C25F_Out_2;
                Unity_Multiply_half(_Multiply_54E8D4E2_Out_2, (_Split_42E433A0_A_4.xxxx), _Multiply_8996C25F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_E60687FC_Out_0 = _WaterSpecularFar;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_3CA71885_Out_0 = _WaterSpecularClose;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_5D99FB53_Out_1;
                Unity_Absolute_half(_Clamp_FA371D5_Out_3, _Absolute_5D99FB53_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_DA074F44_Out_0 = _WaterSpecularThreshold;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_12CD8AA2_Out_2;
                Unity_Power_half(_Absolute_5D99FB53_Out_1, _Property_DA074F44_Out_0, _Power_12CD8AA2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_587F9C95_Out_3;
                Unity_Lerp_half(_Property_E60687FC_Out_0, _Property_3CA71885_Out_0, _Power_12CD8AA2_Out_2, _Lerp_587F9C95_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_F9333C36_Out_0 = _FoamSpecular;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_A255FC9C_Out_3;
                Unity_Lerp_half(_Lerp_587F9C95_Out_3, _Property_F9333C36_Out_0, _Clamp_CDFBCC47_Out_3, _Lerp_A255FC9C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_6BDB080B_Out_0 = _SmallCascadeSpecular;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_AEACE46_Out_3;
                Unity_Lerp_half(_Lerp_A255FC9C_Out_3, _Property_6BDB080B_Out_0, _Lerp_8877E3D4_Out_3, _Lerp_AEACE46_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_6E266398_Out_0 = _BigCascadeSpecular;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_F3DF7AB7_Out_3;
                Unity_Lerp_half(_Lerp_AEACE46_Out_3, _Property_6E266398_Out_0, _Lerp_6316FED8_Out_3, _Lerp_F3DF7AB7_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_EE79CD0D_Out_0 = _WaterSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_643E836D_Out_0 = _FoamSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_554E8BA3_Out_3;
                Unity_Lerp_half(_Property_EE79CD0D_Out_0, _Property_643E836D_Out_0, _Clamp_CDFBCC47_Out_3, _Lerp_554E8BA3_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_A47FA74D_Out_0 = _SmallCascadeSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_A0E087E1_Out_3;
                Unity_Lerp_half(_Lerp_554E8BA3_Out_3, _Property_A47FA74D_Out_0, _Lerp_8877E3D4_Out_3, _Lerp_A0E087E1_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_9C968D9C_Out_0 = _BigCascadeSmoothness;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_FA93E461_Out_3;
                Unity_Lerp_half(_Lerp_A0E087E1_Out_3, _Property_9C968D9C_Out_0, _Lerp_6316FED8_Out_3, _Lerp_FA93E461_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_A1F4E266_Out_0 = _AOPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_9FA23315_Out_0 = _EdgeFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A696A267_Out_2;
                Unity_Multiply_half(_Absolute_97151155_Out_1, _Property_9FA23315_Out_0, _Multiply_A696A267_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_43248266_Out_3;
                Unity_Clamp_half(_Multiply_A696A267_Out_2, 0, 1, _Clamp_43248266_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_E54EA794_Out_1;
                Unity_Absolute_half(_Clamp_43248266_Out_3, _Absolute_E54EA794_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_38A7BE1A_Out_0 = _EdgeFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_E32F038D_Out_2;
                Unity_Power_half(_Absolute_E54EA794_Out_1, _Property_38A7BE1A_Out_0, _Power_E32F038D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7650C035_Out_3;
                Unity_Clamp_half(_Power_E32F038D_Out_2, 0, 1, _Clamp_7650C035_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_73E319C1_Out_2;
                Unity_Multiply_half(_Clamp_7650C035_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
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
                surface.Albedo = _Lerp_96C773B7_Out_3;
                surface.Normal = _Lerp_C8A32E85_Out_3;
                surface.Emission = (_Multiply_8996C25F_Out_2.xyz);
                surface.Specular = (_Lerp_F3DF7AB7_Out_3.xxx);
                surface.Smoothness = _Lerp_FA93E461_Out_3;
                surface.Occlusion = _Property_A1F4E266_Out_0;
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
            half2 _SmallCascadeMainSpeed;
            half2 _BigCascadeMainSpeed;
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
            half _OutlinePower;
            half _OutlineFalloffBorder;
            half4 _Outline_Color;
            half _WaterSmoothness;
            half _WaterSpecularClose;
            half _WaterSpecularFar;
            half _WaterSpecularThreshold;
            half _Distortion;
            half _BackfaceAlpha;
            half2 _SlowWaterTiling;
            half _SlowNormalScale;
            half _FarNormalPower;
            half _SmallCascadeAngle;
            half _SmallCascadeAngleFalloff;
            half2 _SmallCascadeTiling;
            half _SmallCascadeNormalScale;
            half4 _SmallCascadeColor;
            half _SmallCascadeFoamFalloff;
            half _SmallCascadeSmoothness;
            half _SmallCascadeSpecular;
            half _BigCascadeAngle;
            half _BigCascadeAngleFalloff;
            half _BigCascadeNormalScale;
            half2 _BigCascadeTiling;
            half _BigCascadeSmoothness;
            half _BigCascadeSpecular;
            half4 _BigCascadeColor;
            half Big_Cascade_Foam_Falloff;
            half _BigCascadeTransparency;
            half _SmallCascadeNoisePower;
            half _BigCascadeNoisePower;
            half _SmallCascadeNoiseMultiply;
            half _BigCascadeNoiseMultiply;
            half4 _FoamColor;
            half2 _FoamTiling;
            half2 _FoamSpeed;
            half _FoamDepth;
            half _FoamFalloff;
            half _FoamSmoothness;
            half _FoamSpecular;
            half2 _NoiseTiling;
            half2 _NoiseSpeed;
            half _AOPower;
            half _WaterFlowUVRefresSpeed;
            half _SmallCascadeFlowUVRefreshSpeed;
            half _BigCascadeFlowUVRefreshSpeed;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); half4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_CascadesTexturesRGFoamBNoiseA); SAMPLER(sampler_CascadesTexturesRGFoamBNoiseA); half4 _CascadesTexturesRGFoamBNoiseA_TexelSize;
        
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
                half _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_312FB549_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_43A46A4A_Out_3;
                Unity_Clamp_half(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_97151155_Out_1;
                Unity_Absolute_half(_Clamp_43A46A4A_Out_3, _Absolute_97151155_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_9FA23315_Out_0 = _EdgeFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A696A267_Out_2;
                Unity_Multiply_half(_Absolute_97151155_Out_1, _Property_9FA23315_Out_0, _Multiply_A696A267_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_43248266_Out_3;
                Unity_Clamp_half(_Multiply_A696A267_Out_2, 0, 1, _Clamp_43248266_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_E54EA794_Out_1;
                Unity_Absolute_half(_Clamp_43248266_Out_3, _Absolute_E54EA794_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_38A7BE1A_Out_0 = _EdgeFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_E32F038D_Out_2;
                Unity_Power_half(_Absolute_E54EA794_Out_1, _Property_38A7BE1A_Out_0, _Power_E32F038D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7650C035_Out_3;
                Unity_Clamp_half(_Power_E32F038D_Out_2, 0, 1, _Clamp_7650C035_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_42E433A0_R_1 = IN.VertexColor[0];
                half _Split_42E433A0_G_2 = IN.VertexColor[1];
                half _Split_42E433A0_B_3 = IN.VertexColor[2];
                half _Split_42E433A0_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_73E319C1_Out_2;
                Unity_Multiply_half(_Clamp_7650C035_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
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
            half2 _SmallCascadeMainSpeed;
            half2 _BigCascadeMainSpeed;
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
            half _OutlinePower;
            half _OutlineFalloffBorder;
            half4 _Outline_Color;
            half _WaterSmoothness;
            half _WaterSpecularClose;
            half _WaterSpecularFar;
            half _WaterSpecularThreshold;
            half _Distortion;
            half _BackfaceAlpha;
            half2 _SlowWaterTiling;
            half _SlowNormalScale;
            half _FarNormalPower;
            half _SmallCascadeAngle;
            half _SmallCascadeAngleFalloff;
            half2 _SmallCascadeTiling;
            half _SmallCascadeNormalScale;
            half4 _SmallCascadeColor;
            half _SmallCascadeFoamFalloff;
            half _SmallCascadeSmoothness;
            half _SmallCascadeSpecular;
            half _BigCascadeAngle;
            half _BigCascadeAngleFalloff;
            half _BigCascadeNormalScale;
            half2 _BigCascadeTiling;
            half _BigCascadeSmoothness;
            half _BigCascadeSpecular;
            half4 _BigCascadeColor;
            half Big_Cascade_Foam_Falloff;
            half _BigCascadeTransparency;
            half _SmallCascadeNoisePower;
            half _BigCascadeNoisePower;
            half _SmallCascadeNoiseMultiply;
            half _BigCascadeNoiseMultiply;
            half4 _FoamColor;
            half2 _FoamTiling;
            half2 _FoamSpeed;
            half _FoamDepth;
            half _FoamFalloff;
            half _FoamSmoothness;
            half _FoamSpecular;
            half2 _NoiseTiling;
            half2 _NoiseSpeed;
            half _AOPower;
            half _WaterFlowUVRefresSpeed;
            half _SmallCascadeFlowUVRefreshSpeed;
            half _BigCascadeFlowUVRefreshSpeed;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); half4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_CascadesTexturesRGFoamBNoiseA); SAMPLER(sampler_CascadesTexturesRGFoamBNoiseA); half4 _CascadesTexturesRGFoamBNoiseA_TexelSize;
        
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
                half _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_312FB549_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_43A46A4A_Out_3;
                Unity_Clamp_half(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_97151155_Out_1;
                Unity_Absolute_half(_Clamp_43A46A4A_Out_3, _Absolute_97151155_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_9FA23315_Out_0 = _EdgeFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A696A267_Out_2;
                Unity_Multiply_half(_Absolute_97151155_Out_1, _Property_9FA23315_Out_0, _Multiply_A696A267_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_43248266_Out_3;
                Unity_Clamp_half(_Multiply_A696A267_Out_2, 0, 1, _Clamp_43248266_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_E54EA794_Out_1;
                Unity_Absolute_half(_Clamp_43248266_Out_3, _Absolute_E54EA794_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_38A7BE1A_Out_0 = _EdgeFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_E32F038D_Out_2;
                Unity_Power_half(_Absolute_E54EA794_Out_1, _Property_38A7BE1A_Out_0, _Power_E32F038D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7650C035_Out_3;
                Unity_Clamp_half(_Power_E32F038D_Out_2, 0, 1, _Clamp_7650C035_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_42E433A0_R_1 = IN.VertexColor[0];
                half _Split_42E433A0_G_2 = IN.VertexColor[1];
                half _Split_42E433A0_B_3 = IN.VertexColor[2];
                half _Split_42E433A0_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_73E319C1_Out_2;
                Unity_Multiply_half(_Clamp_7650C035_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
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
            half2 _SmallCascadeMainSpeed;
            half2 _BigCascadeMainSpeed;
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
            half _OutlinePower;
            half _OutlineFalloffBorder;
            half4 _Outline_Color;
            half _WaterSmoothness;
            half _WaterSpecularClose;
            half _WaterSpecularFar;
            half _WaterSpecularThreshold;
            half _Distortion;
            half _BackfaceAlpha;
            half2 _SlowWaterTiling;
            half _SlowNormalScale;
            half _FarNormalPower;
            half _SmallCascadeAngle;
            half _SmallCascadeAngleFalloff;
            half2 _SmallCascadeTiling;
            half _SmallCascadeNormalScale;
            half4 _SmallCascadeColor;
            half _SmallCascadeFoamFalloff;
            half _SmallCascadeSmoothness;
            half _SmallCascadeSpecular;
            half _BigCascadeAngle;
            half _BigCascadeAngleFalloff;
            half _BigCascadeNormalScale;
            half2 _BigCascadeTiling;
            half _BigCascadeSmoothness;
            half _BigCascadeSpecular;
            half4 _BigCascadeColor;
            half Big_Cascade_Foam_Falloff;
            half _BigCascadeTransparency;
            half _SmallCascadeNoisePower;
            half _BigCascadeNoisePower;
            half _SmallCascadeNoiseMultiply;
            half _BigCascadeNoiseMultiply;
            half4 _FoamColor;
            half2 _FoamTiling;
            half2 _FoamSpeed;
            half _FoamDepth;
            half _FoamFalloff;
            half _FoamSmoothness;
            half _FoamSpecular;
            half2 _NoiseTiling;
            half2 _NoiseSpeed;
            half _AOPower;
            half _WaterFlowUVRefresSpeed;
            half _SmallCascadeFlowUVRefreshSpeed;
            half _BigCascadeFlowUVRefreshSpeed;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); half4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_CascadesTexturesRGFoamBNoiseA); SAMPLER(sampler_CascadesTexturesRGFoamBNoiseA); half4 _CascadesTexturesRGFoamBNoiseA_TexelSize;
            SAMPLER(_SampleTexture2D_91308B7C_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_4508A259_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_AEBC8292_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9126225F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6ABE710E_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6FC3A421_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D6FF940D_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_80481243_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_B8ACE3F1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A1621BBD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D803AB07_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_198CC76A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_387AEB22_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9FEF114B_Sampler_3_Linear_Repeat);
        
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
            
            void Unity_Power_half(half A, half B, out half Out)
            {
                Out = pow(A, B);
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
            
            void Unity_Lerp_half(half A, half B, half T, out half Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Saturate_half(half In, out half Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Lerp_half4(half4 A, half4 B, half4 T, out half4 Out)
            {
                Out = lerp(A, B, T);
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
                half4 _ScreenPosition_1B148032_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
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
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_31890938_Out_2;
                Unity_Add_half(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
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
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_356E067F_Out_3;
                Unity_Lerp_half3(_NormalStrength_528ACD86_Out_2, _NormalStrength_3BD81F5D_Out_2, (_Absolute_6685A82A_Out_1.xxx), _Lerp_356E067F_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_87340130_Out_0 = _SmallCascadeTiling;
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
                half _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
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
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_AEBC8292_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_188C8FD3_Out_2);
                _SampleTexture2D_AEBC8292_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AEBC8292_RGBA_0);
                half _SampleTexture2D_AEBC8292_R_4 = _SampleTexture2D_AEBC8292_RGBA_0.r;
                half _SampleTexture2D_AEBC8292_G_5 = _SampleTexture2D_AEBC8292_RGBA_0.g;
                half _SampleTexture2D_AEBC8292_B_6 = _SampleTexture2D_AEBC8292_RGBA_0.b;
                half _SampleTexture2D_AEBC8292_A_7 = _SampleTexture2D_AEBC8292_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_8A81F679_Out_0 = _SmallCascadeNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
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
                half _Absolute_47687D69_Out_1;
                Unity_Absolute_half(_Split_C4B2F888_G_2, _Absolute_47687D69_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7DFFA574_Out_3;
                Unity_Clamp_half(_Absolute_47687D69_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
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
                half _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_A86AE25B_Out_2;
                Unity_Power_half(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                half _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                half _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                half _Split_7AAAB3D7_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_A4D565CD_Out_1;
                Unity_Absolute_half(_Split_7AAAB3D7_G_2, _Absolute_A4D565CD_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_half(_Absolute_A4D565CD_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_EAB4CFE5_Out_2;
                Unity_Divide_half(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_half(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_half(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_F34F3E95_Out_3;
                Unity_Clamp_half(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_2BCCE84_Out_2;
                Unity_Divide_half(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_half(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C5CAE82_Out_3;
                Unity_Clamp_half(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_half(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_19F078F3_Out_1;
                Unity_Absolute_half(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_8825055A_Out_2;
                Unity_Power_half(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_half(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_half(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C9BB189_Out_3;
                Unity_Clamp_half(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_BA2C71FD_Out_3;
                Unity_Lerp_half3(_Lerp_356E067F_Out_3, _Lerp_5B898C96_Out_3, (_Clamp_C9BB189_Out_3.xxx), _Lerp_BA2C71FD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_half(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_C884DDDE_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_half(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                half _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                half _Split_9358BE5B_B_3 = 0;
                half _Split_9358BE5B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_992266D4_Out_0 = half2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_DD741EC2_Out_3;
                Unity_Branch_half2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_B7675A94_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_B3DB86EF_Out_2;
                Unity_Add_half(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_half(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_half(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_DAA63F9C_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_4B6448D6_Out_2;
                Unity_Divide_half(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_2E4D7348_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_half(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_half((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_D29A7CEF_Out_2;
                Unity_Add_half2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_D29A7CEF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_6ABE710E_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_D29A7CEF_Out_2);
                _SampleTexture2D_6ABE710E_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6ABE710E_RGBA_0);
                half _SampleTexture2D_6ABE710E_R_4 = _SampleTexture2D_6ABE710E_RGBA_0.r;
                half _SampleTexture2D_6ABE710E_G_5 = _SampleTexture2D_6ABE710E_RGBA_0.g;
                half _SampleTexture2D_6ABE710E_B_6 = _SampleTexture2D_6ABE710E_RGBA_0.b;
                half _SampleTexture2D_6ABE710E_A_7 = _SampleTexture2D_6ABE710E_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_944CEF1C_Out_0 = _BigCascadeNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_8AA324A2_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_6ABE710E_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8AA324A2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_DD0F4500_Out_2;
                Unity_Add_half(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_641D15D3_Out_1;
                Unity_Fraction_half(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_half(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_47CB0CEA_Out_2;
                Unity_Add_half2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_47CB0CEA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_6FC3A421_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_47CB0CEA_Out_2);
                _SampleTexture2D_6FC3A421_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6FC3A421_RGBA_0);
                half _SampleTexture2D_6FC3A421_R_4 = _SampleTexture2D_6FC3A421_RGBA_0.r;
                half _SampleTexture2D_6FC3A421_G_5 = _SampleTexture2D_6FC3A421_RGBA_0.g;
                half _SampleTexture2D_6FC3A421_B_6 = _SampleTexture2D_6FC3A421_RGBA_0.b;
                half _SampleTexture2D_6FC3A421_A_7 = _SampleTexture2D_6FC3A421_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_8264A1B8_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_6FC3A421_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8264A1B8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_E6ED65B6_Out_2;
                Unity_Add_half(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_E9A08C0_Out_2;
                Unity_Multiply_half(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_half(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_F884F066_Out_3;
                Unity_Lerp_half3(_NormalStrength_8AA324A2_Out_2, _NormalStrength_8264A1B8_Out_2, (_Absolute_19D4C5A5_Out_1.xxx), _Lerp_F884F066_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_C8A32E85_Out_3;
                Unity_Lerp_half3(_Lerp_BA2C71FD_Out_3, _Lerp_F884F066_Out_3, (_Clamp_C3D0E6D0_Out_3.xxx), _Lerp_C8A32E85_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Normalize_17DCA406_Out_1;
                Unity_Normalize_half3(_Lerp_C8A32E85_Out_3, _Normalize_17DCA406_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Split_6A7D546B_R_1 = _Normalize_17DCA406_Out_1[0];
                half _Split_6A7D546B_G_2 = _Normalize_17DCA406_Out_1[1];
                half _Split_6A7D546B_B_3 = _Normalize_17DCA406_Out_1[2];
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
                half2 _Multiply_9F154179_Out_2;
                Unity_Multiply_half((_ScreenPosition_1B148032_Out_0.xy), _Multiply_2F7622D8_Out_2, _Multiply_9F154179_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_FCAE1710_Out_2;
                Unity_Add_half2((_ScreenPosition_1B148032_Out_0.xy), _Multiply_9F154179_Out_2, _Add_FCAE1710_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _SceneColor_E03F9940_Out_1;
                Unity_SceneColor_half((half4(_Add_FCAE1710_Out_2, 0.0, 1.0)), _SceneColor_E03F9940_Out_1);
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
                half _Property_BB1D3A49_Out_0 = _BigCascadeTransparency;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_6F5E4CCF_Out_2;
                Unity_Multiply_half(_Property_BB1D3A49_Out_0, _Clamp_C3D0E6D0_Out_3, _Multiply_6F5E4CCF_Out_2);
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
                half3 _Multiply_D633B72E_Out_2;
                Unity_Multiply_half((_Lerp_E98C0337_Out_3.xyz), _SceneColor_E03F9940_Out_1, _Multiply_D633B72E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_2DF52B0F_Out_0 = _WaterAlphaMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_D96AFE24_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_2DF52B0F_Out_0, _Multiply_D96AFE24_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_2E6740E7_Out_3;
                Unity_Clamp_half(_Multiply_D96AFE24_Out_2, 0, 1, _Clamp_2E6740E7_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_AD172459_Out_0 = _WaterAlphaPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Power_754E3B26_Out_2;
                Unity_Power_half(_Clamp_2E6740E7_Out_3, _Property_AD172459_Out_0, _Power_754E3B26_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_A1957B81_Out_3;
                Unity_Clamp_half(_Power_754E3B26_Out_2, 0, 1, _Clamp_A1957B81_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_E9A0ECDE_Out_3;
                Unity_Lerp_half3(_Multiply_D633B72E_Out_2, (_Lerp_E98C0337_Out_3.xyz), (_Clamp_A1957B81_Out_3.xxx), _Lerp_E9A0ECDE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_312FB549_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_43A46A4A_Out_3;
                Unity_Clamp_half(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
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
                half3 _Lerp_801DA607_Out_3;
                Unity_Lerp_half3(_SceneColor_E03F9940_Out_1, _Lerp_E9A0ECDE_Out_3, (_Clamp_9B4149BD_Out_3.xxx), _Lerp_801DA607_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_DISTORTION_ON)
                half3 _UseDistortion_B8368C60_Out_0 = _Lerp_801DA607_Out_3;
                #else
                half3 _UseDistortion_B8368C60_Out_0 = (_Lerp_E98C0337_Out_3.xyz);
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_13996939_Out_0 = _FoamColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_6A3E12E9_Out_0 = _FoamDepth;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_D65144A5_Out_2;
                Unity_Add_half(_Subtract_331D19CE_Out_2, _Property_6A3E12E9_Out_0, _Add_D65144A5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_236EA369_Out_1;
                Unity_Absolute_half(_Add_D65144A5_Out_2, _Absolute_236EA369_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_5092872F_Out_0 = _FoamFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_C278752C_Out_2;
                Unity_Power_half(_Absolute_236EA369_Out_1, _Property_5092872F_Out_0, _Power_C278752C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Saturate_F768EEA6_Out_1;
                Unity_Saturate_half(_Power_C278752C_Out_2, _Saturate_F768EEA6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_A8CF8708_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_25764F01_Out_0 = _FoamSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_3E47978_Out_0 = _FoamTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_DE80E1D6_Out_2;
                Unity_Multiply_half(_Property_25764F01_Out_0, _Property_3E47978_Out_0, _Multiply_DE80E1D6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_E1385FB5_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_3C9DE3D3_Out_2;
                Unity_Multiply_half(_Multiply_DE80E1D6_Out_2, (_UV_E1385FB5_Out_0.xy), _Multiply_3C9DE3D3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_90264A5B_R_1 = _Multiply_3C9DE3D3_Out_2[0];
                half _Split_90264A5B_G_2 = _Multiply_3C9DE3D3_Out_2[1];
                half _Split_90264A5B_B_3 = 0;
                half _Split_90264A5B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_8C003284_Out_0 = half2(_Split_90264A5B_G_2, _Split_90264A5B_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_81C13B1A_Out_3;
                Unity_Branch_half2(_Property_A8CF8708_Out_0, _Multiply_3C9DE3D3_Out_2, _Vector2_8C003284_Out_0, _Branch_81C13B1A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_F37F0047_Out_2;
                Unity_Multiply_half(_Branch_81C13B1A_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_F37F0047_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_70842CE7_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_D13271E5_Out_2;
                Unity_Divide_half(1, _Property_70842CE7_Out_0, _Divide_D13271E5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_E210B498_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_38B9004E_Out_2;
                Unity_Multiply_half(_Property_3E47978_Out_0, (_UV_E210B498_Out_0.xy), _Multiply_38B9004E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_FED7B7C8_Out_2;
                Unity_Multiply_half((_Divide_D13271E5_Out_2.xx), _Multiply_38B9004E_Out_2, _Multiply_FED7B7C8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_F1148D00_Out_2;
                Unity_Add_half2(_Multiply_F37F0047_Out_2, _Multiply_FED7B7C8_Out_2, _Add_F1148D00_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_D6FF940D_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_F1148D00_Out_2);
                half _SampleTexture2D_D6FF940D_R_4 = _SampleTexture2D_D6FF940D_RGBA_0.r;
                half _SampleTexture2D_D6FF940D_G_5 = _SampleTexture2D_D6FF940D_RGBA_0.g;
                half _SampleTexture2D_D6FF940D_B_6 = _SampleTexture2D_D6FF940D_RGBA_0.b;
                half _SampleTexture2D_D6FF940D_A_7 = _SampleTexture2D_D6FF940D_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_3FB3476F_Out_2;
                Unity_Multiply_half(_Branch_81C13B1A_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_3FB3476F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_7633CAE7_Out_2;
                Unity_Add_half2(_Multiply_FED7B7C8_Out_2, _Multiply_3FB3476F_Out_2, _Add_7633CAE7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_80481243_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_7633CAE7_Out_2);
                half _SampleTexture2D_80481243_R_4 = _SampleTexture2D_80481243_RGBA_0.r;
                half _SampleTexture2D_80481243_G_5 = _SampleTexture2D_80481243_RGBA_0.g;
                half _SampleTexture2D_80481243_B_6 = _SampleTexture2D_80481243_RGBA_0.b;
                half _SampleTexture2D_80481243_A_7 = _SampleTexture2D_80481243_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_408AE005_Out_3;
                Unity_Lerp_half(_SampleTexture2D_D6FF940D_B_6, _SampleTexture2D_80481243_B_6, _Absolute_6685A82A_Out_1, _Lerp_408AE005_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_CE5D1661_Out_2;
                Unity_Multiply_half(_Saturate_F768EEA6_Out_1, _Lerp_408AE005_Out_3, _Multiply_CE5D1661_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_25030EB5_Out_3;
                Unity_Lerp_half(_Multiply_CE5D1661_Out_2, 0, _Clamp_C3D0E6D0_Out_3, _Lerp_25030EB5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_CDFBCC47_Out_3;
                Unity_Clamp_half(_Lerp_25030EB5_Out_3, 0, 1, _Clamp_CDFBCC47_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_6998DF58_Out_3;
                Unity_Lerp_half3(_UseDistortion_B8368C60_Out_0, (_Property_13996939_Out_0.xyz), (_Clamp_CDFBCC47_Out_3.xxx), _Lerp_6998DF58_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_B8ACE3F1_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_188C8FD3_Out_2);
                half _SampleTexture2D_B8ACE3F1_R_4 = _SampleTexture2D_B8ACE3F1_RGBA_0.r;
                half _SampleTexture2D_B8ACE3F1_G_5 = _SampleTexture2D_B8ACE3F1_RGBA_0.g;
                half _SampleTexture2D_B8ACE3F1_B_6 = _SampleTexture2D_B8ACE3F1_RGBA_0.b;
                half _SampleTexture2D_B8ACE3F1_A_7 = _SampleTexture2D_B8ACE3F1_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_A1621BBD_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_3E5AC13E_Out_2);
                half _SampleTexture2D_A1621BBD_R_4 = _SampleTexture2D_A1621BBD_RGBA_0.r;
                half _SampleTexture2D_A1621BBD_G_5 = _SampleTexture2D_A1621BBD_RGBA_0.g;
                half _SampleTexture2D_A1621BBD_B_6 = _SampleTexture2D_A1621BBD_RGBA_0.b;
                half _SampleTexture2D_A1621BBD_A_7 = _SampleTexture2D_A1621BBD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_3B18082_Out_3;
                Unity_Lerp_half(_SampleTexture2D_B8ACE3F1_R_4, _SampleTexture2D_A1621BBD_R_4, _Absolute_D56AD49D_Out_1, _Lerp_3B18082_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_50DF1CAB_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_A4A55C8D_Out_0 = _NoiseSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_986C2E1B_Out_0 = _NoiseTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_778A9500_Out_2;
                Unity_Multiply_half(_Property_A4A55C8D_Out_0, _Property_986C2E1B_Out_0, _Multiply_778A9500_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_4A477E20_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_E53528CB_Out_2;
                Unity_Multiply_half(_Multiply_778A9500_Out_2, (_UV_4A477E20_Out_0.xy), _Multiply_E53528CB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_A3C5F2B5_R_1 = _Multiply_E53528CB_Out_2[0];
                half _Split_A3C5F2B5_G_2 = _Multiply_E53528CB_Out_2[1];
                half _Split_A3C5F2B5_B_3 = 0;
                half _Split_A3C5F2B5_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_6D67D273_Out_0 = half2(_Split_A3C5F2B5_G_2, _Split_A3C5F2B5_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_EDA2C0E3_Out_3;
                Unity_Branch_half2(_Property_50DF1CAB_Out_0, _Multiply_E53528CB_Out_2, _Vector2_6D67D273_Out_0, _Branch_EDA2C0E3_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_12A5FB28_Out_1;
                Unity_Fraction_half(_Add_7EF542FE_Out_2, _Fraction_12A5FB28_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_39A54641_Out_2;
                Unity_Multiply_half(_Branch_EDA2C0E3_Out_3, (_Fraction_12A5FB28_Out_1.xx), _Multiply_39A54641_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_82193ED3_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_411EED11_Out_2;
                Unity_Divide_half(1, _Property_82193ED3_Out_0, _Divide_411EED11_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_F9D3A262_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_9C31F9C2_Out_2;
                Unity_Multiply_half(_Property_986C2E1B_Out_0, (_UV_F9D3A262_Out_0.xy), _Multiply_9C31F9C2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_E6E2F026_Out_2;
                Unity_Multiply_half((_Divide_411EED11_Out_2.xx), _Multiply_9C31F9C2_Out_2, _Multiply_E6E2F026_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_BADC8439_Out_2;
                Unity_Add_half2(_Multiply_39A54641_Out_2, _Multiply_E6E2F026_Out_2, _Add_BADC8439_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_D803AB07_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_BADC8439_Out_2);
                half _SampleTexture2D_D803AB07_R_4 = _SampleTexture2D_D803AB07_RGBA_0.r;
                half _SampleTexture2D_D803AB07_G_5 = _SampleTexture2D_D803AB07_RGBA_0.g;
                half _SampleTexture2D_D803AB07_B_6 = _SampleTexture2D_D803AB07_RGBA_0.b;
                half _SampleTexture2D_D803AB07_A_7 = _SampleTexture2D_D803AB07_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_9E406053_Out_1;
                Unity_Fraction_half(_Add_42A4AEEC_Out_2, _Fraction_9E406053_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_EEA6AA5B_Out_2;
                Unity_Multiply_half(_Branch_EDA2C0E3_Out_3, (_Fraction_9E406053_Out_1.xx), _Multiply_EEA6AA5B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_9509D7CE_Out_2;
                Unity_Add_half2(_Multiply_E6E2F026_Out_2, _Multiply_EEA6AA5B_Out_2, _Add_9509D7CE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_198CC76A_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_9509D7CE_Out_2);
                half _SampleTexture2D_198CC76A_R_4 = _SampleTexture2D_198CC76A_RGBA_0.r;
                half _SampleTexture2D_198CC76A_G_5 = _SampleTexture2D_198CC76A_RGBA_0.g;
                half _SampleTexture2D_198CC76A_B_6 = _SampleTexture2D_198CC76A_RGBA_0.b;
                half _SampleTexture2D_198CC76A_A_7 = _SampleTexture2D_198CC76A_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_51CEF3BF_Out_3;
                Unity_Lerp_half(_SampleTexture2D_D803AB07_A_7, _SampleTexture2D_198CC76A_A_7, _Absolute_D56AD49D_Out_1, _Lerp_51CEF3BF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_38E6503D_Out_1;
                Unity_Absolute_half(_Lerp_51CEF3BF_Out_3, _Absolute_38E6503D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C1134212_Out_0 = _SmallCascadeNoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_483D9151_Out_2;
                Unity_Power_half(_Absolute_38E6503D_Out_1, _Property_C1134212_Out_0, _Power_483D9151_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_8B0E8794_Out_0 = _SmallCascadeNoiseMultiply;
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
                half _Lerp_39572874_Out_3;
                Unity_Lerp_half(0, _Lerp_3B18082_Out_3, _Clamp_805729EB_Out_3, _Lerp_39572874_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_997BA4E8_Out_0 = _SmallCascadeColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_E85EE897_Out_2;
                Unity_Multiply_half((_Lerp_39572874_Out_3.xxxx), _Property_997BA4E8_Out_0, _Multiply_E85EE897_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_5DF2B9D0_Out_1;
                Unity_Absolute_half(_Lerp_3B18082_Out_3, _Absolute_5DF2B9D0_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_97A26DCC_Out_0 = _SmallCascadeFoamFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_328AD5E3_Out_2;
                Unity_Power_half(_Absolute_5DF2B9D0_Out_1, _Property_97A26DCC_Out_0, _Power_328AD5E3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_33692D9C_Out_3;
                Unity_Clamp_half(_Power_328AD5E3_Out_2, 0, 1, _Clamp_33692D9C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_8877E3D4_Out_3;
                Unity_Lerp_half(0, _Clamp_33692D9C_Out_3, _Clamp_C9BB189_Out_3, _Lerp_8877E3D4_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_4F98523C_Out_3;
                Unity_Lerp_half3(_Lerp_6998DF58_Out_3, (_Multiply_E85EE897_Out_2.xyz), (_Lerp_8877E3D4_Out_3.xxx), _Lerp_4F98523C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_387AEB22_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_D29A7CEF_Out_2);
                half _SampleTexture2D_387AEB22_R_4 = _SampleTexture2D_387AEB22_RGBA_0.r;
                half _SampleTexture2D_387AEB22_G_5 = _SampleTexture2D_387AEB22_RGBA_0.g;
                half _SampleTexture2D_387AEB22_B_6 = _SampleTexture2D_387AEB22_RGBA_0.b;
                half _SampleTexture2D_387AEB22_A_7 = _SampleTexture2D_387AEB22_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_9FEF114B_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_47CB0CEA_Out_2);
                half _SampleTexture2D_9FEF114B_R_4 = _SampleTexture2D_9FEF114B_RGBA_0.r;
                half _SampleTexture2D_9FEF114B_G_5 = _SampleTexture2D_9FEF114B_RGBA_0.g;
                half _SampleTexture2D_9FEF114B_B_6 = _SampleTexture2D_9FEF114B_RGBA_0.b;
                half _SampleTexture2D_9FEF114B_A_7 = _SampleTexture2D_9FEF114B_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_8DF0FC6B_Out_3;
                Unity_Lerp_half(_SampleTexture2D_387AEB22_G_5, _SampleTexture2D_9FEF114B_G_5, _Absolute_19D4C5A5_Out_1, _Lerp_8DF0FC6B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_2D163AB3_Out_2;
                Unity_Multiply_half(0.5, _Lerp_8DF0FC6B_Out_3, _Multiply_2D163AB3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_5515474F_Out_0 = _BigCascadeNoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_E5773568_Out_2;
                Unity_Power_half(_Absolute_38E6503D_Out_1, _Property_5515474F_Out_0, _Power_E5773568_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_2C8FB0D9_Out_0 = _BigCascadeNoiseMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_9128FAF6_Out_2;
                Unity_Multiply_half(_Power_E5773568_Out_2, _Property_2C8FB0D9_Out_0, _Multiply_9128FAF6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_1E99CDDE_Out_3;
                Unity_Clamp_half(_Multiply_9128FAF6_Out_2, 0, 1, _Clamp_1E99CDDE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_50210667_Out_3;
                Unity_Lerp_half(_Multiply_2D163AB3_Out_2, _Lerp_8DF0FC6B_Out_3, _Clamp_1E99CDDE_Out_3, _Lerp_50210667_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_70B53B1D_Out_0 = _BigCascadeColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_630AB59_Out_2;
                Unity_Multiply_half((_Lerp_50210667_Out_3.xxxx), _Property_70B53B1D_Out_0, _Multiply_630AB59_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_E807A97_Out_1;
                Unity_Absolute_half(_Lerp_8DF0FC6B_Out_3, _Absolute_E807A97_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_97864BE9_Out_0 = Big_Cascade_Foam_Falloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_F37DBF08_Out_2;
                Unity_Power_half(_Absolute_E807A97_Out_1, _Property_97864BE9_Out_0, _Power_F37DBF08_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_142C06F9_Out_3;
                Unity_Clamp_half(_Power_F37DBF08_Out_2, 0, 1, _Clamp_142C06F9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_6316FED8_Out_3;
                Unity_Lerp_half(0, _Clamp_142C06F9_Out_3, _Clamp_C3D0E6D0_Out_3, _Lerp_6316FED8_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_96C773B7_Out_3;
                Unity_Lerp_half3(_Lerp_4F98523C_Out_3, (_Multiply_630AB59_Out_2.xyz), (_Lerp_6316FED8_Out_3.xxx), _Lerp_96C773B7_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_399CF5F0_Out_0 = _OutlinePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_F19BF3EF_Out_1;
                Unity_OneMinus_half(_Property_399CF5F0_Out_0, _OneMinus_F19BF3EF_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_53102B82_Out_2;
                Unity_Add_half(_Subtract_331D19CE_Out_2, _OneMinus_F19BF3EF_Out_1, _Add_53102B82_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_8CE6A8BB_Out_1;
                Unity_Absolute_half(_Add_53102B82_Out_2, _Absolute_8CE6A8BB_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_BCFC6E6B_Out_0 = _OutlineFalloffBorder;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_D4C2721A_Out_1;
                Unity_OneMinus_half(_Property_BCFC6E6B_Out_0, _OneMinus_D4C2721A_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_DC867686_Out_2;
                Unity_Power_half(_Absolute_8CE6A8BB_Out_1, _OneMinus_D4C2721A_Out_1, _Power_DC867686_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_A6F1C350_Out_3;
                Unity_Clamp_half(_Power_DC867686_Out_2, 0, 1, _Clamp_A6F1C350_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_C59730BD_Out_0 = _Outline_Color;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_54E8D4E2_Out_2;
                Unity_Multiply_half((_Clamp_A6F1C350_Out_3.xxxx), _Property_C59730BD_Out_0, _Multiply_54E8D4E2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_42E433A0_R_1 = IN.VertexColor[0];
                half _Split_42E433A0_G_2 = IN.VertexColor[1];
                half _Split_42E433A0_B_3 = IN.VertexColor[2];
                half _Split_42E433A0_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_8996C25F_Out_2;
                Unity_Multiply_half(_Multiply_54E8D4E2_Out_2, (_Split_42E433A0_A_4.xxxx), _Multiply_8996C25F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_9FA23315_Out_0 = _EdgeFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A696A267_Out_2;
                Unity_Multiply_half(_Absolute_97151155_Out_1, _Property_9FA23315_Out_0, _Multiply_A696A267_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_43248266_Out_3;
                Unity_Clamp_half(_Multiply_A696A267_Out_2, 0, 1, _Clamp_43248266_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_E54EA794_Out_1;
                Unity_Absolute_half(_Clamp_43248266_Out_3, _Absolute_E54EA794_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_38A7BE1A_Out_0 = _EdgeFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_E32F038D_Out_2;
                Unity_Power_half(_Absolute_E54EA794_Out_1, _Property_38A7BE1A_Out_0, _Power_E32F038D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7650C035_Out_3;
                Unity_Clamp_half(_Power_E32F038D_Out_2, 0, 1, _Clamp_7650C035_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_73E319C1_Out_2;
                Unity_Multiply_half(_Clamp_7650C035_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
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
                surface.Albedo = _Lerp_96C773B7_Out_3;
                surface.Emission = (_Multiply_8996C25F_Out_2.xyz);
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
            half2 _SmallCascadeMainSpeed;
            half2 _BigCascadeMainSpeed;
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
            half _OutlinePower;
            half _OutlineFalloffBorder;
            half4 _Outline_Color;
            half _WaterSmoothness;
            half _WaterSpecularClose;
            half _WaterSpecularFar;
            half _WaterSpecularThreshold;
            half _Distortion;
            half _BackfaceAlpha;
            half2 _SlowWaterTiling;
            half _SlowNormalScale;
            half _FarNormalPower;
            half _SmallCascadeAngle;
            half _SmallCascadeAngleFalloff;
            half2 _SmallCascadeTiling;
            half _SmallCascadeNormalScale;
            half4 _SmallCascadeColor;
            half _SmallCascadeFoamFalloff;
            half _SmallCascadeSmoothness;
            half _SmallCascadeSpecular;
            half _BigCascadeAngle;
            half _BigCascadeAngleFalloff;
            half _BigCascadeNormalScale;
            half2 _BigCascadeTiling;
            half _BigCascadeSmoothness;
            half _BigCascadeSpecular;
            half4 _BigCascadeColor;
            half Big_Cascade_Foam_Falloff;
            half _BigCascadeTransparency;
            half _SmallCascadeNoisePower;
            half _BigCascadeNoisePower;
            half _SmallCascadeNoiseMultiply;
            half _BigCascadeNoiseMultiply;
            half4 _FoamColor;
            half2 _FoamTiling;
            half2 _FoamSpeed;
            half _FoamDepth;
            half _FoamFalloff;
            half _FoamSmoothness;
            half _FoamSpecular;
            half2 _NoiseTiling;
            half2 _NoiseSpeed;
            half _AOPower;
            half _WaterFlowUVRefresSpeed;
            half _SmallCascadeFlowUVRefreshSpeed;
            half _BigCascadeFlowUVRefreshSpeed;
            CBUFFER_END
            TEXTURE2D(_SlowWaterNormal); SAMPLER(sampler_SlowWaterNormal); half4 _SlowWaterNormal_TexelSize;
            TEXTURE2D(_CascadesTexturesRGFoamBNoiseA); SAMPLER(sampler_CascadesTexturesRGFoamBNoiseA); half4 _CascadesTexturesRGFoamBNoiseA_TexelSize;
            SAMPLER(_SampleTexture2D_91308B7C_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_4508A259_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_AEBC8292_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9126225F_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6ABE710E_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_6FC3A421_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D6FF940D_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_80481243_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_B8ACE3F1_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_A1621BBD_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_D803AB07_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_198CC76A_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_387AEB22_Sampler_3_Linear_Repeat);
            SAMPLER(_SampleTexture2D_9FEF114B_Sampler_3_Linear_Repeat);
        
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
            
            void Unity_Power_half(half A, half B, out half Out)
            {
                Out = pow(A, B);
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
            
            void Unity_Lerp_half(half A, half B, half T, out half Out)
            {
                Out = lerp(A, B, T);
            }
            
            void Unity_Saturate_half(half In, out half Out)
            {
                Out = saturate(In);
            }
            
            void Unity_Lerp_half4(half4 A, half4 B, half4 T, out half4 Out)
            {
                Out = lerp(A, B, T);
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
                half4 _ScreenPosition_1B148032_Out_0 = half4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0);
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
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_31890938_Out_2;
                Unity_Add_half(_Multiply_3E4E17C1_Out_2, 0.5, _Add_31890938_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
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
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_356E067F_Out_3;
                Unity_Lerp_half3(_NormalStrength_528ACD86_Out_2, _NormalStrength_3BD81F5D_Out_2, (_Absolute_6685A82A_Out_1.xxx), _Lerp_356E067F_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_707D3429_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_FDE310C2_Out_0 = _SmallCascadeMainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_87340130_Out_0 = _SmallCascadeTiling;
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
                half _Property_375B806D_Out_0 = _SmallCascadeFlowUVRefreshSpeed;
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
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_AEBC8292_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_188C8FD3_Out_2);
                _SampleTexture2D_AEBC8292_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_AEBC8292_RGBA_0);
                half _SampleTexture2D_AEBC8292_R_4 = _SampleTexture2D_AEBC8292_RGBA_0.r;
                half _SampleTexture2D_AEBC8292_G_5 = _SampleTexture2D_AEBC8292_RGBA_0.g;
                half _SampleTexture2D_AEBC8292_B_6 = _SampleTexture2D_AEBC8292_RGBA_0.b;
                half _SampleTexture2D_AEBC8292_A_7 = _SampleTexture2D_AEBC8292_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_8A81F679_Out_0 = _SmallCascadeNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
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
                half _Absolute_47687D69_Out_1;
                Unity_Absolute_half(_Split_C4B2F888_G_2, _Absolute_47687D69_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7DFFA574_Out_3;
                Unity_Clamp_half(_Absolute_47687D69_Out_1, 0, 1, _Clamp_7DFFA574_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C24EE4D_Out_0 = _SmallCascadeAngle;
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
                half _Property_1F70A06C_Out_0 = _SmallCascadeAngleFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_A86AE25B_Out_2;
                Unity_Power_half(_Absolute_438A66D_Out_1, _Property_1F70A06C_Out_0, _Power_A86AE25B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_7AAAB3D7_R_1 = IN.WorldSpaceNormal[0];
                half _Split_7AAAB3D7_G_2 = IN.WorldSpaceNormal[1];
                half _Split_7AAAB3D7_B_3 = IN.WorldSpaceNormal[2];
                half _Split_7AAAB3D7_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_A4D565CD_Out_1;
                Unity_Absolute_half(_Split_7AAAB3D7_G_2, _Absolute_A4D565CD_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_8F67BD3C_Out_3;
                Unity_Clamp_half(_Absolute_A4D565CD_Out_1, 0, 1, _Clamp_8F67BD3C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_FE8F465F_Out_0 = _BigCascadeAngle;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_EAB4CFE5_Out_2;
                Unity_Divide_half(_Property_FE8F465F_Out_0, 45, _Divide_EAB4CFE5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_17BEBA89_Out_1;
                Unity_OneMinus_half(_Divide_EAB4CFE5_Out_2, _OneMinus_17BEBA89_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_5D75A7EB_Out_2;
                Unity_Subtract_half(_Clamp_8F67BD3C_Out_3, _OneMinus_17BEBA89_Out_1, _Subtract_5D75A7EB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_F34F3E95_Out_3;
                Unity_Clamp_half(_Subtract_5D75A7EB_Out_2, 0, 2, _Clamp_F34F3E95_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_2BCCE84_Out_2;
                Unity_Divide_half(1, _Divide_EAB4CFE5_Out_2, _Divide_2BCCE84_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_7BA4C2D3_Out_2;
                Unity_Multiply_half(_Clamp_F34F3E95_Out_3, _Divide_2BCCE84_Out_2, _Multiply_7BA4C2D3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C5CAE82_Out_3;
                Unity_Clamp_half(_Multiply_7BA4C2D3_Out_2, 0, 1, _Clamp_C5CAE82_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _OneMinus_4BE5A71F_Out_1;
                Unity_OneMinus_half(_Clamp_C5CAE82_Out_3, _OneMinus_4BE5A71F_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_19F078F3_Out_1;
                Unity_Absolute_half(_OneMinus_4BE5A71F_Out_1, _Absolute_19F078F3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_7D0A701F_Out_0 = _BigCascadeAngleFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_8825055A_Out_2;
                Unity_Power_half(_Absolute_19F078F3_Out_1, _Property_7D0A701F_Out_0, _Power_8825055A_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C3D0E6D0_Out_3;
                Unity_Clamp_half(_Power_8825055A_Out_2, 0, 1, _Clamp_C3D0E6D0_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Subtract_8CF67FB4_Out_2;
                Unity_Subtract_half(_Power_A86AE25B_Out_2, _Clamp_C3D0E6D0_Out_3, _Subtract_8CF67FB4_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_C9BB189_Out_3;
                Unity_Clamp_half(_Subtract_8CF67FB4_Out_2, 0, 1, _Clamp_C9BB189_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_BA2C71FD_Out_3;
                Unity_Lerp_half3(_Lerp_356E067F_Out_3, _Lerp_5B898C96_Out_3, (_Clamp_C9BB189_Out_3.xxx), _Lerp_BA2C71FD_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_4FDC54B8_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_3C77B592_Out_0 = _BigCascadeMainSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_DC7872BC_Out_0 = _BigCascadeTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_FD1ED85_Out_2;
                Unity_Multiply_half(_Property_3C77B592_Out_0, _Property_DC7872BC_Out_0, _Multiply_FD1ED85_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_C884DDDE_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_36DFE603_Out_2;
                Unity_Multiply_half(_Multiply_FD1ED85_Out_2, (_UV_C884DDDE_Out_0.xy), _Multiply_36DFE603_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_9358BE5B_R_1 = _Multiply_36DFE603_Out_2[0];
                half _Split_9358BE5B_G_2 = _Multiply_36DFE603_Out_2[1];
                half _Split_9358BE5B_B_3 = 0;
                half _Split_9358BE5B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_992266D4_Out_0 = half2(_Split_9358BE5B_G_2, _Split_9358BE5B_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_DD741EC2_Out_3;
                Unity_Branch_half2(_Property_4FDC54B8_Out_0, _Multiply_36DFE603_Out_2, _Vector2_992266D4_Out_0, _Branch_DD741EC2_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_B0F25675_Out_0 = _BigCascadeFlowUVRefreshSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_B7675A94_Out_2;
                Unity_Multiply_half(IN.TimeParameters.x, _Property_B0F25675_Out_0, _Multiply_B7675A94_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_B3DB86EF_Out_2;
                Unity_Add_half(_Multiply_B7675A94_Out_2, 1, _Add_B3DB86EF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_C4ED85D0_Out_1;
                Unity_Fraction_half(_Add_B3DB86EF_Out_2, _Fraction_C4ED85D0_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_3F007DDA_Out_2;
                Unity_Multiply_half(_Branch_DD741EC2_Out_3, (_Fraction_C4ED85D0_Out_1.xx), _Multiply_3F007DDA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_DAA63F9C_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_4B6448D6_Out_2;
                Unity_Divide_half(1, _Property_DAA63F9C_Out_0, _Divide_4B6448D6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_2E4D7348_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_E6663CE3_Out_2;
                Unity_Multiply_half(_Property_DC7872BC_Out_0, (_UV_2E4D7348_Out_0.xy), _Multiply_E6663CE3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_6D0EB40B_Out_2;
                Unity_Multiply_half((_Divide_4B6448D6_Out_2.xx), _Multiply_E6663CE3_Out_2, _Multiply_6D0EB40B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_D29A7CEF_Out_2;
                Unity_Add_half2(_Multiply_3F007DDA_Out_2, _Multiply_6D0EB40B_Out_2, _Add_D29A7CEF_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_6ABE710E_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_D29A7CEF_Out_2);
                _SampleTexture2D_6ABE710E_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6ABE710E_RGBA_0);
                half _SampleTexture2D_6ABE710E_R_4 = _SampleTexture2D_6ABE710E_RGBA_0.r;
                half _SampleTexture2D_6ABE710E_G_5 = _SampleTexture2D_6ABE710E_RGBA_0.g;
                half _SampleTexture2D_6ABE710E_B_6 = _SampleTexture2D_6ABE710E_RGBA_0.b;
                half _SampleTexture2D_6ABE710E_A_7 = _SampleTexture2D_6ABE710E_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_944CEF1C_Out_0 = _BigCascadeNormalScale;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_8AA324A2_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_6ABE710E_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8AA324A2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_DD0F4500_Out_2;
                Unity_Add_half(_Multiply_B7675A94_Out_2, 0.5, _Add_DD0F4500_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_641D15D3_Out_1;
                Unity_Fraction_half(_Add_DD0F4500_Out_2, _Fraction_641D15D3_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_C8B339D1_Out_2;
                Unity_Multiply_half(_Branch_DD741EC2_Out_3, (_Fraction_641D15D3_Out_1.xx), _Multiply_C8B339D1_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_47CB0CEA_Out_2;
                Unity_Add_half2(_Multiply_6D0EB40B_Out_2, _Multiply_C8B339D1_Out_2, _Add_47CB0CEA_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half4 _SampleTexture2D_6FC3A421_RGBA_0 = SAMPLE_TEXTURE2D(_SlowWaterNormal, sampler_SlowWaterNormal, _Add_47CB0CEA_Out_2);
                _SampleTexture2D_6FC3A421_RGBA_0.rgb = UnpackNormal(_SampleTexture2D_6FC3A421_RGBA_0);
                half _SampleTexture2D_6FC3A421_R_4 = _SampleTexture2D_6FC3A421_RGBA_0.r;
                half _SampleTexture2D_6FC3A421_G_5 = _SampleTexture2D_6FC3A421_RGBA_0.g;
                half _SampleTexture2D_6FC3A421_B_6 = _SampleTexture2D_6FC3A421_RGBA_0.b;
                half _SampleTexture2D_6FC3A421_A_7 = _SampleTexture2D_6FC3A421_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _NormalStrength_8264A1B8_Out_2;
                Unity_NormalStrength_half((_SampleTexture2D_6FC3A421_RGBA_0.xyz), _Property_944CEF1C_Out_0, _NormalStrength_8264A1B8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_E6ED65B6_Out_2;
                Unity_Add_half(_Fraction_C4ED85D0_Out_1, -0.5, _Add_E6ED65B6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_E9A08C0_Out_2;
                Unity_Multiply_half(_Add_E6ED65B6_Out_2, 2, _Multiply_E9A08C0_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_19D4C5A5_Out_1;
                Unity_Absolute_half(_Multiply_E9A08C0_Out_2, _Absolute_19D4C5A5_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_F884F066_Out_3;
                Unity_Lerp_half3(_NormalStrength_8AA324A2_Out_2, _NormalStrength_8264A1B8_Out_2, (_Absolute_19D4C5A5_Out_1.xxx), _Lerp_F884F066_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_C8A32E85_Out_3;
                Unity_Lerp_half3(_Lerp_BA2C71FD_Out_3, _Lerp_F884F066_Out_3, (_Clamp_C3D0E6D0_Out_3.xxx), _Lerp_C8A32E85_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Normalize_17DCA406_Out_1;
                Unity_Normalize_half3(_Lerp_C8A32E85_Out_3, _Normalize_17DCA406_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Split_6A7D546B_R_1 = _Normalize_17DCA406_Out_1[0];
                half _Split_6A7D546B_G_2 = _Normalize_17DCA406_Out_1[1];
                half _Split_6A7D546B_B_3 = _Normalize_17DCA406_Out_1[2];
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
                half2 _Multiply_9F154179_Out_2;
                Unity_Multiply_half((_ScreenPosition_1B148032_Out_0.xy), _Multiply_2F7622D8_Out_2, _Multiply_9F154179_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half2 _Add_FCAE1710_Out_2;
                Unity_Add_half2((_ScreenPosition_1B148032_Out_0.xy), _Multiply_9F154179_Out_2, _Add_FCAE1710_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _SceneColor_E03F9940_Out_1;
                Unity_SceneColor_half((half4(_Add_FCAE1710_Out_2, 0.0, 1.0)), _SceneColor_E03F9940_Out_1);
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
                half _Property_BB1D3A49_Out_0 = _BigCascadeTransparency;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_6F5E4CCF_Out_2;
                Unity_Multiply_half(_Property_BB1D3A49_Out_0, _Clamp_C3D0E6D0_Out_3, _Multiply_6F5E4CCF_Out_2);
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
                half3 _Multiply_D633B72E_Out_2;
                Unity_Multiply_half((_Lerp_E98C0337_Out_3.xyz), _SceneColor_E03F9940_Out_1, _Multiply_D633B72E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_2DF52B0F_Out_0 = _WaterAlphaMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Multiply_D96AFE24_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_2DF52B0F_Out_0, _Multiply_D96AFE24_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_2E6740E7_Out_3;
                Unity_Clamp_half(_Multiply_D96AFE24_Out_2, 0, 1, _Clamp_2E6740E7_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Property_AD172459_Out_0 = _WaterAlphaPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Power_754E3B26_Out_2;
                Unity_Power_half(_Clamp_2E6740E7_Out_3, _Property_AD172459_Out_0, _Power_754E3B26_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half _Clamp_A1957B81_Out_3;
                Unity_Clamp_half(_Power_754E3B26_Out_2, 0, 1, _Clamp_A1957B81_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0)
                half3 _Lerp_E9A0ECDE_Out_3;
                Unity_Lerp_half3(_Multiply_D633B72E_Out_2, (_Lerp_E98C0337_Out_3.xyz), (_Clamp_A1957B81_Out_3.xxx), _Lerp_E9A0ECDE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_DA3B2360_Out_0 = _CleanFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_312FB549_Out_2;
                Unity_Multiply_half(_Subtract_331D19CE_Out_2, _Property_DA3B2360_Out_0, _Multiply_312FB549_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_43A46A4A_Out_3;
                Unity_Clamp_half(_Multiply_312FB549_Out_2, 0, 1, _Clamp_43A46A4A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
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
                half3 _Lerp_801DA607_Out_3;
                Unity_Lerp_half3(_SceneColor_E03F9940_Out_1, _Lerp_E9A0ECDE_Out_3, (_Clamp_9B4149BD_Out_3.xxx), _Lerp_801DA607_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #if defined(_DISTORTION_ON)
                half3 _UseDistortion_B8368C60_Out_0 = _Lerp_801DA607_Out_3;
                #else
                half3 _UseDistortion_B8368C60_Out_0 = (_Lerp_E98C0337_Out_3.xyz);
                #endif
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_13996939_Out_0 = _FoamColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_6A3E12E9_Out_0 = _FoamDepth;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Add_D65144A5_Out_2;
                Unity_Add_half(_Subtract_331D19CE_Out_2, _Property_6A3E12E9_Out_0, _Add_D65144A5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_236EA369_Out_1;
                Unity_Absolute_half(_Add_D65144A5_Out_2, _Absolute_236EA369_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_5092872F_Out_0 = _FoamFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_C278752C_Out_2;
                Unity_Power_half(_Absolute_236EA369_Out_1, _Property_5092872F_Out_0, _Power_C278752C_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Saturate_F768EEA6_Out_1;
                Unity_Saturate_half(_Power_C278752C_Out_2, _Saturate_F768EEA6_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_A8CF8708_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_25764F01_Out_0 = _FoamSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_3E47978_Out_0 = _FoamTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_DE80E1D6_Out_2;
                Unity_Multiply_half(_Property_25764F01_Out_0, _Property_3E47978_Out_0, _Multiply_DE80E1D6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_E1385FB5_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_3C9DE3D3_Out_2;
                Unity_Multiply_half(_Multiply_DE80E1D6_Out_2, (_UV_E1385FB5_Out_0.xy), _Multiply_3C9DE3D3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_90264A5B_R_1 = _Multiply_3C9DE3D3_Out_2[0];
                half _Split_90264A5B_G_2 = _Multiply_3C9DE3D3_Out_2[1];
                half _Split_90264A5B_B_3 = 0;
                half _Split_90264A5B_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_8C003284_Out_0 = half2(_Split_90264A5B_G_2, _Split_90264A5B_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_81C13B1A_Out_3;
                Unity_Branch_half2(_Property_A8CF8708_Out_0, _Multiply_3C9DE3D3_Out_2, _Vector2_8C003284_Out_0, _Branch_81C13B1A_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_F37F0047_Out_2;
                Unity_Multiply_half(_Branch_81C13B1A_Out_3, (_Fraction_7B9D3CF1_Out_1.xx), _Multiply_F37F0047_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_70842CE7_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_D13271E5_Out_2;
                Unity_Divide_half(1, _Property_70842CE7_Out_0, _Divide_D13271E5_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_E210B498_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_38B9004E_Out_2;
                Unity_Multiply_half(_Property_3E47978_Out_0, (_UV_E210B498_Out_0.xy), _Multiply_38B9004E_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_FED7B7C8_Out_2;
                Unity_Multiply_half((_Divide_D13271E5_Out_2.xx), _Multiply_38B9004E_Out_2, _Multiply_FED7B7C8_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_F1148D00_Out_2;
                Unity_Add_half2(_Multiply_F37F0047_Out_2, _Multiply_FED7B7C8_Out_2, _Add_F1148D00_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_D6FF940D_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_F1148D00_Out_2);
                half _SampleTexture2D_D6FF940D_R_4 = _SampleTexture2D_D6FF940D_RGBA_0.r;
                half _SampleTexture2D_D6FF940D_G_5 = _SampleTexture2D_D6FF940D_RGBA_0.g;
                half _SampleTexture2D_D6FF940D_B_6 = _SampleTexture2D_D6FF940D_RGBA_0.b;
                half _SampleTexture2D_D6FF940D_A_7 = _SampleTexture2D_D6FF940D_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_3FB3476F_Out_2;
                Unity_Multiply_half(_Branch_81C13B1A_Out_3, (_Fraction_F03C9359_Out_1.xx), _Multiply_3FB3476F_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_7633CAE7_Out_2;
                Unity_Add_half2(_Multiply_FED7B7C8_Out_2, _Multiply_3FB3476F_Out_2, _Add_7633CAE7_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_80481243_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_7633CAE7_Out_2);
                half _SampleTexture2D_80481243_R_4 = _SampleTexture2D_80481243_RGBA_0.r;
                half _SampleTexture2D_80481243_G_5 = _SampleTexture2D_80481243_RGBA_0.g;
                half _SampleTexture2D_80481243_B_6 = _SampleTexture2D_80481243_RGBA_0.b;
                half _SampleTexture2D_80481243_A_7 = _SampleTexture2D_80481243_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_408AE005_Out_3;
                Unity_Lerp_half(_SampleTexture2D_D6FF940D_B_6, _SampleTexture2D_80481243_B_6, _Absolute_6685A82A_Out_1, _Lerp_408AE005_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_CE5D1661_Out_2;
                Unity_Multiply_half(_Saturate_F768EEA6_Out_1, _Lerp_408AE005_Out_3, _Multiply_CE5D1661_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_25030EB5_Out_3;
                Unity_Lerp_half(_Multiply_CE5D1661_Out_2, 0, _Clamp_C3D0E6D0_Out_3, _Lerp_25030EB5_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_CDFBCC47_Out_3;
                Unity_Clamp_half(_Lerp_25030EB5_Out_3, 0, 1, _Clamp_CDFBCC47_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_6998DF58_Out_3;
                Unity_Lerp_half3(_UseDistortion_B8368C60_Out_0, (_Property_13996939_Out_0.xyz), (_Clamp_CDFBCC47_Out_3.xxx), _Lerp_6998DF58_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_B8ACE3F1_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_188C8FD3_Out_2);
                half _SampleTexture2D_B8ACE3F1_R_4 = _SampleTexture2D_B8ACE3F1_RGBA_0.r;
                half _SampleTexture2D_B8ACE3F1_G_5 = _SampleTexture2D_B8ACE3F1_RGBA_0.g;
                half _SampleTexture2D_B8ACE3F1_B_6 = _SampleTexture2D_B8ACE3F1_RGBA_0.b;
                half _SampleTexture2D_B8ACE3F1_A_7 = _SampleTexture2D_B8ACE3F1_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_A1621BBD_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_3E5AC13E_Out_2);
                half _SampleTexture2D_A1621BBD_R_4 = _SampleTexture2D_A1621BBD_RGBA_0.r;
                half _SampleTexture2D_A1621BBD_G_5 = _SampleTexture2D_A1621BBD_RGBA_0.g;
                half _SampleTexture2D_A1621BBD_B_6 = _SampleTexture2D_A1621BBD_RGBA_0.b;
                half _SampleTexture2D_A1621BBD_A_7 = _SampleTexture2D_A1621BBD_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_3B18082_Out_3;
                Unity_Lerp_half(_SampleTexture2D_B8ACE3F1_R_4, _SampleTexture2D_A1621BBD_R_4, _Absolute_D56AD49D_Out_1, _Lerp_3B18082_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_50DF1CAB_Out_0 = _UVVDirection1UDirection0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_A4A55C8D_Out_0 = _NoiseSpeed;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Property_986C2E1B_Out_0 = _NoiseTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_778A9500_Out_2;
                Unity_Multiply_half(_Property_A4A55C8D_Out_0, _Property_986C2E1B_Out_0, _Multiply_778A9500_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_4A477E20_Out_0 = IN.uv3;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_E53528CB_Out_2;
                Unity_Multiply_half(_Multiply_778A9500_Out_2, (_UV_4A477E20_Out_0.xy), _Multiply_E53528CB_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_A3C5F2B5_R_1 = _Multiply_E53528CB_Out_2[0];
                half _Split_A3C5F2B5_G_2 = _Multiply_E53528CB_Out_2[1];
                half _Split_A3C5F2B5_B_3 = 0;
                half _Split_A3C5F2B5_A_4 = 0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Vector2_6D67D273_Out_0 = half2(_Split_A3C5F2B5_G_2, _Split_A3C5F2B5_R_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Branch_EDA2C0E3_Out_3;
                Unity_Branch_half2(_Property_50DF1CAB_Out_0, _Multiply_E53528CB_Out_2, _Vector2_6D67D273_Out_0, _Branch_EDA2C0E3_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_12A5FB28_Out_1;
                Unity_Fraction_half(_Add_7EF542FE_Out_2, _Fraction_12A5FB28_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_39A54641_Out_2;
                Unity_Multiply_half(_Branch_EDA2C0E3_Out_3, (_Fraction_12A5FB28_Out_1.xx), _Multiply_39A54641_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_82193ED3_Out_0 = _GlobalTiling;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Divide_411EED11_Out_2;
                Unity_Divide_half(1, _Property_82193ED3_Out_0, _Divide_411EED11_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _UV_F9D3A262_Out_0 = IN.uv0;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_9C31F9C2_Out_2;
                Unity_Multiply_half(_Property_986C2E1B_Out_0, (_UV_F9D3A262_Out_0.xy), _Multiply_9C31F9C2_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_E6E2F026_Out_2;
                Unity_Multiply_half((_Divide_411EED11_Out_2.xx), _Multiply_9C31F9C2_Out_2, _Multiply_E6E2F026_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_BADC8439_Out_2;
                Unity_Add_half2(_Multiply_39A54641_Out_2, _Multiply_E6E2F026_Out_2, _Add_BADC8439_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_D803AB07_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_BADC8439_Out_2);
                half _SampleTexture2D_D803AB07_R_4 = _SampleTexture2D_D803AB07_RGBA_0.r;
                half _SampleTexture2D_D803AB07_G_5 = _SampleTexture2D_D803AB07_RGBA_0.g;
                half _SampleTexture2D_D803AB07_B_6 = _SampleTexture2D_D803AB07_RGBA_0.b;
                half _SampleTexture2D_D803AB07_A_7 = _SampleTexture2D_D803AB07_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Fraction_9E406053_Out_1;
                Unity_Fraction_half(_Add_42A4AEEC_Out_2, _Fraction_9E406053_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Multiply_EEA6AA5B_Out_2;
                Unity_Multiply_half(_Branch_EDA2C0E3_Out_3, (_Fraction_9E406053_Out_1.xx), _Multiply_EEA6AA5B_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half2 _Add_9509D7CE_Out_2;
                Unity_Add_half2(_Multiply_E6E2F026_Out_2, _Multiply_EEA6AA5B_Out_2, _Add_9509D7CE_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_198CC76A_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_9509D7CE_Out_2);
                half _SampleTexture2D_198CC76A_R_4 = _SampleTexture2D_198CC76A_RGBA_0.r;
                half _SampleTexture2D_198CC76A_G_5 = _SampleTexture2D_198CC76A_RGBA_0.g;
                half _SampleTexture2D_198CC76A_B_6 = _SampleTexture2D_198CC76A_RGBA_0.b;
                half _SampleTexture2D_198CC76A_A_7 = _SampleTexture2D_198CC76A_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_51CEF3BF_Out_3;
                Unity_Lerp_half(_SampleTexture2D_D803AB07_A_7, _SampleTexture2D_198CC76A_A_7, _Absolute_D56AD49D_Out_1, _Lerp_51CEF3BF_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_38E6503D_Out_1;
                Unity_Absolute_half(_Lerp_51CEF3BF_Out_3, _Absolute_38E6503D_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_C1134212_Out_0 = _SmallCascadeNoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_483D9151_Out_2;
                Unity_Power_half(_Absolute_38E6503D_Out_1, _Property_C1134212_Out_0, _Power_483D9151_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_8B0E8794_Out_0 = _SmallCascadeNoiseMultiply;
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
                half _Lerp_39572874_Out_3;
                Unity_Lerp_half(0, _Lerp_3B18082_Out_3, _Clamp_805729EB_Out_3, _Lerp_39572874_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_997BA4E8_Out_0 = _SmallCascadeColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_E85EE897_Out_2;
                Unity_Multiply_half((_Lerp_39572874_Out_3.xxxx), _Property_997BA4E8_Out_0, _Multiply_E85EE897_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_5DF2B9D0_Out_1;
                Unity_Absolute_half(_Lerp_3B18082_Out_3, _Absolute_5DF2B9D0_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_97A26DCC_Out_0 = _SmallCascadeFoamFalloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_328AD5E3_Out_2;
                Unity_Power_half(_Absolute_5DF2B9D0_Out_1, _Property_97A26DCC_Out_0, _Power_328AD5E3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_33692D9C_Out_3;
                Unity_Clamp_half(_Power_328AD5E3_Out_2, 0, 1, _Clamp_33692D9C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_8877E3D4_Out_3;
                Unity_Lerp_half(0, _Clamp_33692D9C_Out_3, _Clamp_C9BB189_Out_3, _Lerp_8877E3D4_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_4F98523C_Out_3;
                Unity_Lerp_half3(_Lerp_6998DF58_Out_3, (_Multiply_E85EE897_Out_2.xyz), (_Lerp_8877E3D4_Out_3.xxx), _Lerp_4F98523C_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_387AEB22_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_D29A7CEF_Out_2);
                half _SampleTexture2D_387AEB22_R_4 = _SampleTexture2D_387AEB22_RGBA_0.r;
                half _SampleTexture2D_387AEB22_G_5 = _SampleTexture2D_387AEB22_RGBA_0.g;
                half _SampleTexture2D_387AEB22_B_6 = _SampleTexture2D_387AEB22_RGBA_0.b;
                half _SampleTexture2D_387AEB22_A_7 = _SampleTexture2D_387AEB22_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _SampleTexture2D_9FEF114B_RGBA_0 = SAMPLE_TEXTURE2D(_CascadesTexturesRGFoamBNoiseA, sampler_CascadesTexturesRGFoamBNoiseA, _Add_47CB0CEA_Out_2);
                half _SampleTexture2D_9FEF114B_R_4 = _SampleTexture2D_9FEF114B_RGBA_0.r;
                half _SampleTexture2D_9FEF114B_G_5 = _SampleTexture2D_9FEF114B_RGBA_0.g;
                half _SampleTexture2D_9FEF114B_B_6 = _SampleTexture2D_9FEF114B_RGBA_0.b;
                half _SampleTexture2D_9FEF114B_A_7 = _SampleTexture2D_9FEF114B_RGBA_0.a;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_8DF0FC6B_Out_3;
                Unity_Lerp_half(_SampleTexture2D_387AEB22_G_5, _SampleTexture2D_9FEF114B_G_5, _Absolute_19D4C5A5_Out_1, _Lerp_8DF0FC6B_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_2D163AB3_Out_2;
                Unity_Multiply_half(0.5, _Lerp_8DF0FC6B_Out_3, _Multiply_2D163AB3_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_5515474F_Out_0 = _BigCascadeNoisePower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_E5773568_Out_2;
                Unity_Power_half(_Absolute_38E6503D_Out_1, _Property_5515474F_Out_0, _Power_E5773568_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_2C8FB0D9_Out_0 = _BigCascadeNoiseMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_9128FAF6_Out_2;
                Unity_Multiply_half(_Power_E5773568_Out_2, _Property_2C8FB0D9_Out_0, _Multiply_9128FAF6_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_1E99CDDE_Out_3;
                Unity_Clamp_half(_Multiply_9128FAF6_Out_2, 0, 1, _Clamp_1E99CDDE_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_50210667_Out_3;
                Unity_Lerp_half(_Multiply_2D163AB3_Out_2, _Lerp_8DF0FC6B_Out_3, _Clamp_1E99CDDE_Out_3, _Lerp_50210667_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Property_70B53B1D_Out_0 = _BigCascadeColor;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half4 _Multiply_630AB59_Out_2;
                Unity_Multiply_half((_Lerp_50210667_Out_3.xxxx), _Property_70B53B1D_Out_0, _Multiply_630AB59_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_E807A97_Out_1;
                Unity_Absolute_half(_Lerp_8DF0FC6B_Out_3, _Absolute_E807A97_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_97864BE9_Out_0 = Big_Cascade_Foam_Falloff;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_F37DBF08_Out_2;
                Unity_Power_half(_Absolute_E807A97_Out_1, _Property_97864BE9_Out_0, _Power_F37DBF08_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_142C06F9_Out_3;
                Unity_Clamp_half(_Power_F37DBF08_Out_2, 0, 1, _Clamp_142C06F9_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Lerp_6316FED8_Out_3;
                Unity_Lerp_half(0, _Clamp_142C06F9_Out_3, _Clamp_C3D0E6D0_Out_3, _Lerp_6316FED8_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half3 _Lerp_96C773B7_Out_3;
                Unity_Lerp_half3(_Lerp_4F98523C_Out_3, (_Multiply_630AB59_Out_2.xyz), (_Lerp_6316FED8_Out_3.xxx), _Lerp_96C773B7_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _IsFrontFace_29CBC83C_Out_0 = max(0, IN.FaceSign);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_9FA23315_Out_0 = _EdgeFalloffMultiply;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_A696A267_Out_2;
                Unity_Multiply_half(_Absolute_97151155_Out_1, _Property_9FA23315_Out_0, _Multiply_A696A267_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_43248266_Out_3;
                Unity_Clamp_half(_Multiply_A696A267_Out_2, 0, 1, _Clamp_43248266_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Absolute_E54EA794_Out_1;
                Unity_Absolute_half(_Clamp_43248266_Out_3, _Absolute_E54EA794_Out_1);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Property_38A7BE1A_Out_0 = _EdgeFalloffPower;
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Power_E32F038D_Out_2;
                Unity_Power_half(_Absolute_E54EA794_Out_1, _Property_38A7BE1A_Out_0, _Power_E32F038D_Out_2);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Clamp_7650C035_Out_3;
                Unity_Clamp_half(_Power_E32F038D_Out_2, 0, 1, _Clamp_7650C035_Out_3);
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Split_42E433A0_R_1 = IN.VertexColor[0];
                half _Split_42E433A0_G_2 = IN.VertexColor[1];
                half _Split_42E433A0_B_3 = IN.VertexColor[2];
                half _Split_42E433A0_A_4 = IN.VertexColor[3];
                #endif
                #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
                half _Multiply_73E319C1_Out_2;
                Unity_Multiply_half(_Clamp_7650C035_Out_3, _Split_42E433A0_A_4, _Multiply_73E319C1_Out_2);
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
                surface.Albedo = _Lerp_96C773B7_Out_3;
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
