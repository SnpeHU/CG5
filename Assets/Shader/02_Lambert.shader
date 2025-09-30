Shader "Unlit/02_Lambert"
{
    Properties
    {
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;

            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float intensity = saturate(dot(i.normal, _WorldSpaceLightPos0));
                
                fixed4 col = fixed4(1,1,1,1);
                fixed4 diffuse = col * _LightColor0 * intensity;

                // apply fog
                //UNITY_APPLY_FOG(i.fogCoord, col);

                return diffuse;
                
            }
            ENDCG
        }
    }
}
