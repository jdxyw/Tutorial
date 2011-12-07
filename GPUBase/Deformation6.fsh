precision highp float;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform  float time;
uniform  vec2 resolution;
uniform  vec4 mouse;

void main(void)
{
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    vec2 uv;
    
    float a = atan(p.y,p.x);
    float r = sqrt(dot(p,p));
    
    float x=p.x;
    float y=p.y;
    float pi=3.1415926;
    uv= vec2(0.1*x/(sin(time)+0.11+r*0.5),0.1*y/(cos(time)+0.11+r*0.5));
    
    vec3 col =  texture2D(Texture,uv).xyz;
    
    gl_FragColor = vec4(col*r,1.0);
    
}