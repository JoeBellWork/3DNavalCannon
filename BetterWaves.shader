Shader "Custom/BetterWaves"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}       
        _Saturation("Saturation", Range(-1,2)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM        
        #pragma surface surf Standard fullforwardshadows          

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };
        half _Saturation;
        fixed4 _Color;
        

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 uv = IN.uv_MainTex;
            uv.y += sin(uv.x * 6.2831 + _Time.y) * 0.15;

            fixed4 c = tex2D (_MainTex, uv) * _Color;
            float saturation = sin(uv.x * 6.2831) * 0.5 + 0.5;

            o.Albedo = lerp((c.r + c.g + c.b)/3, c, _Saturation * saturation);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
