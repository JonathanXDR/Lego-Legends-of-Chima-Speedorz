Shader "Custom/DebugRender" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
}
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
  }
  Material {
   Diffuse [_Color]
  }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
 }
}
}