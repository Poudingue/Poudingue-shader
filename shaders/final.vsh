#version 120

uniform int   worldTime;
uniform vec3  sunPosition;
uniform vec3  moonPosition;

varying float mixDay;
varying vec3  sunVector;
varying vec3  moonVector;

varying vec4  texcoord;

void main(){
    gl_Position= ftransform();
    texcoord   = gl_MultiTexCoord0;
    sunVector  = normalize(sunPosition);
    moonVector = normalize(moonPosition);

    float mixDay_temp;

    if(worldTime < 500){
        mixDay_temp = (500.0 + worldTime);
    }else if (worldTime > 11500 && worldTime < 23500){
        mixDay_temp = 12500 - worldTime;
    }else if(worldTime >= 23500){
        mixDay_temp = (worldTime - 23500.0);
    }else{
        mixDay_temp = 1000;
    }
    mixDay = clamp(mixDay_temp/1000.0,0,1);
}
