Shader "LarnDemShaders/SpinningTexture"
{
	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_Speed ("Speed", float) = 2
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Speed;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				float sinX = sin(_Speed * _Time.y);
            	float cosX = cos(_Speed * _Time.y);
            	float sinY = sin(_Speed * _Time.y);
            	float2x2 rotationMatrix = float2x2(cosX, -sinX, sinY, cosX);
            	o.uv -= float2(0.5,0.5);
            	o.uv = mul(o.uv, rotationMatrix);
            	o.uv += float2(0.5,0.5);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}
			ENDCG
		}
	}
}
