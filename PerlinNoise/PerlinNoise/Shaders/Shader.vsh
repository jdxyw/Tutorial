//
//  Shader.vsh
//  PerlinNoise
//
//  Created by jdxyw on 11-12-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
//precision lowp float; 

attribute vec4 position;
//attribute vec4 color;
attribute vec2 TexCoordIn; // New
varying vec2 TexCoordOut;


uniform float translate;

void main()
{
    gl_Position = position;
    gl_Position.y += sin(translate) / 2.0;

    //colorVarying = color;
    TexCoordOut = TexCoordIn;
}
