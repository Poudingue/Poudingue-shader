#version 120

const int RGBA16        = 1;
const int gcolorFormat  = RGBA16;
const int gnormalFormat = RGBA16;
const int gdepthFormat  = RGBA16;

uniform sampler2D gcolor ;
uniform sampler2D gnormal;
uniform sampler2D gdepth ;

varying vec3 tintColor;

void main(){
    gl_FragData[0] = vec4(tintColor,1);
    gl_FragData[1] = vec4(vec3(0),1);
}
