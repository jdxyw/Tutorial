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

vec2 square_comp(vec2  p)
{
    return vec2(p.x*p.x-p.y*p.y,2.0*p.x*p.y);
}

vec2 multip_comp(vec2 p1, vec2 p2)
{
    return vec2(p1.x*p2.x-p1.y*p2.y,p1.x*p2.y+p2.x*p1.y);
}

vec2 divide_comp(vec2 p1, vec2 p2)
{
    float r2=dot(p2,p2);
    return vec2((p1.x*p2.x+p1.y*p2.y)/r2,(p1.y*p2.x-p1.x*p2.y)/r2);
}

vec2 exp_comp(vec2 p)
{
    float temp=exp(p.x);
    return vec2(temp*cos(p.y),temp*sin(p.y));
}

void main(void)
{
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    vec2 cc = vec2( cos(.25*time), sin(.25*time*1.423) );

    float dmin = 1000.0;
    vec2 line=vec2(sin(time)-.22,cos(time)*0.73+0.21);
    vec2 z  = p*vec2(1.33,1.0);
    vec2 v=vec2(0.2,0.6);
    vec2 v1=vec2(-0.3,-0.4);
    for( int i=0; i<64; i++ )
    {
        z = cc + vec2( z.x*z.x - z.y*z.y, 2.0*z.x*z.y );
        float m2 = dot(z,z);
        float temp=abs((z.x-line.x));
        if( m2>4.0 ) break;
        dmin=min(dmin,temp);
        float temp1=abs(z.y-line.y);
        dmin=min(dmin,temp1);
       float temp3=abs(z.y-v.y);
        dmin=min(dmin,temp3);
       float temp4=abs(z.x-v.x);
               dmin=min(dmin,temp4);
       dmin=min(dmin,m2);
        }

    float color = sqrt(sqrt(dmin))*0.7;

    gl_FragColor = vec4(sin(color)+0.37,cos(color-0.22)*0.67-0.21,color+0.11-sin(time)*0.34,1.0);
//gl_FragColor=vec4(1.0,0,0,1.0);
}
