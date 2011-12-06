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
    
    float an = time*.25;
    
    float x = p.x*cos(an)-p.y*sin(an);
    float y = p.x*sin(an)+p.y*cos(an);
    
    uv.x = .25*x/abs(y);
    uv.y = .20*time + .25/abs(y);
    
    gl_FragColor = vec4(texture2D(Texture,uv).xyz * y*y, 1.0);
}