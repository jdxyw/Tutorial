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
    float d1=1000.0;
    float d2=1000.0;
    float d3=1000.0;
    float d4=1000.0;
    float d5=1000.0;
    float d6=1000.0;
    
    vec2 z  = p*vec2(2.63,2.0)+vec2(0.0,0.0);
    vec2 p1=vec2(-0.6,0.4);
    for( int i=0; i<64; i++ )
    {
        z = multip_comp(cc,sin_comp(z));
        float m2 = dot(z-p1,z-p1);
        //if( m2>128.0 ) break;
        dmin=min(dmin,m2);
        
        vec2 t=fract(abs(z));
        if(t.x>0.5) t.x=1.0-t.x;
        if(t.y>0.5) t.y=1.0-t.y;
        //vec2 m3=vec2(fract(z));
        float m4=dot(t,t);
        d6=min(d6,m4);
        
        float m3=abs(z.x-2.0);
        d1=min(d1,m3);
        d2=min(d2,abs(z.x));
        d3=min(d3,abs(z.y));
        d4=min(d4,abs(z.x-1.0));
        d5=min(d5,abs(z.y-1.0));
    }
    
    float color = sqrt(sqrt(dmin))*0.7;
    float color1 = sqrt(sqrt(d1))*0.7;
    float color2 = sqrt(sqrt(d2))*0.7;
    float color3 = sqrt(sqrt(d3))*0.7;
    float color4 = sqrt(sqrt(d4))*0.7;
    float color5 = sqrt(sqrt(d5))*0.7;
    float color6 = sqrt(sqrt(d6))*0.5;
    
    gl_FragColor = vec4(hsl2rgb(color*0.7+color1*0.2+color2*0.1+color3*0.3,1.0,0.7),1.0);
}