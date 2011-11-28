//
//  Shader.fsh
//  SwitchFBO
//
//  Created by jdxyw on 11-11-28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

//varying lowp vec4 colorVarying;
//
//void main()
//{
//    gl_FragColor = colorVarying;
//}

precision mediump float;
varying vec2 v_texCoord;
uniform sampler2D tex;
void main() {
    gl_FragColor = texture2D( tex, v_texCoord );
}