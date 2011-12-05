attribute vec4 position;
attribute vec4 color;

//varying vec4 colorVarying;

attribute vec2 TexCoordIn; // New
varying vec2 TexCoordOut;

uniform float translate;

void main()
{
    gl_Position = position;
    gl_Position.z += sin(translate) / 2.0;
    
    //colorVarying = color;
    TexCoordOut = TexCoordIn;
}
