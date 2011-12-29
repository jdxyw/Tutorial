precision highp float;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform  float time;
uniform  vec2 resolution;
uniform  vec4 mouse;

vec2 sin_comp(vec2 p)
{
    float t1=exp(p.y);
    float t2=exp(-p.y);
    return vec2(sin(p.x)*(t1+t2)*0.5,cos(p.x)*(t1-t2)*0.5);
}

vec2 cos_comp(vec2 p)
{
    float t1=exp(p.y);
    float t2=exp(-p.y);
    return vec2(cos(p.x)*(t1+t2)*0.5,-sin(p.x)*(t1-t2)*0.5);
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

vec2 power_of_comp(vec2 p,float n)
{
    float r=sqrt(dot(p,p));
    float theta=atan(p.y,p.x);
    float rn=pow(r,n);
    return vec2(rn*cos(n*theta),rn*sin(n*theta));
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



void main(void)
{
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    vec2 cc = vec2( cos(.25*time), sin(.25*time*1.423) );
    
    float dmin = 1000.0;
    vec2 z  = p*vec2(1.33,1.0);
    float done=0.0;
    for( int i=0; i<32; i++ )
    {
        done+=1.0;
        z =  (multip_comp(cc,sin_comp(z)+cos_comp(z)));
        float m2 = dot(z,z);
        if( m2>100.0 ) break;
        dmin=min(dmin,m2);
        
        float m3=abs(z.x-0.3);
        dmin=min(dmin,m3);
        
        float m4=abs(z.y-0.3);
        dmin=min(dmin,m4);
    }
    
    float color = 1.5-sqrt(sqrt(sqrt(dmin)))*0.7;
    gl_FragColor = vec4(hsl2rgb(color,1.0,0.6),1.0);
}