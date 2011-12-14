precision highp float;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform  float time;
uniform  vec2 resolution;
uniform  vec4 mouse;

vec2 exp2_complex(vec2 p)
{
    return vec2( p.x*p.x - p.y*p.y, 2.0*p.x*p.y );
}

vec2 inverse_complex(vec2 p)
{
    float r=dot(p,p);
    return vec2(p.x/r, -p.y/r);
}

void main(void)
{
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    vec2 cc = vec2( cos(.75*time)+0.6, sin(.25*time*1.423)+0.6 );
    
    float dmin = 1000.0;
    vec2 z  = p;
    vec2 z1 = p*vec2(1.5,1.5);
    for( int i=0; i<100; i++ )
    {
        z = exp2_complex(z1)+ p + cc;
        float m2 = dot(z,z);
        if( m2>256.0 ) break;
        dmin=min(dmin,m2);
        p=z1;
        z1 =z;
    }
    
    float color = sqrt(sqrt(dmin))*0.7;
    gl_FragColor = vec4(color*cos(.25*time)*1.5,color*0.6,color*0.3,1.0);
}