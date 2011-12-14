precision highp float;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform  float time;
uniform  vec2 resolution;
uniform  vec4 mouse;

vec2 sin_complex(vec2 p)
{
    float u= sin(p.x)*(exp(p.y)+exp(-p.y))/2.0;
    float v= cos(p.x)*(exp(p.y)-exp(-p.y))/2.0;
    return vec2(u,v);
}


void main(void)
{
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    vec2 cc = vec2( cos(.25*time)+1.0, sin(.25*time*1.423) );
    
    float dmin = 1000.0;
    vec2 z  = p*vec2(1.33,1.0);
    for( int i=0; i<64; i++ )
    {
        z = cc + vec2( z.x*z.x - z.y*z.y, -1.5*z.x*z.x/z.y );
        float m2 = dot(z,z);
        if( m2>31.4 ) break;
        dmin=min(dmin,m2);
    }
    
    float color = sqrt(sqrt(dmin))*0.7;
    gl_FragColor = vec4(color*cos(.25*time),color*sin(.25*time),color*0.7,1.0);
}