#version 120

varying vec3 tintColor;
varying vec3 normal;
varying float depth;

varying vec4 texcoord;


void main(){
    gl_Position = ftransform();
    depth = 1 - pow(.99, gl_Position.z);

    texcoord  = gl_MultiTexCoord0;
    tintColor = gl_Color.rgb;
    normal = normalize(gl_NormalMatrix * gl_Normal);
}
