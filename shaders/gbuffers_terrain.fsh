#version 120

const int RGBA16        = 1;
const int gcolorFormat  = RGBA16;
const int gnormalFormat = RGBA16;
const int gdepthFormat  = RGBA16;

uniform sampler2D texture;

varying vec3 tintColor;
varying vec3 normal;
varying float depth;

varying vec4 texcoord;

void linearize(inout vec3 color, float gamma){
    color = pow(color, vec3(1.0/gamma));
}

void main(){
    vec4 blockColor = texture2D(texture, texcoord.st);
    linearize(blockColor.rgb,2);
    blockColor.rgb *= tintColor;

    gl_FragData[0] = vec4(blockColor);
    gl_FragData[1] = vec4(depth);
    gl_FragData[2] = vec4(.5*normal+.5, 1);//blockColor.a);
}
