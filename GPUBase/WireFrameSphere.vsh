attribute vec4 position;
uniform float translate;

void main()
{
    gl_Position = position;
    gl_Position.z += sin(translate)*2.0;
    gl_Position.x += sin(translate) / 2.0;
    gl_Position.y += sin(translate) / 2.0;
}
