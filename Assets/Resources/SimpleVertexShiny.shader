Shader "Custom/Simple Vertex Shiny" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.7
 _SpecColor ("Spec Color", Color) = (1,1,1,1)
 _Emission ("Emmisive Color", Color) = (0,0,0,0)
 _MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader { 
 Pass {
  Lighting On
  SeparateSpecular On
  Material {
   Ambient [_Color]
   Diffuse [_Color]
   Emission [_Emission]
   Specular [_SpecColor]
   Shininess [_Shininess]
  }
  SetTexture [_MainTex] { combine texture * primary double, texture alpha * primary alpha }
 }
}
}