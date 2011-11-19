//
//  Shader.fsh
//  PlaneDeform
//
//  Created by jdxyw on 11-11-17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

//varying lowp vec4 colorVarying;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform highp float time;
uniform highp vec2 resolution;
uniform highp vec4 mouse;

void main()
{
    //gl_FragColor = texture2D(Texture, TexCoordOut);
    
    
//    highp vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
//    highp vec2 m = -1.0 + 2.0 * mouse.xy / resolution.xy;
//    
//    highp float a1 = atan(p.y-m.y,p.x-m.x);
//    highp float r1 = sqrt(dot(p-m,p-m));
//    highp float a2 = atan(p.y+m.y,p.x+m.x);
//    highp float r2 = sqrt(dot(p+m,p+m));
//    
//    highp vec2 uv;
//    uv.x = 0.2*time + (r1-r2)*0.25;
//    uv.y = sin(2.0*(a1-a2));
//    
//    highp float w = r1*r2*0.8;
//    highp vec3 col = texture2D(Texture,uv).xyz;
//    
//    gl_FragColor = vec4(col/(.1+w),1.0);
    
    highp vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    highp vec2 uv;
    
    highp float a = atan(p.y,p.x);
    highp float r = sqrt(dot(p,p));
    
    uv.x =          7.0*a/3.1416;
    uv.y = -time+ sin(7.0*r+time) + .7*cos(time+7.0*a);
    
    highp float w = .5+.5*(sin(time+7.0*r)+ .7*cos(time+7.0*a));
    
    highp vec3 col =  texture2D(Texture,uv*.5).xyz;
    
    gl_FragColor = vec4(col*w,1.0);
}
