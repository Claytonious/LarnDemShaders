Shader "LarnDemShaders/NaivePixelLightingColored"
{
	Properties
	{
		_LightColor ("Light Color", Color) = (1,1,1,1)
	}
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

			fixed4 _LightColor;

			struct v2f
			{
				float4 screenPosition : SV_POSITION;
				float3 worldNormal : NORMAL;
				float3 worldPosition : POSITION1;
			};

			v2f vert (appdata_base v)
			{
				v2f o;
				o.screenPosition = mul(UNITY_MATRIX_MVP, v.vertex);
				o.worldPosition = mul(_Object2World, v.vertex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float3 toLight = _WorldSpaceLightPos0.xyz - i.worldPosition;
				float intensity = max(0, dot(i.worldNormal, toLight));				
				return fixed4(_LightColor.x * intensity, _LightColor.y * intensity, _LightColor.z * intensity, _LightColor.a * intensity);
			}
			ENDCG
		}
	}
}
