Shader "LarnDemShaders/WavyNavyPixel"
{
	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_Speed ("Speed", float) = 1
		_Amplitude ("Amplitude", float) = 0.25
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
			float _Amplitude;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed2 texCoord = i.uv;
				texCoord.y += sin(i.uv.x * 3.14 + _Time.y * _Speed) * _Amplitude;
				fixed4 col = tex2D(_MainTex, texCoord);
				return col;
			}
			ENDCG
		}
	}
}
