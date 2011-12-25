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
    vec2 z  = p*vec2(1.33,1.0);
    vec2 p2=vec2(0.2,-0.4);
    vec2 p3=vec2(0.3,0.6);
    vec2 l=vec2(0.2,0.6);
    for( int i=0; i<32; i++ )
    {
        z = cc + divide_comp(power_of_comp(z,3.0)+z,3.0*power_of_comp(z,2.0));
        float m2 = dot(z,z);
        if( m2>10.0 ) break;
        dmin=min(dmin,m2);
        
        vec2 t=fract(abs(z));
        if(t.x>0.5) t.x=1.0-t.x;
        if(t.y>0.5) t.y=1.0-t.y;
        //vec2 m3=vec2(fract(z));
        float m4=dot(t,t);
        dmin=min(dmin,m4);        
        
        
        
    }
    
    float color = sqrt(sqrt(dmin))*0.9;
    //if(color<0.4) color=1.0-color;
    //if(color>0.4) color=sqrt(color)*1.6-0.2;
    if(color>2.0) color=dot(p,p)*2.0;
    gl_FragColor = vec4(hsl2rgb(color,1.0,0.7),1.7);
}