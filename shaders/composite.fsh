#version 120

const int RGBA16        = 1;
const int gcolorFormat  = RGBA16;
const int gnormalFormat = RGBA16;
const int gdepthFormat  = RGBA16;

uniform sampler2D gcolor ;
uniform sampler2D gnormal;
uniform sampler2D gdepth ;

varying vec3 lightVector;
varying vec3 normal;

varying vec4 texcoord;

void main(){

    vec3 color  =  texture2D(gcolor,  texcoord.st).rgb;
    vec3 normal = texture2D(gnormal,  texcoord.st).rgb;
    float depth = texture2D(gnormal,  texcoord.st).a;
    vec4 lm     = texture2D(gdepth,   texcoord.st);

    gl_FragData[0] = vec4(color,  1);
    gl_FragData[1] = lm;
    gl_FragData[2] = vec4(normal, depth);

}
