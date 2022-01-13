Shader "Custom/DistanceFieldMultiChannel_Mobile" {
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
Vector 0 [_Edge]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 16 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0.1, 3, 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.texcoord[1];
ADD R0.x, R0, R0.y;
ADD R0.x, R0, R0.z;
MOV R1.x, c[1];
ADD R0.y, R1.x, c[0];
ADD R0.z, -R0.y, c[0].x;
ADD_SAT R0.x, R0, R0.w;
ADD R0.x, R0, -R0.y;
RCP R0.z, R0.z;
MUL_SAT R0.x, R0, R0.z;
MAD R0.y, -R0.x, c[1].z, c[1];
MUL R0.x, R0, R0;
MUL_SAT R0.x, R0, R0.y;
MUL result.color.w, fragment.color.primary, R0.x;
MOV result.color.xyz, fragment.color.primary;
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Edge]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 16 ALU, 1 TEX
dcl_2d s0
def c1, 0.10000000, 2.00000000, 3.00000000, 0
dcl v0
dcl t0.xy
dcl t1
texld r0, t0, s0
mul r1, r0, t1
add_pp r1.x, r1, r1.y
add_pp r2.x, r1, r1.z
mov r0.y, c0
add r0.x, c1, r0.y
add r1.x, -r0, c0
add_pp_sat r2.x, r2, r1.w
add r0.x, r2, -r0
rcp r1.x, r1.x
mul_sat r1.x, r0, r1
mad r0.x, -r1, c1.y, c1.z
mul r1.x, r1, r1
mul_sat r0.x, r1, r0
mov_pp r1.xyz, v0
mul_pp r1.w, v0, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 48 [_Edge]
BindCB  "$Globals" 0
"ps_4_0
eefiecedencaihakmelneoojmdipeihpopgegofhabaaaaaafiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcgeacaaaaeaaaaaaajjaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegbabaaaadaaaaaa
aaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaackaabaaaaaaaaaaackbabaaaadaaaaaaakaabaaaaaaaaaaa
dccaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaadaaaaaaakaabaaa
aaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaa
mnmmmmdnaaaaaaaibcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaajccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaa
aaaaaaaaadaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaa
dgaaaaafhccabaaaaaaaaaaaegbcbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 48 [_Edge]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedojmbbiajljnhkfchdddmbcambleoblhhabaaaaaapeaeaaaaaeaaaaaa
daaaaaaamiabaaaadeaeaaaamaaeaaaaebgpgodjjaabaaaajaabaaaaaaacpppp
fmabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkamnmmmmdnaaaaaama
aaaaeaeaaaaaaaaabpaaaaacaaaaaaiaaaaacplabpaaaaacaaaaaaiaabaaadla
bpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpia
abaaoelaaaaioekaafaaaaadaaaacdiaaaaaoeiaacaaoelaacaaaaadaaaacbia
aaaaffiaaaaaaaiaaeaaaaaeaaaacbiaaaaakkiaacaakklaaaaaaaiaaeaaaaae
aaaabbiaaaaappiaacaapplaaaaaaaiaabaaaaacabaaaiiaabaaaakaacaaaaad
aaaaaciaabaappiaaaaaffkaacaaaaadaaaaabiaaaaaffibaaaaaaiaacaaaaad
aaaaaciaaaaaffibaaaaaakaagaaaaacaaaaaciaaaaaffiaafaaaaadaaaabbia
aaaaffiaaaaaaaiaaeaaaaaeaaaaaciaaaaaaaiaabaaffkaabaakkkaafaaaaad
aaaaabiaaaaaaaiaaaaaaaiaafaaaaadaaaadbiaaaaaaaiaaaaaffiaafaaaaad
aaaaciiaaaaaaaiaaaaapplaabaaaaacaaaachiaaaaaoelaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcgeacaaaaeaaaaaaajjaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegbabaaaadaaaaaaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaackbabaaaadaaaaaaakaabaaaaaaaaaaadccaaaaj
bcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaadaaaaaaakaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaamnmmmmdn
aaaaaaaibcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaajccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaakiacaaaaaaaaaaa
adaaaaaaaoaaaaakccaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahiccabaaaaaaaaaaaakaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
hccabaaaaaaaaaaaegbcbaaaabaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apapaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "VertexLit"
}