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
    vec2 cc = vec2( cos(.25*time)+0.6, sin(.25*time*1.423) );
    
    float dmin = 200.0;
    vec2 z  = p;
    for( int i=0; i<200; i++ )
    {
        z = z - cc*(3.0*z - inverse_complex(3.0*exp2_complex(z)));
        float m2 = dot(z,z);
        if( m2>50.0 ) break;
        dmin=min(dmin,m2);
    }
    
    float color = sqrt(sqrt(dmin))*0.7;
    gl_FragColor = vec4(color*cos(.25*time)*1.5,color*0.5,color*0.3,1.0);
}