precision highp float;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform  float time;
uniform  vec2 resolution;
uniform  vec4 mouse;

void main(void)
{
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    vec2 cc = vec2( cos(.25*time), sin(.25*time*1.423) );

    float dmin = 1000.0;
    vec2 line=vec2(sin(time)-.22,cos(time)*0.73+0.21);
    vec2 z  = p*vec2(1.33,1.0);
    for( int i=0; i<64; i++ )
    {
        z = cc + vec2( z.x*z.x - z.y*z.y, 2.0*z.x*z.y );
        //float m2 = dot(z,z);
        float m2=(z.x-line.x)*(z.x-line.x);
        if( m2>4.0 ) break;
        dmin=min(dmin,m2);
        }

    float color = sqrt(sqrt(dmin*0.5))*0.7;
    gl_FragColor = vec4(color*0.35+0.33,color*0.54+0.32,color*0.32,1.0);
}

