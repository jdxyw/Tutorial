//
//  Shader.fsh
//  ImageProcessingByOpenGLES
//
//  Created by jdxyw on 11-11-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

precision highp float;

varying  lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; 

uniform float time;
uniform vec2 resolution;
uniform vec2      tcOffset[9];

void main()
{
    //gl_FragColor = vec4(1.0-texture2D(Texture, TexCoordOut).rgb,1.0);

    vec3 vecColor=vec3(0,0,0);
//    for(int i=0;i<9;i++){
//        vecColor+=texture2D(Texture, TexCoordOut+tcOffset[i]).rgb;
//    }
    
    vecColor+=texture2D(Texture, TexCoordOut+tcOffset[0]).rgb*-1.0;
    vecColor+=texture2D(Texture, TexCoordOut+tcOffset[1]).rgb*-1.0;
    vecColor+=texture2D(Texture, TexCoordOut+tcOffset[2]).rgb*-1.0;
    vecColor+=texture2D(Texture, TexCoordOut+tcOffset[3]).rgb*-1.0;
    vecColor+=texture2D(Texture, TexCoordOut+tcOffset[4]).rgb*8.0;
    vecColor+=texture2D(Texture, TexCoordOut+tcOffset[5]).rgb*-1.0;
    vecColor+=texture2D(Texture, TexCoordOut+tcOffset[6]).rgb*-1.0;
    vecColor+=texture2D(Texture, TexCoordOut+tcOffset[7]).rgb*-1.0;
    vecColor+=texture2D(Texture, TexCoordOut+tcOffset[8]).rgb*-1.0;
    
    //vecColor =vecColor / 13.0;
    gl_FragColor=vec4(vecColor,0.5);
    
    //gl_FragColor=texture2D(Texture,TexCoordOut);
}
