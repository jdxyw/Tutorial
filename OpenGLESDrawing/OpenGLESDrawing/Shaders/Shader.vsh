//
//  Shader.vsh
//  OpenGLESDrawing
//
//  Created by jdxyw on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

attribute vec4 position;
attribute vec4 color;

varying vec4 colorVarying;

uniform float translate;

void main()
{
    gl_Position = position;
    gl_Position.x += sin(translate) / 2.0;
    
    colorVarying = vec4(0.7,0.7,0.7,0);
}
