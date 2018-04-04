#version 120

varying vec3 normal;
varying vec4 texcoord;

void main(){
    gl_Position = ftransform();
    texcoord  = gl_MultiTexCoord0;
    normal = normalize(gl_NormalMatrix * gl_Normal);
}
