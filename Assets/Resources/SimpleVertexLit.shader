Shader "Custom/Simple Vertex Lit, Vertex Colored" {
SubShader { 
 Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="Vertex" "QUEUE"="Geometry" "RenderType"="Opaque" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
  }
  Lighting On
  ColorMaterial AmbientAndDiffuse
 }
}
}