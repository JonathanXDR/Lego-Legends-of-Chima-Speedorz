Shader "Custom/DistanceField" {
Properties {
 _MainTex ("Texture", 2D) = "white" {}
 _Outline ("Outline", Vector) = (0,1,0,1)
 _OutlineColor ("Outline Color", Color) = (0,0,0,1)
 _Edge ("Edge", Vector) = (0.5,0.6,0,0)
 _Glow ("Glow", Vector) = (0,0,0,1)
 _GlowColor ("Glow Color", Color) = (0.8,0.8,1,1)
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
Vector 5 [_MainTex_ST]
"!!ARBvp1.0
# 6 ALU
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
; 6 ALU
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov oD0, v1
mad oT0.xy, v2, c4, c4.zwzw
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
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedmjjcomofopdaignohejicfnhipmjodcgabaaaaaaiiacaaaaadaaaaaa
cmaaaaaaleaaaaaaciabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahhaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcfiabaaaaeaaaabaafgaaaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaa
agaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedifocggfhjiebmpcmnbocaielaianbkjpabaaaaaaimadaaaaaeaaaaaa
daaaaaaadaabaaaajaacaaaabiadaaaaebgpgodjpiaaaaaapiaaaaaaaaacpopp
liaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaagaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
aeaaaaaeabaaadoaacaaoejaabaaoekaabaaookaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaapoaabaaoejappppaaaafdeieefcfiabaaaaeaaaabaafgaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaagaaaaaa
ogikcaaaaaaaaaaaagaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapadaaaahhaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
faepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Outline]
Vector 1 [_OutlineColor]
Vector 2 [_Edge]
Vector 3 [_Glow]
Vector 4 [_GlowColor]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 33 ALU, 2 TEX
PARAM c[6] = { program.local[0..4],
		{ 3, 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1.x, fragment.texcoord[0], texture[0], 2D;
ADD R0.xy, fragment.texcoord[0], c[3];
TEX R0, R0, texture[0], 2D;
ADD R0.x, R0, R0.y;
ADD R0.x, R0, R0.z;
ADD_SAT R0.x, R0, R0.w;
ADD R0.y, c[3].w, -c[3].z;
ADD R0.z, c[2].x, -c[2].y;
RCP R0.y, R0.y;
ADD R0.x, R0, -c[3].z;
MUL_SAT R0.x, R0, R0.y;
MAD R0.y, -R0.x, c[5], c[5].x;
MUL R0.x, R0, R0;
MUL R0.x, R0, R0.y;
MUL R1.w, R0.x, c[4];
MOV_SAT R0.y, R1.x;
MUL R0.x, -R1, c[0].y;
ADD R0.x, R0, c[5].z;
MUL R0.w, R0.x, c[0].x;
RCP R0.z, R0.z;
ADD R0.y, R0, -c[2];
MUL_SAT R0.y, R0, R0.z;
MUL R0.z, R0.y, R0.y;
MAD R0.y, -R0, c[5], c[5].x;
MUL R0.y, R0.z, R0;
MUL R2.x, fragment.color.primary.w, R0.y;
MUL_SAT R0.w, R0, c[1];
ADD R0.xyz, -fragment.color.primary, c[1];
MAD R0.xyz, R0.w, R0, fragment.color.primary;
MOV R1.xyz, c[4];
MOV R0.w, R2.x;
ADD R0, R0, -R1;
MAD result.color, R2.x, R0, R1;
END
# 33 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Outline]
Vector 1 [_OutlineColor]
Vector 2 [_Edge]
Vector 3 [_Glow]
Vector 4 [_GlowColor]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 32 ALU, 2 TEX
dcl_2d s0
def c5, 2.00000000, 3.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
add r0.xy, t0, c3
add r3.x, c2, -c2.y
rcp r3.x, r3.x
texld r1, r0, s0
texld r0, t0, s0
add_pp r1.x, r1, r1.y
add_pp r2.x, r1, r1.z
add_pp_sat r2.x, r2, r1.w
add r1.x, c3.w, -c3.z
rcp r1.x, r1.x
add r2.x, r2, -c3.z
mul_sat r2.x, r2, r1
mad r1.x, -r2, c5, c5.y
mul r2.x, r2, r2
mul r1.x, r2, r1
mov_pp_sat r2.x, r0
add r2.x, r2, -c2.y
mul r2.w, r1.x, c4
mul_sat r2.x, r2, r3
mad r1.x, -r2, c5, c5.y
mul r2.x, r2, r2
mul r2.x, r2, r1
mul r1.x, -r0, c0.y
mul_pp r0.x, v0.w, r2
add r1.x, r1, c5.z
mul r1.x, r1, c0
mov_pp r1.w, r0.x
add r2.xyz, -v0, c1
mul_sat r1.x, r1, c1.w
mad r1.xyz, r1.x, r2, v0
mov_pp r2.xyz, c4
add_pp r1, r1, -r2
mad_pp r0, r0.x, r1, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 16 [_Outline]
Vector 32 [_OutlineColor]
Vector 48 [_Edge]
Vector 64 [_Glow]
Vector 80 [_GlowColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbcegehelppkahioiibjakmaonakanlahabaaaaaadeafaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfiaeaaaaeaaaaaaa
bgabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaai
dcaabaaaaaaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaaacaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaa
aoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
bkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaa
aaaaaaakbcaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaaakiacaaa
aaaaaaaaadaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgcaaaafccaabaaaabaaaaaa
akaabaaaacaaaaaadcaaaaalecaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaa
bkiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaiecaabaaaabaaaaaa
ckaabaaaabaaaaaaakiacaaaaaaaaaaaabaaaaaadicaaaaiecaabaaaabaaaaaa
ckaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaaaaaaaaajccaabaaaabaaaaaa
bkaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaadicaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaa
abaaaaaadkbabaaaabaaaaaaaaaaaaajlcaabaaaabaaaaaaegbibaiaebaaaaaa
abaaaaaaegiicaaaaaaaaaaaacaaaaaadcaaaaajhcaabaaaacaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaaegbcbaaaabaaaaaadgaaaaaghcaabaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaa
aaaaaaaaegaobaaaacaaaaaadcaaaaajpccabaaaaaaaaaaapgapbaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 16 [_Outline]
Vector 32 [_OutlineColor]
Vector 48 [_Edge]
Vector 64 [_Glow]
Vector 80 [_GlowColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedoceohhpiibloglilblmjgenimfhnabnbabaaaaaaneahaaaaaeaaaaaa
daaaaaaammacaaaacmahaaaakaahaaaaebgpgodjjeacaaaajeacaaaaaaacpppp
gaacaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaafaaaaaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaaamaaaaaeaea
aaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaacplabpaaaaacaaaaaaiaabaaadla
bpaaaaacaaaaaajaaaaiapkaacaaaaadaaaaadiaabaaoelaadaaoekaecaaaaad
aaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpiaabaaoelaaaaioekaacaaaaad
aaaacbiaaaaaffiaaaaaaaiaacaaaaadaaaacbiaaaaakkiaaaaaaaiaacaaaaad
aaaadbiaaaaappiaaaaaaaiaacaaaaadaaaaabiaaaaaaaiaadaakkkbacaaaaad
aaaaaciaadaakkkbadaappkaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaabbia
aaaaffiaaaaaaaiaaeaaaaaeaaaaaciaaaaaaaiaafaaaakaafaaffkaafaaaaad
aaaaabiaaaaaaaiaaaaaaaiaafaaaaadaaaaabiaaaaaaaiaaaaaffiaafaaaaad
aaaacbiaaaaaaaiaaeaappkaabaaaaacacaaciiaaaaaaaibabaaaaacaaaaaeia
afaakkkaaeaaaaaeaaaaaciaabaaaaiaaaaaffkbaaaakkiaabaaaaacabaabbia
abaaaaiaacaaaaadaaaaaeiaabaaaaiaacaaffkbafaaaaadaaaacciaaaaaffia
aaaaaakaafaaaaadaaaabciaaaaaffiaabaappkabcaaaaaeabaachiaaaaaffia
abaaoekaaaaaoelaacaaaaadaaaaaciaacaaffkbacaaaakaagaaaaacaaaaacia
aaaaffiaafaaaaadaaaabciaaaaaffiaaaaakkiaaeaaaaaeaaaaaeiaaaaaffia
afaaaakaafaaffkaafaaaaadaaaaaciaaaaaffiaaaaaffiaafaaaaadaaaaccia
aaaaffiaaaaakkiaafaaaaadabaaciiaaaaaffiaaaaapplaabaaaaacacaachia
aeaaoekbacaaaaadacaacpiaacaaoeiaabaaoeiaaeaaaaaeaaaaciiaabaappia
acaappiaaaaaaaiaaeaaaaaeaaaachiaabaappiaacaaoeiaaeaaoekaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcfiaeaaaaeaaaaaaabgabaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaaaaaaaidcaabaaaaaaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaaaacaaaahbcaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaaaaaaaaaackiacaia
ebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaakccaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaa
dicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiicaabaaa
aaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaaaaaaaaakbcaabaaa
abaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaaakiacaaaaaaaaaaaadaaaaaa
aoaaaaakbcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
akaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgcaaaafccaabaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaalecaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaabkiacaaaaaaaaaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaiecaabaaaabaaaaaackaabaaaabaaaaaa
akiacaaaaaaaaaaaabaaaaaadicaaaaiecaabaaaabaaaaaackaabaaaabaaaaaa
dkiacaaaaaaaaaaaacaaaaaaaaaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaa
bkiacaiaebaaaaaaaaaaaaaaadaaaaaadicaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaaabaaaaaadkbabaaa
abaaaaaaaaaaaaajlcaabaaaabaaaaaaegbibaiaebaaaaaaabaaaaaaegiicaaa
aaaaaaaaacaaaaaadcaaaaajhcaabaaaacaaaaaakgakbaaaabaaaaaaegadbaaa
abaaaaaaegbcbaaaabaaaaaadgaaaaaghcaabaaaaaaaaaaaegiccaaaaaaaaaaa
afaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaa
acaaaaaadcaaaaajpccabaaaaaaaaaaapgapbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "VertexLit"
}