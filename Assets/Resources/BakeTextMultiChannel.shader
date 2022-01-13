Shader "Custom/BakeTextMultiChannel" {
Properties {
 _MainTex ("Texture", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  Blend One One
 BlendOp Max
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_MainTex_ST]
"!!ARBvp1.0
# 16 ALU
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
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MUL result.texcoord[1].z, R0.y, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
MOV result.texcoord[1].w, R0.x;
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
; 16 ALU
def c5, 256.00000000, 512.00000000, 768.00000000, 1024.00000000
def c6, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
sge r0.x, c5, v2
sge r0.y, c5, v2.x
add r0.w, -r0.x, c6.x
add r1.x, -r0.y, c6
sge r0.z, c5, v2.x
mul oT1.x, r0.z, r1
mul oT1.y, r0, r0.w
add r0.z, -r0, c6.x
sge r0.y, c5.w, v2.x
mad oT0.xy, v1, c4, c4.zwzw
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
eefiecedcjlbbecbchdjdfikoekijgpkaockhikcabaaaaaaciadaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahhaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapabaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcoaabaaaaeaaaabaahiaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaacaaaaaafpaaaaadbcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaacaaaaaaegiacaaaaaaaaaaaabaaaaaaogikcaaa
aaaaaaaaabaaaaaabnaaaaakpcaabaaaaaaaaaaaaceaaaaaaaaaiaedaaaaaaee
aaaaeaeeaaaaiaeeagbabaaaadaaaaaaabaaaaakhcaabaaaabaaaaaaggalbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadhaaaaamhccabaaa
adaaaaaabgagbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
egacbaaaabaaaaaaabaaaaahiccabaaaadaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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
eefiecedkpkphganfnfnjbkbaappeddkpodemcjnabaaaaaaimaeaaaaaeaaaaaa
daaaaaaajaabaaaahiadaaaaaaaeaaaaebgpgodjfiabaaaafiabaaaaaaacpopp
biabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
agaaapkaaaaaiaedaaaaaaeeaaaaeaeeaaaaiaeefbaaaaafahaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeabaaadoaacaaoejaabaaoeka
abaaookaanaaaaadaaaaapiaagaaoekaadaaaajaacaaaaadabaaahiaaaaaobib
ahaaaakaafaaaaadacaaahoaaaaapgiaabaaoeiaabaaaaacacaaaioaaaaaaaia
afaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefcoaabaaaaeaaaabaahiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadbcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaabnaaaaakpcaabaaa
aaaaaaaaaceaaaaaaaaaiaedaaaaaaeeaaaaeaeeaaaaiaeeagbabaaaadaaaaaa
abaaaaakhcaabaaaabaaaaaaggalbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadhaaaaamhccabaaaadaaaaaabgagbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaabaaaaaaabaaaaahiccabaaa
adaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
hbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahhaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapadaaaahhaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapabaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaa
epfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
# 5 ALU, 1 TEX
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.texcoord[1];
ADD R0.x, R0, R0.y;
ADD R0.x, R0, R0.z;
ADD result.color, R0.x, R0.w;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
; 6 ALU, 1 TEX
dcl_2d s0
dcl t0.xy
dcl t1
texld r0, t0, s0
mul r0, r0, t1
add_pp r0.x, r0, r0.y
add_pp r0.x, r0, r0.z
add_pp r0.x, r0, r0.w
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedechcjdndpfkhgheoekddhcjipbdpghfhabaaaaaaomabaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpiaaaaaaeaaaaaaadoaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegbabaaa
adaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaackbabaaaadaaaaaaakaabaaa
aaaaaaaadcaaaaajpccabaaaaaaaaaaapgapbaaaaaaaaaaapgbpbaaaadaaaaaa
agaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefieceddiohfgnaakoadfghfmafadhekkndoepnabaaaaaalaacaaaaaeaaaaaa
daaaaaaapaaaaaaapaabaaaahmacaaaaebgpgodjliaaaaaaliaaaaaaaaacpppp
jaaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkaecaaaaadaaaacpiaabaaoelaaaaioekaafaaaaadaaaacdia
aaaaoeiaacaaoelaacaaaaadaaaacbiaaaaaffiaaaaaaaiaaeaaaaaeaaaacbia
aaaakkiaacaakklaaaaaaaiaaeaaaaaeaaaacpiaaaaappiaacaapplaaaaaaaia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpiaaaaaaeaaaaaaadoaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egbabaaaadaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaackbabaaaadaaaaaa
akaabaaaaaaaaaaadcaaaaajpccabaaaaaaaaaaapgapbaaaaaaaaaaapgbpbaaa
adaaaaaaagaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
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