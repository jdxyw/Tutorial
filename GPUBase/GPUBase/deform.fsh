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
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    vec2 m = -1.0 + 2.0 * mouse.xy / resolution.xy;
    
    float a1 = atan(p.y-m.y,p.x-m.x);
    float r1 = sqrt(dot(p-m,p-m));
    float a2 = atan(p.y+m.y,p.x+m.x);
    float r2 = sqrt(dot(p+m,p+m));
    
    vec2 uv;
    uv.x = 0.2*time + (r1-r2)*0.25;
    uv.y = sin(2.0*(a1-a2));
    
    float w = r1*r2*0.8;
    vec3 col = texture2D(Texture,uv).xyz;
    
    gl_FragColor = vec4(col/(.1+w),1.0);    
}
