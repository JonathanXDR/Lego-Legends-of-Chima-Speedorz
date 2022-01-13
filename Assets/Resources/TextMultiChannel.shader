Shader "Custom/TextMultiChannel" {
Properties {
 _MainTex ("Texture", 2D) = "white" {}
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
ConstBuffer "$Globals" 32
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgoioekaoihkcbeaglfidegjlghagoijeabaaaaaafeadaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahhaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapabaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcamacaaaaeaaaabaaidaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
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
aaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaabnaaaaakpcaabaaaaaaaaaaa
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
ConstBuffer "$Globals" 32
Vector 16 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedgcjmdajedbhlbpnoeaghmfljchfhbnpnabaaaaaanaaeaaaaaeaaaaaa
daaaaaaakiabaaaalmadaaaaeeaeaaaaebgpgodjhaabaaaahaabaaaaaaacpopp
daabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
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
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
bcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaabaaaaaaegbobaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
acaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaabnaaaaak
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
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 7 ALU, 1 TEX
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.texcoord[1];
ADD R0.x, R0, R0.y;
ADD R0.x, R0, R0.z;
ADD R0.x, R0, R0.w;
MUL result.color.w, fragment.color.primary, R0.x;
MOV result.color.xyz, fragment.color.primary;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 7 ALU, 1 TEX
dcl_2d s0
dcl v0
dcl t0.xy
dcl t1
texld r0, t0, s0
mul r0, r0, t1
add_pp r0.x, r0, r0.y
add_pp r0.x, r0, r0.z
add_pp r0.x, r0, r0.w
mul r0.w, v0, r0.x
mov_pp r0.xyz, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedhldikggigbeigmmooojobalbkbccabnmabaaaaaaciacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcdeabaaaaeaaaaaaaenaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegbabaaaadaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaa
ckbabaaaadaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaa
akaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaafhccabaaaaaaaaaaaegbcbaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedocmonblfolmlldgpbmcaeeggbaookcilabaaaaaabeadaaaaaeaaaaaa
daaaaaaabiabaaaafeacaaaaoaacaaaaebgpgodjoaaaaaaaoaaaaaaaaaacpppp
liaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaac
aaaaaaiaacaaaplabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaabaaoela
aaaioekaafaaaaadaaaacdiaaaaaoeiaacaaoelaacaaaaadaaaacbiaaaaaffia
aaaaaaiaaeaaaaaeaaaacbiaaaaakkiaacaakklaaaaaaaiaaeaaaaaeaaaacbia
aaaappiaacaapplaaaaaaaiaafaaaaadaaaaciiaaaaaaaiaaaaapplaabaaaaac
aaaachiaaaaaoelaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdeabaaaa
eaaaaaaaenaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegbabaaaadaaaaaaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaackaabaaaaaaaaaaackbabaaaadaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaadaaaaaaakaabaaaaaaaaaaa
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