//
//  Shader.fsh
//  OpenGLESDrawing
//
//  Created by jdxyw on 11-11-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
