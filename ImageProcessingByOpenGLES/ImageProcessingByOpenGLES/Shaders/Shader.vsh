//
//  Shader.vsh
//  ImageProcessingByOpenGLES
//
//  Created by jdxyw on 11-11-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

attribute vec4 position;
//attribute vec4 color;

//varying vec4 colorVarying;

attribute vec2 TexCoordIn; // New
varying vec2 TexCoordOut;

uniform float translate;

void main()
{
    gl_Position = position;
    //gl_Position.y += sin(translate) / 2.0;

    
    TexCoordOut = TexCoordIn;
  //  colorVarying = color;
}
