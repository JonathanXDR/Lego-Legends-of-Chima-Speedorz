Shader "Custom/BlendShader x3" {
Properties {
 _MainTex ("Base texture", 2D) = "white" {}
 _Texture1 ("Texture 1", 2D) = "white" {}
 _Texture2 ("Texture 2", 2D) = "white" {}
 _Texture4 ("Texture 4", 2D) = "white" {}
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
 Pass {
  Tags { "QUEUE"="Geometry" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [unity_LightmapST]
"!!ARBvp1.0
# 7 ALU
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
MOV result.color, vertex.color;
MOV result.texcoord[0].xy, vertex.texcoord[0];
MAD result.texcoord[1].xy, vertex.texcoord[1], c[5], c[5].zwzw;
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
Vector 4 [unity_LightmapST]
"vs_2_0
; 7 ALU
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dcl_color0 v3
mov oD0, v3
mov oT0.xy, v1
mad oT1.xy, v2, c4, c4.zwzw
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
Vector 32 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedaaafhbglagkmcfdigpmhhbigfejmhigjabaaaaaammacaaaaadaaaaaa
cmaaaaaaleaaaaaaeaabaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaahbaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafaepfdej
feejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaabaaaaaaamadaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaakl
fdeieefcieabaaaaeaaaabaagbaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaadpcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
mccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaacaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaaaaaaaaaaacaaaaaa
dgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadgaaaaafpccabaaaacaaaaaa
egbobaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 64
Vector 32 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefieceddenoejbjcbajnelnkjejgefhaldaaaecabaaaaaaoiadaaaaaeaaaaaa
daaaaaaaeiabaaaaneacaaaafmadaaaaebgpgodjbaabaaaabaabaaaaaaacpopp
naaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
bpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaamoaacaabejaabaabekaabaaleka
afaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoejaabaaaaacabaaapoa
adaaoejappppaaaafdeieefcieabaaaaeaaaabaagbaaaaaafjaaaaaeegiocaaa
aaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaafpaaaaad
pcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaadmccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaacaaaaaaagiecaaaaaaaaaaaacaaaaaakgiocaaa
aaaaaaaaacaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadgaaaaaf
pccabaaaacaaaaaaegbobaaaadaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaahbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaahbaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapadaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apapaaaafaepfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaabaaaaaaamadaaaahnaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaedepemepfcaakl"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_Texture4] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 15 ALU, 5 TEX
PARAM c[1] = { { 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[1], texture[4], 2D;
TEX R4, fragment.texcoord[0], texture[3], 2D;
TEX R3, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[0], texture[2], 2D;
TEX R2, fragment.texcoord[0], texture[1], 2D;
ADD R3, R3, -R4;
MAD R3, fragment.color.primary.w, R3, R4;
ADD R2, R2, -R3;
MAD R2, fragment.color.primary.x, R2, R3;
ADD R1, R1, -R2;
MAD R1, fragment.color.primary.y, R1, R2;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[0].x;
MOV result.color.w, R1;
END
# 15 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_Texture1] 2D 1
SetTexture 2 [_Texture2] 2D 2
SetTexture 3 [_Texture4] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"ps_2_0
; 10 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c0, 8.00000000, 0, 0, 0
dcl t0.xy
dcl v0.xyzw
dcl t1.xy
texld r4, t1, s4
texld r3, t0, s2
texld r2, t0, s1
texld r0, t0, s3
texld r1, t0, s0
add_pp r1, r1, -r0
mad_pp r0, v0.w, r1, r0
add_pp r1, r2, -r0
mad_pp r0, v0.x, r1, r0
add_pp r1, r3, -r0
mad_pp r0, v0.y, r1, r0
mul_pp r1.xyz, r4.w, r4
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Texture1] 2D 2
SetTexture 2 [_Texture2] 2D 3
SetTexture 3 [_Texture4] 2D 4
SetTexture 4 [unity_Lightmap] 2D 0
"ps_4_0
eefiecedppfjjjiklegaanledfhjjnehpefhaghjabaaaaaakmadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
amamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaedepemepfcaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcliacaaaaeaaaaaaakoaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadmcbabaaaabaaaaaa
gcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaaeaaaaaaaaaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaia
ebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaapgbpbaaaacaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaia
ebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaaagbabaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaaaaaaaaaipcaabaaa
abaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaajpcaabaaa
aaaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_Texture1] 2D 2
SetTexture 2 [_Texture2] 2D 3
SetTexture 3 [_Texture4] 2D 4
SetTexture 4 [unity_Lightmap] 2D 0
"ps_4_0_level_9_1
eefiecedahdbmeclimfdlfnfmjaffcmnbldgngffabaaaaaadiafaaaaaeaaaaaa
daaaaaaaliabaaaahiaeaaaaaeafaaaaebgpgodjiaabaaaaiaabaaaaaaacpppp
eiabaaaadiaaaaaaaaaadiaaaaaadiaaaaaadiaaafaaceaaaaaadiaaaeaaaaaa
aaababaaabacacaaacadadaaadaeaeaaaaacppppfbaaaaafaaaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapka
abaaaaacaaaaadiaaaaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaaaaaoelaabaioekaecaaaaadacaacpiaaaaaoelaaeaioekaecaaaaad
adaacpiaaaaaoelaacaioekaecaaaaadaeaacpiaaaaaoelaadaioekaafaaaaad
aaaaciiaaaaappiaaaaaaakaafaaaaadaaaachiaaaaaoeiaaaaappiabcaaaaae
afaaapiaabaapplaabaaoeiaacaaoeiabcaaaaaeabaaapiaabaaaalaadaaoeia
afaaoeiabcaaaaaeacaacpiaabaafflaaeaaoeiaabaaoeiaafaaaaadacaachia
aaaaoeiaacaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcliacaaaa
eaaaaaaakoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadmcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaadaaaaaaaagabaaaaeaaaaaaaaaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaiaebaaaaaaabaaaaaadcaaaaajpcaabaaaaaaaaaaa
pgbpbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaabaaaaaadcaaaaaj
pcaabaaaaaaaaaaaagbabaaaacaaaaaaegaobaaaabaaaaaaegaobaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
adaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaajpcaabaaaaaaaaaaafgbfbaaaacaaaaaaegaobaaaabaaaaaa
egaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaa
aeaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaabaaaaaaamamaaaahnaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaedepem
epfcaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Diffuse"
}