//
//  Shader.vsh
//  SwitchFBO
//
//  Created by jdxyw on 11-11-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

attribute vec4 position;
//attribute vec4 color;
attribute vec2 textCoord;

//varying vec4 colorVarying;
varying vec2 v_texCoord; 
//uniform float translate;

void main()
{
    gl_Position = position;
    //gl_Position.y += sin(translate) / 2.0;
    v_texCoord=textCoord;
    //colorVarying = color;
}
