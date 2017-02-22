Shader "LarnDemShaders/MVPMatrix"
{
	SubShader
	{
		// RenderType is for shader replacement and for depth texture rendering - it's not the same as Queue
		// Geometry is the default, anyway
		Tags { "RenderType"="Opaque" "Queue"="Geometry"}

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				//o.vertex = v.vertex;
				//o.vertex = mul(_Object2World, v.vertex);
				//o.vertex = mul(UNITY_MATRIX_V, v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return fixed4(0,1,0,1);
			}

			ENDCG
		}
	}
}
