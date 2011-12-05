//
//  Shader.fsh
//  PlaneDeform
//
//  Created by jdxyw on 11-11-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

//varying lowp vec4 colorVarying;

precision highp float;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform  float time;
uniform  vec2 resolution;
uniform  vec4 mouse;

void main()
{
    vec2 uv;
    
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    float a = atan(p.y,p.x);
    float r = sqrt(dot(p,p));
    float s = r * (1.0+0.8*cos(time*1.0));
    
    uv.x =          .02*p.y+.03*cos(-time+a*3.0)/s;
    uv.y = .1*time +.02*p.x+.03*sin(-time+a*3.0)/s;
    
    float w = .9 + pow(max(1.5-r,0.0),4.0);
    
    w*=0.6+0.4*cos(time+3.0*a);
    
    vec3 col =  texture2D(Texture,uv).xyz;
    
    gl_FragColor = vec4(col*w,1.0);
}
