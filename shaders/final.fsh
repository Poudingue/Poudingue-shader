#version 120

const int RGBA16        = 1;
const int gcolorFormat  = RGBA16;
const int gnormalFormat = RGBA16;
const int gdepthFormat  = RGBA16;

uniform sampler2D gcolor ;
uniform sampler2D gnormal;
uniform sampler2D gdepth ;

uniform int  worldTime;
uniform vec3 sunPosition;
uniform vec3 moonPosition;

varying float mixDay;
varying vec3  sunVector;
varying vec3  moonVector;

varying vec4  texcoord;

#define SKY_COLOR_DAY   vec3( .4,  .6, .8)
#define SKY_COLOR_NIGHT vec3(0. ,  .2, .4)
#define SUNLIGHT        vec3(1.2, 1. , .8)
#define MOONLIGHT       vec3( .4,  .6, .8)

#define FOG_STRENGTH    .5
#define CONTRAST_POWER 0.
#define EXPOSURE        .7

void contrast(inout vec3 color){
    color = mix(color, smoothstep(vec3(0), vec3(1), color), CONTRAST_POWER);
}

void fog(inout vec3 color, in vec3 skycolor, in float depth){
    color = mix(color, mix(color, skycolor, FOG_STRENGTH), clamp(depth-.1,0,1));
}

void delinearize(inout vec3 color, float gamma){
    color = pow(color, vec3(gamma));
}

void main(){

    vec3 color  = texture2D(gcolor,  texcoord.st).rgb;
    vec3 normal = texture2D(gnormal, texcoord.st).rgb * 2 - 1;
    float depth = texture2D(gdepth,  texcoord.st).r;

    //Sky lighting
    vec3 sky_lighting     = mix(SKY_COLOR_NIGHT, SKY_COLOR_DAY, mixDay);
    vec3 direct_sunlight  = SUNLIGHT;
    vec3 direct_moonlight = MOONLIGHT;

    //Day
    if(worldTime > 23500 || worldTime < 12500){
        direct_sunlight *= dot(normal,  sunVector);
        direct_sunlight  = max(vec3(0), direct_sunlight);
    }else{
        direct_sunlight  = vec3(0);
    }

    //Night
    if(worldTime < 500 || worldTime > 11500){
        direct_moonlight *= dot(normal,  moonVector);
        direct_moonlight  = max(vec3(0), direct_moonlight);
    }else{
        direct_moonlight  = vec3(0);
    }

    color *= mix(direct_moonlight, direct_sunlight, mixDay) + sky_lighting ;

    fog(color, sky_lighting, depth);
    color*=EXPOSURE;
    // contrast(color);
    vec3 overexp = max(vec3(0), color-1);
    color += (overexp.gbr + overexp.brg)*.5;
    delinearize(color, 2);


    gl_FragColor = vec4(color, 1);

}
