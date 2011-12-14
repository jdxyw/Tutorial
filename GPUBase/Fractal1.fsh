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
    vec2 cc = vec2( cos(.65*time)+1.5, sin(.25*time*1.423)+0.9 );
    
    float dmin = 20.0 * 3.1415926;
    vec2 z  = p*vec2(1.33,0.8);;
    for( int i=0; i<64; i++ )
    {
        z = cc + sin_complex(z);
        float m2 = dot(z,z);
        if( m2>30.0 ) break;
        dmin=min(dmin,m2);
    }
    
    float color = sqrt(sqrt(dmin))*0.7;
    gl_FragColor = vec4(color*cos(.25*time),color*sin(.25*time),color*0.7,1.0);
}