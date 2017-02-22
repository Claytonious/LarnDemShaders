Shader "LarnDemShaders/NaiveLighting"
{
	SubShader
	{
		Tags { "RenderType"="Opaque" }

		Pass
		{
			Tags { "LightMode"="ForwardAdd" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			// Included to get light pos and params...
			#include "UnityLightingCommon.cginc"

			struct v2f
			{
				float4 position : SV_POSITION;
				float4 color : COLOR;
			};

			v2f vert (appdata_base v)
			{
				v2f o;
				o.position = mul(UNITY_MATRIX_MVP, v.vertex);
				float3 toLight = _WorldSpaceLightPos0.xyz - o.position.xyz;
				float3 worldSpaceNormal = UnityObjectToWorldNormal(v.normal);
				float intensity = max(0, dot(worldSpaceNormal, toLight));
				o.color = float4(intensity,intensity,intensity,1);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return i.color;
			}
			ENDCG
		}
	}
}
