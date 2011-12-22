precision highp float;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform  float time;
uniform  vec2 resolution;
uniform  vec2 transform;
uniform  vec4 mouse;
uniform float scale;

vec2 exp2_complex(vec2 p)
{
    return vec2( p.x*p.x - p.y*p.y, 2.0*p.x*p.y );
}

vec2 inverse_complex(vec2 p)
{
    float r=dot(p,p);
    return vec2(p.x/r, -p.y/r);
}

float sincolor(float iter)
{
    return (sin(iter*2.0*3.1415926/510.0-3.1415926*0.5)+1.0)*0.5;
}

void main(void)
{
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    vec2 cc = vec2( cos(.25*time), sin(.25*time*1.423) );
    cc=vec2(-0.70176+cos(time)*0.05,-0.3842+sin(time)*0.05);
    float dmin = 1000.0;
    vec2 z  = p*vec2(1.33,1.0)*scale+transform;
    float iter=0.0;
    for( float i=0.0; i<256.0; i+=1.0 )
    {
        z = cc + vec2( z.x*z.x - z.y*z.y, 2.0*z.x*z.y );
        float m2 = dot(z,z);
        if( m2>4.0 ) 
        {
            iter=i;
            break;
        }
        dmin=min(dmin,m2);
    }
    
    float color = sqrt(sqrt(dmin))*0.7;
    if(iter<255.0)
    {
        gl_FragColor = vec4(sincolor(iter*15.0+23.0),sincolor(iter*20.0+87.0),sincolor(iter*76.0+12.0),1.0);
        //gl_FragColor = vec4(color+0.133*sin(time),color+0.236*cos(time),color+0.188*cos(0.8*time),1.0);
    }
}