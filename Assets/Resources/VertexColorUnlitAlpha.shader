Shader "Custom/VertexColorUnlitAlpha" {
Properties {
 _MainTex ("Base (RGBA)", 2D) = "white" {}
 _Color ("Main Color", Color) = (1,1,1,1)
 _AlphaTex ("Alpha Mask (A)", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_MainTex_ST]
Vector 6 [_AlphaTex_ST]
Vector 7 [_Color]
"!!ARBvp1.0
# 7 ALU
PARAM c[8] = { program.local[0],
		state.matrix.mvp,
		program.local[5..7] };
MUL result.color, vertex.color, c[7];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[6], c[6].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 7 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
Vector 5 [_AlphaTex_ST]
Vector 6 [_Color]
"vs_2_0
; 7 ALU
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mul oD0, v1, c6
mad oT0.xy, v2, c4, c4.zwzw
mad oT1.xy, v3, c5, c5.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_AlphaTex_ST]
Vector 48 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedglnilfjecofjcelokbdmpfmpcochenaiabaaaaaapaacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahhaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefckiabaaaaeaaaabaagkaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaa
egbobaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaa
dcaaaaalmccabaaaacaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaacaaaaaa
kgiocaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 16 [_MainTex_ST]
Vector 32 [_AlphaTex_ST]
Vector 48 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedcgpgaeddnkjbfaomffboobhehjlileloabaaaaaabiaeaaaaaeaaaaaa
daaaaaaafeabaaaaaeadaaaaimadaaaaebgpgodjbmabaaaabmabaaaaaaacpopp
nmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
adaaabaaaaaaaaaaabaaaaaaaeaaaeaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeabaaadoaacaaoejaabaaoekaabaaooka
aeaaaaaeabaaamoaadaabejaacaabekaacaalekaafaaaaadaaaaapoaabaaoeja
adaaoekaafaaaaadaaaaapiaaaaaffjaafaaoekaaeaaaaaeaaaaapiaaeaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaahaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefckiabaaaaeaaaabaa
gkaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
dcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
mccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaadaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaa
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadcaaaaalmccabaaaacaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaa
doaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapadaaaahhaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaafaepfdejfeejepeoaaedepem
epfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_AlphaTex] 2D 1
"!!ARBfp1.0
# 4 ALU, 2 TEX
TEMP R0;
TEMP R1;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.x, fragment.texcoord[1], texture[1], 2D;
MUL result.color.xyz, fragment.color.primary, R0;
MUL result.color.w, R1.x, fragment.color.primary;
END
# 4 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_AlphaTex] 2D 1
"ps_2_0
; 3 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
dcl v0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
texld r1, t1, s1
mul r0.xyz, v0, r0
mul r0.w, r1.x, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_AlphaTex] 2D 1
"ps_4_0
eefiecedpbcabolcehjjeijadkbbmknekcdjhmljabaaaaaapaabaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpmaaaaaaeaaaaaaadpaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaa
aaaaaaaadkbabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_AlphaTex] 2D 1
"ps_4_0_level_9_1
eefiecedodafamgcakkciofkciefoiogofjkmmcfabaaaaaaliacaaaaaeaaaaaa
daaaaaaapeaaaaaapiabaaaaieacaaaaebgpgodjlmaaaaaalmaaaaaaaaacpppp
jaaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaabaaaaacaaaaadia
abaabllaecaaaaadaaaaapiaaaaaoeiaabaioekaecaaaaadabaaapiaabaaoela
aaaioekaafaaaaadaaaaciiaaaaaaaiaaaaapplaafaaaaadaaaachiaabaaoeia
aaaaoelaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpmaaaaaaeaaaaaaa
dpaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahiccabaaa
aaaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "VertexLit"
}