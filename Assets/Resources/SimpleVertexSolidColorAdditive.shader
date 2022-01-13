Shader "Custom/Simple Vertex Solid Color Additive" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
}
SubShader { 
 Pass {
  Lighting On
  Material {
   Ambient [_Color]
   Diffuse [_Color]
  }
  Cull Off
  Blend One One
 }
}
}