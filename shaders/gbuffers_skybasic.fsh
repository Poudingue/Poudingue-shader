#version 120

const int RGBA16        = 1;
const int gcolorFormat  = RGBA16;
const int gnormalFormat = RGBA16;
const int gdepthFormat  = RGBA16;

uniform sampler2D texture;

uniform sampler2D gcolor ;
uniform sampler2D gnormal;
uniform sampler2D gdepth ;

varying vec4 texcoord;

void linearize(inout vec3 color, float gamma){
    color = pow(color, vec3(1.0/gamma));
}

void main(){
    gl_FragData[0] = texture2D(texture, texcoord.st);
    vec4 lm = texture2D(gdepth, texcoord.st);
    linearize(lm.rgb,2);
    gl_FragData[1] = lm;
    gl_FragData[2] = vec4(texture2D(gnormal, texcoord.st).rgb,1);

}
