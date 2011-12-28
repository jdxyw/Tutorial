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
    //float r2=dot(p2,p2);
    //return vec2((p1.x*p2.x+p1.y*p2.y)/r2,(p1.y*p2.x-p1.x*p2.y)/r2);
    float r=sqrt(dot(p1,p1))/sqrt(dot(p2,p2));
    float theta1=atan(p1.y,p1.x);
    float theta2=atan(p2.y,p2.x);
    return vec2(r*(cos(theta1-theta2)),r*sin(theta1-theta2));
}

vec2 exp_comp(vec2 p)
{
    float temp=exp(p.x);
    return vec2(temp*cos(p.y),temp*sin(p.y));
}

float hue2rgb(float p,float q, float t)
{
    if(t < 0.0) t+=1.0;
    if(t > 1.0) t-=1.0;
    if(t < 1.0/6.0) return p+(q-p)*6.0*t;
    if(t < 1.0/2.0) return q;
    if(t < 2.0/3.0) return p+(q-p)*(2.0/3.0-t)*6.0;
    return p;
}

vec3 hsl2rgb(float h,float s,float l)
{
    float q=0.0;
    if(l<0.5)
    q=l*(l+s);
    else
    q=l+s-s*l;
    
    float p=2.0*l-q;
    
    float r=hue2rgb(p,q,h+1.0/3.0);
    float g=hue2rgb(p,q,h);
    float b=hue2rgb(p,q,h-1.0/3.0);
    
    if(s==0.0)
    r=g=b=l;
    
    return vec3(r,g,b);
}

vec2 power_of_comp(vec2 p,float n)
{
    float r=sqrt(dot(p,p));
    float theta=atan(p.y,p.x);
    float rn=pow(r,n);
    return vec2(rn*cos(n*theta),rn*sin(n*theta));
}

void main(void)
{
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    vec2 cc = vec2( cos(.25*time), sin(.25*time*1.423) );
    
    float dmin = 1000.0;
    vec2 p1=vec2(0.3,0.4);    
    vec2 z  = p*vec2(1.33,1.0);
    float sum=0.0;
    float done;
    for( int i=0; i<64; i++ )
    {
        z = cc + vec2( z.x*z.x - z.y*z.y, 2.0*z.x*z.y );
        float m2 = dot(z,z);
        if( m2>100.0 ) break;
        dmin=min(dmin,m2);
        
        done=done+1.0;
        if(z.x < -0.1 || z.x > 0.7 || z.y< 0.0 || z.y > 0.8)
        {
            if(z.x < -0.1)
            {
                sum=sum+abs(z.x+0.1);
                dmin=min(dmin,abs(z.x+0.1));
            }
            
            if(z.x > 0.7)
            {
                sum=sum+abs(z.x-0.7);
                dmin=min(dmin,abs(z.x-0.7));
            }
            
            if(z.y < 0.0)
            {
                sum=sum+abs(z.y-0.0);
                dmin=min(dmin,abs(z.y-0.0));
            }
            
            if(z.y > 0.8)
            {
                sum=sum+abs(z.y-0.8);
                dmin=min(dmin,abs(z.y-0.8));
            }
        }
        
    }
    
    float color = log(sqrt(sqrt(sum/done)))*0.8;
    float color1=sqrt(sqrt(dmin))*0.7;
    gl_FragColor = vec4(hsl2rgb(color*0.4+color1*0.3,1.0,0.8),1.0);
}