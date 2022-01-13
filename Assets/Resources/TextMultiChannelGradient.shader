Shader "Custom/TextMultiChannelGradient" {
Properties {
 _MainTex ("Texture", 2D) = "white" {}
 _GradientMap ("Texture", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_MainTex_ST]
"!!ARBvp1.0
# 25 ALU
PARAM c[7] = { { 256, 512, 768, 1024 },
		state.matrix.mvp,
		program.local[5],
		{ 1, 0 } };
TEMP R0;
TEMP R1;
SGE R0.x, c[0], vertex.texcoord[1];
SGE R0.z, c[0].y, vertex.texcoord[1].x;
ADD R0.y, -R0.x, c[6].x;
MUL R0.y, R0.z, R0;
ADD R0.w, -R0.z, c[6].x;
SGE R0.z, c[0], vertex.texcoord[1].x;
MUL R1.x, R0.z, R0.w;
ADD R0.w, -R0.z, c[6].x;
MAD R1.y, -R0, c[0].x, vertex.texcoord[1].x;
SGE R0.z, c[0].w, vertex.texcoord[1].x;
MUL R0.z, R0, R0.w;
MAD R1.y, -R1.x, c[0], R1;
MAD R0.w, -R0.z, c[0].z, R1.y;
MOV R1.y, R0;
MOV R1.w, R0.x;
MOV R1.z, R0;
MOV result.texcoord[1], R1;
ADD result.color.y, R0.w, -c[6].x;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
MOV result.color.x, vertex.texcoord[1].y;
MOV result.color.z, c[6].y;
END
# 25 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
; 24 ALU
def c5, 256.00000000, 512.00000000, 768.00000000, 1024.00000000
def c6, 1.00000000, -1.00000000, 0.00000000, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
sge r0.z, c5.x, v2.x
sge r0.w, c5.z, v2.x
add r0.y, -r0.z, c6.x
sge r0.x, c5.y, v2
mul r0.y, r0.x, r0
add r0.x, -r0, c6
mul r0.x, r0.w, r0
mad r1.x, -r0.y, c5, v2
mad r1.y, -r0.x, c5, r1.x
add r1.x, -r0.w, c6
sge r0.w, c5, v2.x
mul r1.x, r0.w, r1
mov r0.w, r0.z
mad r1.y, -r1.x, c5.z, r1
mov r0.z, r1.x
mov oT1, r0
add oD0.y, r1, c6
mad oT0.xy, v1, c4, c4.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oD0.x, v2.y
mov oD0.z, c6
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 32
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedkjchmocpinfnnpbolepidckkamggijkcabaaaaaaaaaeaaaaadaaaaaa
cmaaaaaaliaaaaaaeeabaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahjaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaafaepfdej
feejepeoaafeebeoehefeofeaafeeffiedepepfceeaaklklepfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklfdeieefcleacaaaaeaaaabaaknaaaaaafjaaaaaeegiocaaaaaaaaaaa
acaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabnaaaaakpcaabaaaaaaaaaaaaceaaaaaaaaaiaed
aaaaaaeeaaaaeaeeaaaaiaeeagbabaaaadaaaaaaabaaaaakpcaabaaaabaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdhaaaaam
hcaabaaaaaaaaaaabgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaggalbaaaabaaaaaadgaaaaaficcabaaaadaaaaaaakaabaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiaed
akbabaaaadaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaaeedkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaeaeedkaabaaaaaaaaaaadgaaaaafhccabaaa
adaaaaaaegacbaaaaaaaaaaaaaaaaaahcccabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaialpdgaaaaafbccabaaaabaaaaaabkbabaaaadaaaaaadgaaaaaf
eccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 32
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedaeojfmjgckjecpnecjeppnkhhdaefiilabaaaaaamaafaaaaaeaaaaaa
daaaaaaaomabaaaakiaeaaaadeafaaaaebgpgodjleabaaaaleabaaaaaaacpopp
heabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaiaedaaaaaaeeaaaaeaeeaaaaiaeefbaaaaafahaaapkaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeabaaadoaacaaoejaabaaoeka
abaaookaanaaaaadaaaaapiaagaaoekaadaaaajaacaaaaadabaaahiaaaaaobib
ahaaaakaafaaaaadaaaaaoiaaaaaniiaabaajaiaabaaaaacacaaapoaaaaadjia
aeaaaaaeaaaaabiaaaaakkiaagaaaakbadaaaajaaeaaaaaeaaaaabiaaaaaffia
agaaffkbaaaaaaiaaeaaaaaeaaaaabiaaaaappiaagaakkkbaaaaaaiaacaaaaad
aaaaacoaaaaaaaiaahaaffkaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaae
aaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaafaaaaadaaaaafoa
adaaffjaahaaoekappppaaaafdeieefcleacaaaaeaaaabaaknaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabnaaaaakpcaabaaaaaaaaaaa
aceaaaaaaaaaiaedaaaaaaeeaaaaeaeeaaaaiaeeagbabaaaadaaaaaaabaaaaak
pcaabaaaabaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdhaaaaamhcaabaaaaaaaaaaabgagbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaggalbaaaabaaaaaadgaaaaaficcabaaaadaaaaaa
akaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiaedakbabaaaadaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaaaeedkaabaaaaaaaaaaadcaaaaakicaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaeaeedkaabaaaaaaaaaaa
dgaaaaafhccabaaaadaaaaaaegacbaaaaaaaaaaaaaaaaaahcccabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaialpdgaaaaafbccabaaaabaaaaaabkbabaaa
adaaaaaadgaaaaafeccabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaa
abaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaahjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapadaaaa
hjaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaafaepfdejfeejepeo
aafeebeoehefeofeaafeeffiedepepfceeaaklklepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GradientMap] 2D 1
"!!ARBfp1.0
# 7 ALU, 2 TEX
PARAM c[1] = { { 1, 0.00390625, 0 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.texcoord[1];
MUL R1.xy, fragment.color.primary, c[0];
ADD R0.x, R0, R0.y;
ADD R0.x, R0, R0.z;
ADD result.color.w, R0.x, R0;
TEX result.color.xyz, R1, texture[1], 2D;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GradientMap] 2D 1
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.00390625, 0, 0
dcl v0.xy
dcl t0.xy
dcl t1
texld r1, t0, s0
mul r0.xy, v0, c0
mul r1, r1, t1
add_pp r1.x, r1, r1.y
add_pp r1.x, r1, r1.z
texld r0, r0, s1
add_pp r0.w, r1.x, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GradientMap] 2D 1
"ps_4_0
eefiecedlcdpncpencjmkbmncgnhlkgkdbimnmhkabaaaaaaheacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefciaabaaaaeaaaaaaagaaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegbabaaaadaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaackbabaaa
adaaaaaaakaabaaaaaaaaaaadcaaaaajiccabaaaaaaaaaaadkaabaaaaaaaaaaa
dkbabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaakdcaabaaaaaaaaaaaegbabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadlaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadgaaaaaf
hccabaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GradientMap] 2D 1
"ps_4_0_level_9_1
eefiecedgkjjpkpclfamchheeofjollanhpmanghabaaaaaaimadaaaaaeaaaaaa
daaaaaaaeeabaaaammacaaaafiadaaaaebgpgodjamabaaaaamabaaaaaaacpppp
oaaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaiadpaaaaiadlaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaahlabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaafaaaaad
aaaaadiaaaaaoelaaaaaoekaecaaaaadabaacpiaabaaoelaaaaioekaecaaaaad
aaaacpiaaaaaoeiaabaioekaafaaaaadabaacdiaabaaoeiaacaaoelaacaaaaad
abaacbiaabaaffiaabaaaaiaaeaaaaaeabaacbiaabaakkiaacaakklaabaaaaia
aeaaaaaeaaaaciiaabaappiaacaapplaabaaaaiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefciaabaaaaeaaaaaaagaaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegbabaaa
adaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaackbabaaaadaaaaaaakaabaaa
aaaaaaaadcaaaaajiccabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaadaaaaaa
akaabaaaaaaaaaaadiaaaaakdcaabaaaaaaaaaaaegbabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadlaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "VertexLit"
}