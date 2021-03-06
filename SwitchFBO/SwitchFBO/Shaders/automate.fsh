precision highp float;
varying vec2 v_texCoord;
uniform sampler2D tex; //the input texture
uniform float du; //the width of the cells
uniform float dv; //the height of the cells

/*
 Any live cell with fewer than two live neighbours dies,
 as if caused by under-population.
 Any live cell with two or three live neighbours
 lives on to the next generation.
 Any live cell with more than three live neighbours dies,
 as if by overcrowding.
 Any dead cell with exactly three live neighbours
 becomes a live cell, as if by reproduction.
 */

void main() {
    int count = 0;
    float dvv=dv;
    vec4 C = texture2D( tex, v_texCoord );
    vec4 E = texture2D( tex, vec2(v_texCoord.x + du, v_texCoord.y) );
    vec4 N = texture2D( tex, vec2(v_texCoord.x, v_texCoord.y + du) );
    vec4 W = texture2D( tex, vec2(v_texCoord.x - du, v_texCoord.y) );
    vec4 S = texture2D( tex, vec2(v_texCoord.x, v_texCoord.y - du) );
    vec4 NE = texture2D( tex, vec2(v_texCoord.x + du, v_texCoord.y + du) );
    vec4 NW = texture2D( tex, vec2(v_texCoord.x - du, v_texCoord.y + du) );
    vec4 SE = texture2D( tex, vec2(v_texCoord.x + du, v_texCoord.y - du) );
    vec4 SW = texture2D( tex, vec2(v_texCoord.x - du, v_texCoord.y - du) );
    
    if (E.r == 1.0) { count++; }
    if (N.r == 1.0) { count++; }
    if (W.r == 1.0) { count++; }
    if (S.r == 1.0) { count++; }
    if (NE.r == 1.0) { count++; }
    if (NW.r == 1.0) { count++; }
    if (SE.r == 1.0) { count++; }
    if (SW.r == 1.0) { count++; }
    
    if ( (C.r == 0.0 && count == 3) ||
        (C.r == 1.0 && (count == 2 || count == 3))) 
    {
        gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0); //cell lives...
    } else {
        gl_FragColor = vec4(0.0,0.0,0.0, 1.0); //cell dies...
    }
    //gl_FragColor=vec4(C.rgb,1.0);
    //gl_FragColor = vec4(1.0-texture2D(tex, v_texCoord).rgb,1.0);
    //gl_FragColor=1-texture2D(tex,t_texCoord);
    //vec4 C = texture2D( tex, v_texCoord );
    //gl_FragColor=vec4(du*100.0,dv*100.0,0.0,1.0);
//    if(C.r > 0.5)
//    {
//        gl_FragColor = vec4(1.0-C.r, 1.0-C.g, 1.0-C.b, 1.0);
//    }
//    else
//    {
//        gl_FragColor = vec4(1.0-C.r, 1.0-C.g, 1.0-C.b, 1.0);
//    }
}
