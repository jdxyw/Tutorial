precision highp float;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform  float time;
uniform  vec2 resolution;
uniform  vec4 mouse;

//float u( float x ) { return 0.5+0.5*sign(x); }
float u( float x ) { return (x>0.0)?1.0:0.0; }
//float u( float x ) { return abs(x)/x; }

void main(void)
{
    vec2 move1;
    move1.x = cos(time)*0.4;
    move1.y = sin(time*1.5)*0.4;
    vec2 move2;
    move2.x = cos(time*2.0)*0.4;
    move2.y = sin(time*3.0)*0.4;
    
    //screen coordinates
    vec2 p = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
    
    //radius for each blob
    float r1 =(dot(p-move1,p-move1))*8.0;
    float r2 =(dot(p+move2,p+move2))*16.0;
    
    //sum the meatballs
    float metaball =(1.0/r1+1.0/r2);
    //alter the cut-off power
    float col = pow(metaball,8.0);
    
    //set the output color
    gl_FragColor = vec4(col,col,col,1.0);
}