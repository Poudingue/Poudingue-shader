#version 120

const int RGBA16        = 1;
const int gcolorFormat  = RGBA16;
const int gnormalFormat = RGBA16;
const int gdepthFormat  = RGBA16;

uniform sampler2D texture;

uniform sampler2D gcolor ;
uniform sampler2D gnormal;
uniform sampler2D gdepth ;

varying vec3 normal;
varying vec4 texcoord;

void linearize(inout vec3 color, float gamma){
    color = pow(color, vec3(1.0/gamma));
}

void main(){
    vec4 handColor = texture2D(texture, texcoord.st).rgba;
    linearize(handColor.rgb,2);

    gl_FragData[0] = vec4(handColor);
    gl_FragData[2] = vec4(normal*.5+.5,0);//vec4(.5*normal+.5, 0);//blockColor.a);
}
