Shader "Custom/DistanceFieldMultiChannel" {
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
Bind "texcoord1" TexCoord1
Vector 5 [_MainTex_ST]
"!!ARBvp1.0
# 17 ALU
PARAM c[7] = { { 256, 512, 768, 1024 },
		state.matrix.mvp,
		program.local[5],
		{ 1 } };
TEMP R0;
TEMP R1;
SGE R0.x, c[0], vertex.texcoord[1];
SGE R0.y, c[0], vertex.texcoord[1].x;
ADD R0.w, -R0.x, c[6].x;
ADD R1.x, -R0.y, c[6];
SGE R0.z, c[0], vertex.texcoord[1].x;
MUL result.texcoord[1].x, R0.z, R1;
MUL result.texcoord[1].y, R0, R0.w;
ADD R0.z, -R0, c[6].x;
SGE R0.y, c[0].w, vertex.texcoord[1].x;
MOV result.color, vertex.color;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MUL result.texcoord[1].z, R0.y, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
MOV result.texcoord[1].w, R0.x;
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
; 17 ALU
def c5, 256.00000000, 512.00000000, 768.00000000, 1024.00000000
def c6, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
sge r0.x, c5, v3
sge r0.y, c5, v3.x
add r0.w, -r0.x, c6.x
add r1.x, -r0.y, c6
sge r0.z, c5, v3.x
mul oT1.x, r0.z, r1
mul oT1.y, r0, r0.w
add r0.z, -r0, c6.x
sge r0.y, c5.w, v3.x
mov oD0, v1
mad oT0.xy, v2, c4, c4.zwzw
mul oT1.z, r0.y, r0
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT1.w, r0.x
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedkjojkeggopglihkikdimjjklicpfeoegabaaaaaafeadaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahhaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapabaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcamacaaaaeaaaabaaidaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadbcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaa
aaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaabnaaaaakpcaabaaaaaaaaaaa
aceaaaaaaaaaiaedaaaaaaeeaaaaeaeeaaaaiaeeagbabaaaadaaaaaaabaaaaak
hcaabaaaabaaaaaaggalbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadhaaaaamhccabaaaadaaaaaabgagbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaaaabaaaaaaabaaaaahiccabaaaadaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 112
Vector 96 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedilpbfgbalhhmlhmlhpfehnjfkhobdlchabaaaaaanaaeaaaaaeaaaaaa
daaaaaaakiabaaaalmadaaaaeeaeaaaaebgpgodjhaabaaaahaabaaaaaaacpopp
daabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaagaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaiaedaaaaaaeeaaaaeaeeaaaaiaeefbaaaaafahaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
abaaadoaacaaoejaabaaoekaabaaookaanaaaaadaaaaapiaagaaoekaadaaaaja
acaaaaadabaaahiaaaaaobibahaaaakaafaaaaadacaaahoaaaaapgiaabaaoeia
abaaaaacacaaaioaaaaaaaiaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaae
aaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaapoa
abaaoejappppaaaafdeieefcamacaaaaeaaaabaaidaaaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
bcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaabaaaaaaegbobaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaabnaaaaak
pcaabaaaaaaaaaaaaceaaaaaaaaaiaedaaaaaaeeaaaaeaeeaaaaiaeeagbabaaa
adaaaaaaabaaaaakhcaabaaaabaaaaaaggalbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadhaaaaamhccabaaaadaaaaaabgagbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaabaaaaaaabaaaaah
iccabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaahbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahhaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapadaaaahhaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapabaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedep
epfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaakl"
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
# 38 ALU, 2 TEX
PARAM c[6] = { program.local[0..4],
		{ 3, 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.texcoord[1];
ADD R1.x, R1, R1.y;
ADD R1.x, R1, R1.z;
ADD R2.y, R1.x, R1.w;
ADD R0.xy, fragment.texcoord[0], c[3];
ADD R1.y, c[2].x, -c[2];
MOV_SAT R1.x, R2.y;
RCP R1.y, R1.y;
ADD R1.x, R1, -c[2].y;
MUL_SAT R1.x, R1, R1.y;
MAD R1.y, -R1.x, c[5], c[5].x;
MUL R1.x, R1, R1;
MUL R2.x, R1, R1.y;
MUL R2.x, fragment.color.primary.w, R2;
TEX R0, R0, texture[0], 2D;
MUL R1, fragment.texcoord[1], R0;
ADD R0.x, R1, R1.y;
ADD R0.x, R0, R1.z;
ADD_SAT R0.x, R0, R1.w;
ADD R0.y, c[3].w, -c[3].z;
RCP R0.y, R0.y;
ADD R0.x, R0, -c[3].z;
MUL_SAT R0.x, R0, R0.y;
MAD R0.y, -R0.x, c[5], c[5].x;
MUL R0.x, R0, R0;
MUL R0.x, R0, R0.y;
MUL R0.z, -R2.y, c[0].y;
ADD R0.y, R0.z, c[5].z;
MUL R1.x, R0.y, c[0];
MUL R1.w, R0.x, c[4];
MUL_SAT R1.x, R1, c[1].w;
ADD R0.xyz, -fragment.color.primary, c[1];
MAD R0.xyz, R1.x, R0, fragment.color.primary;
MOV R1.xyz, c[4];
MOV R0.w, R2.x;
ADD R0, R0, -R1;
MAD result.color, R2.x, R0, R1;
END
# 38 instructions, 3 R-regs
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
; 37 ALU, 2 TEX
dcl_2d s0
def c5, 2.00000000, 3.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
dcl t1
texld r0, t0, s0
add r1.xy, t0, c3
mul r0, r0, t1
add_pp r0.x, r0, r0.y
add r2.x, c2, -c2.y
add_pp r0.x, r0, r0.z
rcp r2.x, r2.x
texld r3, r1, s0
add_pp r1.x, r0, r0.w
mov_pp_sat r0.x, r1
add r0.x, r0, -c2.y
mul_sat r2.x, r0, r2
mul r0.x, r2, r2
mad r2.x, -r2, c5, c5.y
mul r0.x, r0, r2
mul r2, t1, r3
add_pp r2.x, r2, r2.y
add_pp r3.x, r2, r2.z
add_pp_sat r3.x, r3, r2.w
mul_pp r0.x, v0.w, r0
add r2.x, c3.w, -c3.z
mul r1.x, -r1, c0.y
add r1.x, r1, c5.z
mul r1.x, r1, c0
mov_pp r1.w, r0.x
add r3.x, r3, -c3.z
rcp r2.x, r2.x
mul_sat r2.x, r3, r2
mad r3.x, -r2, c5, c5.y
mul r2.x, r2, r2
mul r2.x, r2, r3
mul r2.w, r2.x, c4
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
eefiecednakdphkjeocdlnacminondcocnllmghfabaaaaaaaeagaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaafaaaaeaaaaaaaeeabaaaafjaaaaae
egiocaaaaaaaaaaaagaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aaaaaaaidcaabaaaaaaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegbabaaaadaaaaaa
aaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaackbabaaaadaaaaaaakaabaaaaaaaaaaa
dccaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaadaaaaaaakaabaaa
aaaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaiaebaaaaaa
aaaaaaaaaeaaaaaaaaaaaaakccaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaa
aeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaabaaaaaa
egaabaaaabaaaaaaegbabaaaadaaaaaaaaaaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaabaaaaaa
ckbabaaaadaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
abaaaaaadkbabaaaadaaaaaaakaabaaaabaaaaaadcaaaaalccaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaiadp
dgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaaabaaaaaadicaaaaiccaabaaa
abaaaaaabkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaaaaaaaaajhcaabaaa
acaaaaaaegbcbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadcaaaaaj
hcaabaaaacaaaaaafgafbaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaabaaaaaa
aaaaaaakccaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaadaaaaaaakiacaaa
aaaaaaaaadaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaaabaaaaaadkbabaaa
abaaaaaadgaaaaaghcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaacaaaaaadcaaaaaj
pccabaaaaaaaaaaapgapbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
doaaaaab"
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
eefiecedjjjebnhabgpbpohbaihaanjhlkiaccmfabaaaaaabaajaaaaaeaaaaaa
daaaaaaadiadaaaafaaiaaaanmaiaaaaebgpgodjaaadaaaaaaadaaaaaaacpppp
mmacaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaabaaafaaaaaaaaaaaaaaaaacppppfbaaaaafafaaapkaaaaaaamaaaaaeaea
aaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaacplabpaaaaacaaaaaaiaabaaadla
bpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapkaacaaaaadaaaaadia
abaaoelaadaaoekaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpia
abaaoelaaaaioekaafaaaaadaaaacdiaaaaaoeiaacaaoelaacaaaaadaaaacbia
aaaaffiaaaaaaaiaaeaaaaaeaaaacbiaaaaakkiaacaakklaaaaaaaiaaeaaaaae
aaaadbiaaaaappiaacaapplaaaaaaaiaacaaaaadaaaaabiaaaaaaaiaadaakkkb
acaaaaadaaaaaciaadaakkkbadaappkaagaaaaacaaaaaciaaaaaffiaafaaaaad
aaaabbiaaaaaffiaaaaaaaiaaeaaaaaeaaaaaciaaaaaaaiaafaaaakaafaaffka
afaaaaadaaaaabiaaaaaaaiaaaaaaaiaafaaaaadaaaaabiaaaaaaaiaaaaaffia
afaaaaadaaaacbiaaaaaaaiaaeaappkaabaaaaacacaaciiaaaaaaaibafaaaaad
aaaacgiaabaanciaacaanclaacaaaaadaaaacciaaaaakkiaaaaaffiaaeaaaaae
aaaacciaabaakkiaacaakklaaaaaffiaaeaaaaaeaaaacciaabaappiaacaappla
aaaaffiaabaaaaacaaaaaeiaafaakkkaaeaaaaaeaaaaaeiaaaaaffiaaaaaffkb
aaaakkiaabaaaaacaaaabciaaaaaffiaacaaaaadaaaaaciaaaaaffiaacaaffkb
afaaaaadaaaaceiaaaaakkiaaaaaaakaafaaaaadaaaabeiaaaaakkiaabaappka
bcaaaaaeabaachiaaaaakkiaabaaoekaaaaaoelaacaaaaadaaaaaeiaacaaffkb
acaaaakaagaaaaacaaaaaeiaaaaakkiaafaaaaadaaaabciaaaaakkiaaaaaffia
aeaaaaaeaaaaaeiaaaaaffiaafaaaakaafaaffkaafaaaaadaaaaaciaaaaaffia
aaaaffiaafaaaaadaaaacciaaaaaffiaaaaakkiaafaaaaadabaaciiaaaaaffia
aaaapplaabaaaaacacaachiaaeaaoekbacaaaaadacaacpiaacaaoeiaabaaoeia
aeaaaaaeaaaaciiaabaappiaacaappiaaaaaaaiaaeaaaaaeaaaachiaabaappia
acaaoeiaaeaaoekaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbaafaaaa
eaaaaaaaeeabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaaaaaaaidcaabaaaaaaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegbabaaaadaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaackbabaaa
adaaaaaaakaabaaaaaaaaaaadccaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkbabaaaadaaaaaaakaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackiacaiaebaaaaaaaaaaaaaaaeaaaaaaaaaaaaakccaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaaaoaaaaak
ccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaa
aaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
icaabaaaaaaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaaafaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaaegbabaaaadaaaaaaaaaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaackaabaaaabaaaaaackbabaaaadaaaaaaakaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaadkaabaaaabaaaaaadkbabaaaadaaaaaaakaabaaaabaaaaaa
dcaaaaalccaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaabkiacaaaaaaaaaaa
abaaaaaaabeaaaaaaaaaiadpdgcaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
adaaaaaadiaaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
abaaaaaadicaaaaiccaabaaaabaaaaaabkaabaaaabaaaaaadkiacaaaaaaaaaaa
acaaaaaaaaaaaaajhcaabaaaacaaaaaaegbcbaiaebaaaaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadcaaaaajhcaabaaaacaaaaaafgafbaaaabaaaaaaegacbaaa
acaaaaaaegbcbaaaabaaaaaaaaaaaaakccaabaaaabaaaaaabkiacaiaebaaaaaa
aaaaaaaaadaaaaaaakiacaaaaaaaaaaaadaaaaaaaoaaaaakccaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaadicaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahicaabaaaacaaaaaa
akaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaghcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaa
egaobaaaacaaaaaadcaaaaajpccabaaaaaaaaaaapgapbaaaacaaaaaaegaobaaa
abaaaaaaegaobaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "VertexLit"
}