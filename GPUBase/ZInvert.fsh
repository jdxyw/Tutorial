precision highp float;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform  float time;
uniform  vec2 resolution;
uniform  vec4 mouse;

void main()
{
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    vec2 uv;
    
    float a = atan(p.y,p.x);
    float r = sqrt(dot(p,p));
    
    uv.x = cos(0.6+time) + cos(cos(1.2+time)+a)/r;
    uv.y = cos(0.3+time) + sin(cos(2.0+time)+a)/r;
    
    vec3 col =  texture2D(Texture,uv*.25).xyz;
    
    gl_FragColor = vec4(col*r*r,1.0);}
