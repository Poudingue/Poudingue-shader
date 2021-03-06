#version 120

varying vec3 tintColor;
varying vec3 normal;
varying float depth;

varying vec4 texcoord;
varying vec4 lm_coord;

void main(){
    gl_Position = ftransform();
    depth = 1 - pow(.99, gl_Position.z);

    texcoord  = gl_MultiTexCoord0;
    lm_coord  = gl_MultiTexCoord1;
    tintColor = gl_Color.rgb;
    normal = normalize(gl_NormalMatrix * gl_Normal);
}
