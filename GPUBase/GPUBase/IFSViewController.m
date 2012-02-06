//
//  IFSViewController.m
//  GPUBase
//
//  Created by jdxyw on 11-12-18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "IFSViewController.h"
#import "IFSFunctions.h"
#import <QuartzCore/QuartzCore.h>

#import "fractal.h"

#include <stdio.h>
#include <stdlib.h>
#include "functions.h"
#include "global.h"
//#include "display.h"
#include "functions.h"
#include "colorpalette.h"

#define ARC4RANDOM_MAX      0x100000000

#define MINV -1.0
#define RANGE 2.0
//these should eventually all be specified in a file or on the command line
#define MINITERATIONS 20
#define NITERATIONS 2000000
#define WINW 320
#define WINH 480
#define GAMMA 4.0
#define VIBRANCY 0.6
#define NFRAMES 1
#define FRAME_PERIOD 30

//MACROS

//random floating-point value in range [0.0,1.0)
#define RANDD (rand()/(RAND_MAX + 1.0))

//random floating-point value in range [MINV, (RANGE + MINV))
#define RANDU (RANDD * RANGE + MINV)

//FORWARD DECLARATIONS
typedef unsigned int plotcount_t;


@implementation IFSViewController

@synthesize imgView;
@synthesize button;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
                
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [button setTitle:@"Generate" forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)buttonClick:(id)sender
{
    IFSFunctions *ifsfunction=[[IFSFunctions alloc] init];
    [self performSelectorInBackground:@selector(generateImageV2) withObject:nil];
}

-(void)generateImageV2
{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    int width=320;
    int height=480;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc( height * width * 4  );
    
    int *fre=(int *)malloc(320*480*sizeof(int)*3*3);
    CGContextRef contextRef = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
    //CGColorSpaceRelease( colorSpace );
    CGContextClearRect( contextRef, CGRectMake( 0, 0, width, height ) );
    CGContextTranslateCTM( contextRef, 0, height - height );
    
    for(int i=0;i<height;i++)
    {
        for (int j=0; j<width; j++) {
            *((char *)(imageData+i*width*4+j*4))=0;
            *((char *)(imageData+i*width*4+j*4+1))=0;
            *((char *)(imageData+i*width*4+j*4+2))=0;
            *((char *)(imageData+i*width*4+j*4+3))=255;
            fre[i*width+j]=0;
        }
    }
    
    int winW, winH;
    coord_t minX, minY, rangeX, rangeY;
    int frame_period;
    int nframes;
    int dt;
    color_t ** frames = NULL;
    color_t * pixels = NULL;
    plotcount_t ** framecounts = NULL;
    
    
    winW=WINW;
    winH=WINH;
    minX=MINV;
    minY=MINV;
    rangeX=RANGE;
    rangeY=RANGE;
    nframes=1;
    init_color_palette();
    frames = malloc(sizeof(color_t *) * nframes);
    framecounts = malloc(sizeof(plotcount_t *) * nframes);
    for(int t=0; t<nframes; t++){
        //we'll store counts and colors accumulated in plot() in these arrays
        frames[t] = malloc(sizeof(color_t) * winW * winH * 3);
        framecounts[t] = malloc(sizeof(plotcount_t) * winW * winH);
    }
    if(!init_functions(NFRAMES)){
        fprintf(stderr,"main: init_functions failed.  exiting...\n");
        return 1;
    }
    int i,outside;
    float vector_pos;
    int vector_len=get_weight_vector_len();
    coords p;
    float c, ci, cfinal, cf;
    
    //fill vars with random values
    p.x = (coord_t)RANDU;
    p.y = (coord_t)RANDU;
    c = (float)RANDD;
    
    //initialize count of points outside the range the algorithm attempts to plot
    outside = 0;
    set_frame(0);
    for(i=0; i<NITERATIONS; i++){
        vector_pos = RANDD; //between 0.0 and 1.0
        vector_pos = vector_len*vector_pos; //between 0.0 and vector_len 
        
        run_function(vector_pos, &p, &ci);
        
        //c = (c + ci)/2 (average color index with current function's color index)
        c = (c + ci)/2.0;
        run_final(&p, &cfinal);
        
        //cf = (c + cfinal)/2; (average color index with final function's color
        //                      index)
        cf = (c + cfinal)/2.0;
        if(i>=MINITERATIONS)
        {
            int x;
            int y;
            int i;
            color * ccolor;
            
            x = (int)((p.x - minX)/rangeX * winW);
            y = (int)((p.y - minY)/rangeY * winH);
            
            if(x > 0 && x < winW && y > 0 && y < winH){
                //printf("plot: coordinates (%d,%d) out of range.  not plotting.\n",x,y);
                i = y*winW + x;
                
                //increment count where point is in grid
                framecounts[0][i]++;
                
                //look up color in palette using index
                ccolor = lookup_color(cf);
                
                //accumulate color values
                frames[0][3*i] += ccolor->r;
                frames[0][3*i+1] += ccolor->g;
                frames[0][3*i+2] += ccolor->b;
            }
            else
            {
                outside++;
            }
        }
    }
    
    //int i;
    color_t r,g,b;
    float invgamma, compvib, alpha_gamma;
    GLfloat brightness, brightness_scale;
    GLfloat alpha, alpha_scale, max_alpha_scale, first_scale;

    float gamma=4.0;
    float vibrancy=0.6;
    
    invgamma = 1.0/gamma;
    compvib = 1.0 - vibrancy;
    
    plotcount_t max = framecounts[0][0];
    
    //find largest count
    for(i=1; i<winW*winH; i++){
        if(framecounts[0][i] > max)
            max = framecounts[0][i];
    }
    
    max_alpha_scale = (GLfloat)1.0/(logf((float)max));
    
    for(i=0; i<winW*winH; i++){
        
        //this would create weird behavior
        if(M_E > framecounts[0][i]){
            frames[0][3*i] = 0.0;
            frames[0][3*i+1] = 0.0;
            frames[0][3*i+2] = 0.0;
            continue;
        }
        
        //basic color scaling
        alpha = (GLfloat)framecounts[0][i];    
        alpha_scale = (GLfloat)logf((float)alpha);
        brightness = alpha_scale*max_alpha_scale;
        
        //first scaling factor
        first_scale = brightness/alpha;
        
        
        //scale colors (already accumulated in pixels array) based on this pixel's
        //alpha and the entire image's max alpha
        if((frames[0][3*i] *= first_scale) > 1.0 ||
           (frames[0][3*i+1] *= first_scale) > 1.0 ||
           (frames[0][3*i+2] *= first_scale) > 1.0
           ){
            printf("compute_pixels: scaling isn't working right\n");
            exit(1);  
        }
        
        
        //gamma correction and vibrancy
        //vibrancy determines how much of gamma correction is determined by
        //alpha channel's brightness (as opposed to each individual channel's)
        alpha_gamma = vibrancy*powf(brightness, invgamma);
        
        frames[0][3*i] *= compvib*powf(frames[0][3*i], invgamma) + alpha_gamma;
        frames[0][3*i+1] *= compvib*powf(frames[0][3*i+1], invgamma) + alpha_gamma;
        frames[0][3*i+2] *= compvib*powf(frames[0][3*i+2], invgamma) + alpha_gamma;
        
        /*
         frames[t][3*i] = ( frames[t][3*i] > 1.0 ? 1.0 : frames[t][3*i]);
         frames[t][3*i+1] = ( g > 1.0 ? 1.0 : g);
         frames[t][3*i+2] = ( b > 1.0 ? 1.0 : b);
         */
        
        if(frames[0][3*i]   > 1.0 ||
           frames[0][3*i+1] > 1.0 ||
           frames[0][3*i+2] > 1.0
           ){
            printf("compute_pixels: gamma put channels out of range\n");
            //exit(1);  
        }
        
    }


    
    for(int i=0;i<height;i++)
    {
        for (int j=0; j<width; j++) {
            int x=(int)(frames[0][i*width*3+j*3]*256);
            *((char *)(imageData+i*width*4+j*4))=(int)(frames[0][i*width*3+j*3]*256);
            *((char *)(imageData+i*width*4+j*4+1))=(int)(frames[0][i*width*3+j*3+1]*256);
            *((char *)(imageData+i*width*4+j*4+2))=(int)(frames[0][i*width*3+j*3+2]*256);

        }
    }
    
    CGDataProviderRef dataProvider=CGDataProviderCreateWithData(NULL, imageData, height * width * 4, NULL);
    CGImageRef imageRef=CGImageCreate(width, height, 8, 32, 4*width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big, dataProvider, NULL, NO, kCGRenderingIntentDefault);
    
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(dataProvider);
    CGContextDrawImage(contextRef, CGRectMake( 0, 0, width, height ), imageRef);
    
    //imgView.image=[UIImage imageWithCGImage:imageRef];
    UIImage *image=[UIImage imageWithCGImage:imageRef];
    [self performSelectorOnMainThread:@selector(completeGeneration:) withObject:image waitUntilDone:YES];
    CGImageRelease(imageRef);
    CGContextRelease(contextRef);
    free(imageData);
    free(frames);
    free(pixels);
    cleanup_color_palette();
    cleanup_functions();
    //cleanup_variations();
    [pool release];

    
}

-(void)generateImage:(id)ifsfunction
{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    int width=320;
    int height=480;
    
    int superwidth=320*3;
    int superheight=480*3;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc( height * width * 4  );
    
    void *superImageData=malloc(height*width*4*3*3);
    
    int *fre=(int *)malloc(320*480*sizeof(int)*3*3);
    CGContextRef contextRef = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
    //CGColorSpaceRelease( colorSpace );
    CGContextClearRect( contextRef, CGRectMake( 0, 0, width, height ) );
    CGContextTranslateCTM( contextRef, 0, height - height );
    
    
    int NUMV, SAMPLES, ITTERATIONS, QUALITY, SEED, OVERSAMPLE, UNDERSAMPLE;
	int xres, yres, R, G, B, count, invert;
	int symmetry, super_, use_jpeg;
	int * choice;
	double xmin, xmax, ymin, ymax;
	//char * FILENAME;
	unsigned  int num, step, row, col, i;
	double x, y;
	double gamma, max;
	char last_percent = 0;
	coeff coeffs;
	fract fractal;
    
	/*---------------------------------------------*/ 
	/* DEFINE PRESETS  */
	NUMV = DNUMV;
	SAMPLES = DSAMPLES;
	ITTERATIONS = DITT;
	QUALITY = DQUALITY;
	OVERSAMPLE = 1;
	UNDERSAMPLE = 6;
	SEED = 1;
	R = -1;
	G = -1;
	B = -1;
	super_ = DSUPER;
	gamma = DGAMMA;
	xres = DXRES;
	yres = DYRES;
	ymin = DYMIN;
	xmin = DXMIN;
	xmax = DXMAX;
	ymax = DYMAX;
	choice = 0;
	invert = 0;
	symmetry = 0;
	use_jpeg = 0;
	//FILENAME = PATH;
	count = 0;
	choice = malloc(count+1 * sizeof(int));
	if(choice == NULL)
		exit(1);
	choice[0] = 0;

    //symmetry=1;
    //invert=1;
    SEED=arc4random();
    xres=320;
    yres=480;
    
//    xmin=-1;
//    xmax=1;
//    ymin=-1;
//    ymax=1;
    //ITTERATIONS=100;
    super_=3;
    R=arc4random()%256;
    G=arc4random()%256;
    B=arc4random()%256;
    //OVERSAMPLE=2;
    //gamma=1.5;
    choice[count] = arc4random()%26+1;
    count++;
    choice = realloc(choice, (count+1) * sizeof(int));
    
    if(count>0) count--;
    
    srand(SEED); /* seed random */
	fractal_set(xres * super_, yres * super_, xmin, xmax, ymin, ymax, &fractal);
	/*fractal_set(1920, 1080, -1.5625, 1.5625, -1.0, 1.0, &fractal);*/
	/*fractal_set(1024, 1024, -1.0, 1.0, -1.0, 1.0, &fractal);*/

	/* setup random coefficeints and colors */
	coeffs.ac = malloc(NUMV * sizeof(double));
	if(coeffs.ac == NULL)
		exit(1);
	coeffs.bc = malloc(NUMV * sizeof(double));
	if(coeffs.bc == NULL)
		exit(1);
	coeffs.cc = malloc(NUMV * sizeof(double));
	if(coeffs.cc == NULL)
		exit(1);
	coeffs.dc = malloc(NUMV * sizeof(double));
	if(coeffs.dc == NULL)
		exit(1);
	coeffs.ec = malloc(NUMV * sizeof(double));
	if(coeffs.ec == NULL)
		exit(1);
	coeffs.fc = malloc(NUMV * sizeof(double));
	if(coeffs.fc == NULL)
		exit(1);
	coeffs.colors = malloc(NUMV * sizeof(trio));
	if(coeffs.colors == NULL)
		exit(1);
    
	coeffs_init(&coeffs, NUMV, R, G, B);

    for(num=0; num<SAMPLES; num++)
	{
		if( (char) ((double) num / (double) SAMPLES * 100.0) > last_percent )
		{
			last_percent = (char) ((double) num / (double) SAMPLES * 100.0);
			if(last_percent <= 10) {
			} else {			}
			fflush(stdout);
		}
        
		x = ((double) rand()) * choose(fractal.xmin, fractal.xmax);
		y = ((double) rand()) * choose(fractal.ymin, fractal.ymax);
        
		for(step=0; step<ITTERATIONS; step++)
		{
			i = (unsigned int) (rand() % NUMV);
			V(choice[rand() % (count+1)], 
              coeffs.ac[i] * x + coeffs.bc[i] * y + coeffs.cc[i], 
              coeffs.dc[i] * x + coeffs.ec[i] * y + coeffs.fc[i],
              (int)i,
              &x,
              &y,
              &coeffs);
            
			if(step > 20) {
				unsigned  int x1, y1;
				unsigned short red, green, blue;
				int valid;
                
				valid = 0;
				y1=0;
				x1=0;
                
				if(x >= fractal.xmin && x <= fractal.xmax && y >= fractal.ymin && y <= fractal.ymax) {
					valid = 1;
					x1 = fractal.xres - (unsigned int) (((fractal.xmax - x) / fractal.ranx) * (double) fractal.xres);
					y1 = fractal.yres - (unsigned int) (((fractal.ymax - y) / fractal.rany) * (double) fractal.yres);
				}
                
				if(valid && x1 >= 0 && x1 < fractal.xres && y1 >= 0 && y1 < fractal.yres) {
					fractal.pixels[y1][x1].vals.count += OVERSAMPLE;
					red = (unsigned short) fractal.pixels[y1][x1].color.r;
					red += (unsigned short) coeffs.colors[i].r;
					fractal.pixels[y1][x1].color.r = (unsigned char) (red / 2);
					blue = (unsigned short) fractal.pixels[y1][x1].color.b;
					blue += (unsigned short) coeffs.colors[i].b;
					fractal.pixels[y1][x1].color.b = (unsigned char) (blue / 2);
					green = (unsigned short) fractal.pixels[y1][x1].color.g;
					green += (unsigned short) coeffs.colors[i].g;
					fractal.pixels[y1][x1].color.g = (unsigned char) (green / 2);
                    
					if(symmetry) { /* only if we have symmetry enabled, plots the mirror */
						if(!x1)	x1++;
						if(!y1)	y1++;
						x1 = fractal.xres - x1; 
						y1 = fractal.yres - y1;
						if(x1 >= 0 && x1 < fractal.xres && y1 >= 0 && y1 < fractal.yres) {
							fractal.pixels[y1][x1].vals.count += OVERSAMPLE;
							fractal.pixels[y1][x1].color.r = (unsigned char) (red / 2);
							fractal.pixels[y1][x1].color.b = (unsigned char) (blue / 2);
							fractal.pixels[y1][x1].color.g = (unsigned char) (green / 2);
						}
                        
					}
				}
			}
		}
	}
	
	if(super_ > 1)
		reduce(&fractal, super_);
    
	max = 0.0;
    
	for(row=0; row<fractal.yres; row++) {
		for(col=0; col<fractal.xres; col++){
			if(fractal.pixels[row][col].vals.count != 0) {
				/*if(fractal.pixels[row][col].vals.count > max)
                 max = fractal.pixels[row][col].vals.count;*/
				fractal.pixels[row][col].vals.normal = log((double) (fractal.pixels[row][col].vals.count / UNDERSAMPLE) );
				if(fractal.pixels[row][col].vals.normal > max)
					max = fractal.pixels[row][col].vals.normal;
            }
        }
    }
    
	for(row=0; row<fractal.yres; row++) {
		for(col=0; col<fractal.xres; col++) {
			fractal.pixels[row][col].vals.normal  = fractal.pixels[row][col].vals.normal / (float) max;
			fractal.pixels[row][col].color.r = (unsigned char) ((float)(fractal.pixels[row][col].color.r)) * pow(fractal.pixels[row][col].vals.normal, (1.0 / gamma));
			fractal.pixels[row][col].color.g = (unsigned char) ((float)(fractal.pixels[row][col].color.g)) * pow(fractal.pixels[row][col].vals.normal, (1.0 / gamma));
			fractal.pixels[row][col].color.b = (unsigned char) ((float)(fractal.pixels[row][col].color.b)) * pow(fractal.pixels[row][col].vals.normal, (1.0 / gamma));
            
		}
	}
    
    for (int i=0; i<height; i++) {
        for(int j=0;j<width;j++){
            int x=fractal.pixels[i][j].color.g;
            *((char *)(imageData+i*width*4+j*4))=fractal.pixels[i][j].color.r;
            *((char *)(imageData+i*width*4+j*4+1))=fractal.pixels[i][j].color.g;
            *((char *)(imageData+i*width*4+j*4+2))=fractal.pixels[i][j].color.b;
            *((char *)(imageData+i*width*4+j*4+3))=255;
        }
    }

    
    
//    for(int i=0;i<height;i++)
//    {
//        for (int j=0; j<width; j++) {
//            *((char *)(imageData+i*width*4+j*4))=0;
//            *((char *)(imageData+i*width*4+j*4+1))=0;
//            *((char *)(imageData+i*width*4+j*4+2))=0;
//            *((char *)(imageData+i*width*4+j*4+3))=255;
//            
//            fre[i*superwidth+j*3]=0;
//            fre[i*superwidth+j*3+1]=0;
//            fre[i*superwidth+j*3+2]=0;
//            fre[(i+1)*superwidth+j*3]=0;
//            fre[(i+1)*superwidth+j*3+1]=0;
//            fre[(i+1)*superwidth+j*3+2]=0;
//            fre[(i+2)*superwidth+j*3]=0;
//            fre[(i+2)*superwidth+j*3+1]=0;
//            fre[(i+2)*superwidth+j*3+2]=0;
//            
//            *((char *)(superImageData+i*superwidth*4+j*4*3))=0;
//            *((char *)(superImageData+i*superwidth*4+j*4*3+1))=0;
//            *((char *)(superImageData+i*superwidth*4+j*4*3+2))=0;
//            *((char *)(superImageData+i*superwidth*4+j*4*3+3))=255;
//            
//            *((char *)(superImageData+i*superwidth*4+(j+1)*4*3))=0;
//            *((char *)(superImageData+i*superwidth*4+(j+1)*4*3+1))=0;
//            *((char *)(superImageData+i*superwidth*4+(j+1)*4*3+2))=0;
//            *((char *)(superImageData+i*superwidth*4+(j+1)*4*3+3))=255;
//            
//            *((char *)(superImageData+i*superwidth*4+(j+2)*4*3))=0;
//            *((char *)(superImageData+i*superwidth*4+(j+2)*4*3+1))=0;
//            *((char *)(superImageData+i*superwidth*4+(j+2)*4*3+2))=0;
//            *((char *)(superImageData+i*superwidth*4+(j+2)*4*3+3))=255;
//            
//            *((char *)(superImageData+(i+1)*superwidth*4+j*4*3))=0;
//            *((char *)(superImageData+(i+1)*superwidth*4+j*4*3+1))=0;
//            *((char *)(superImageData+(i+1)*superwidth*4+j*4*3+2))=0;
//            *((char *)(superImageData+(i+1)*superwidth*4+j*4*3+3))=255;
//            
//            *((char *)(superImageData+(i+1)*superwidth*4+(j+1)*4*3))=0;
//            *((char *)(superImageData+(i+1)*superwidth*4+(j+1)*4*3+1))=0;
//            *((char *)(superImageData+(i+1)*superwidth*4+(j+1)*4*3+2))=0;
//            *((char *)(superImageData+(i+1)*superwidth*4+(j+1)*4*3+3))=255;
//            
//            *((char *)(superImageData+(i+1)*superwidth*4+(j+2)*4*3))=0;
//            *((char *)(superImageData+(i+1)*superwidth*4+(j+2)*4*3+1))=0;
//            *((char *)(superImageData+(i+1)*superwidth*4+(j+2)*4*3+2))=0;
//            *((char *)(superImageData+(i+1)*superwidth*4+(j+2)*4*3+3))=255;
//            
//            *((char *)(superImageData+(i+2)*superwidth*4+j*4*3))=0;
//            *((char *)(superImageData+(i+2)*superwidth*4+j*4*3+1))=0;
//            *((char *)(superImageData+(i+2)*superwidth*4+j*4*3+2))=0;
//            *((char *)(superImageData+(i+2)*superwidth*4+j*4*3+3))=255;
//            
//            *((char *)(superImageData+(i+2)*superwidth*4+(j+1)*4*3))=0;
//            *((char *)(superImageData+(i+2)*superwidth*4+(j+1)*4*3+1))=0;
//            *((char *)(superImageData+(i+2)*superwidth*4+(j+1)*4*3+2))=0;
//            *((char *)(superImageData+(i+2)*superwidth*4+(j+1)*4*3+3))=255;
//            
//            *((char *)(superImageData+(i+2)*superwidth*4+(j+2)*4*3))=0;
//            *((char *)(superImageData+(i+2)*superwidth*4+(j+2)*4*3+1))=0;
//            *((char *)(superImageData+(i+2)*superwidth*4+(j+2)*4*3+2))=0;
//            *((char *)(superImageData+(i+2)*superwidth*4+(j+2)*4*3+3))=255;
//        }
//    }
//    
//    int xmin=-1;
//    int xmax=1;
//    int ymin=-1;
//    int ymax=1;
//    
//    //int fre[320 * 480]={0};
//    CGPoint p=CGPointZero;
//    
//    float x=0.5;
//    //float x=arc4random()*1.0/ARC4RANDOM_MAX;
//    //float y=arc4random()*1.0/ARC4RANDOM_MAX;
//    float y=0.4;
//    p.x=x*(xmax-xmin)+xmin;
//    p.y=y*(ymax-ymin)+ymin;
//    
//    int MIN_ITERATE=20;
//    int ite_from_start=0;
//    
//    DataPoint point;
//    point.p=p;
//    point.red=0.0;
//    point.green=0.0;
//    point.blue=0.0;
//    
//    //IFSFunctions *ifsfunction=[[IFSFunctions alloc] init];
//    
//    for (int i=0; i<1000000; i++) {
//        if(p.x<=480 && p.x >=-480 && p.y <= 720 && p.y >= -720)
//        {
//            //fre[((int)p.y+240)*320+(int)p.x+160]++;
//            point=[ifsfunction caculate:point];
//            
//            int data_x=(int)(320*3*(point.p.x-xmin)/(xmax-xmin));
//            int data_y=(int)(480*3*(point.p.y-ymin)/(ymax-ymin));
//            
//            if(data_x >=0 && data_x<320*3 && data_y >=0 && data_y < 480*3 && ite_from_start < 20000)
//            {
//                ite_from_start++;
//                if(ite_from_start > MIN_ITERATE)
//                {
////                    *((char *)(imageData+data_y*width*4+data_x*4))=(int)point.red;
////                    *((char *)(imageData+data_y*width*4+data_x*4+1))=(int)point.green;
////                    *((char *)(imageData+data_y*width*4+data_x*4+2))=(int)point.blue;
//                    
////                    *((char *)(superImageData+data_y*superwidth*4+data_x*4))=((int)point.red+*((char *)(superImageData+data_y*superwidth*4+data_x*4)))/2;
////                    *((char *)(superImageData+data_y*superwidth*4+data_x*4+1))=((int)point.green+*((char *)(superImageData+data_y*superwidth*4+data_x*4+1)))/2;
////                    *((char *)(superImageData+data_y*superwidth*4+data_x*4+2))=((int)point.blue+*((char *)(superImageData+data_y*superwidth*4+data_x*4+2)))/2;
//                    //*((char *)(superImageData+data_y*superwidth*4+data_x*4))=(int)point.red;
//                    //*((char *)(superImageData+data_y*superwidth*4+data_x*4+1))=(int)point.green;
//                    //*((char *)(superImageData+data_y*superwidth*4+data_x*4+2))=(int)point.blue;
//                    
//                    
//                    point=[ifsfunction finalcaculate:point];
//                    if(data_x >=0 && data_x<320*3 && data_y >=0 && data_y < 480*3 && ite_from_start < 20000)
//                    {
//                        *((char *)(superImageData+data_y*superwidth*4+data_x*4))=(int)point.red;
//                        *((char *)(superImageData+data_y*superwidth*4+data_x*4+1))=(int)point.green;
//                        *((char *)(superImageData+data_y*superwidth*4+data_x*4+2))=(int)point.blue;
//                    }
//                    
//                }
//                fre[data_y*superwidth+data_x]++;
//                
//                
//            }
//            else
//            {
//                ite_from_start=0;
//                point=[ifsfunction caculate:point];
//            }
//        }
//    }
//    
//    int max_int=0;
//    for (int i=0; i<320*480*9; i++) {
//        if (fre[i]>max_int) {
//            max_int=fre[i];
//        }
//    }
//    //NSLog([NSString stringWithFormat:@"The max interation %f",logf(max_int+1)]);
//    for (int i=0; i<height; i++) {
//        for(int j=0;j<width;j++){
//            
//            int avg_fre=(fre[i*superwidth+j*3]+fre[i*superwidth+j*3+1]+fre[i*superwidth+j*3+2]+
//                         fre[(i+1)*superwidth+j*3]+fre[(i+1)*superwidth+j*3+1]+fre[(i+1)*superwidth+j*3+2]+
//                         fre[(i+2)*superwidth+j*3]+fre[(i+2)*superwidth+j*3+1]+fre[(i+2)*superwidth+j*3+2])/9;
//            
//            int max_fre=MAX(fre[i*superwidth+j*3], MAX(fre[i*superwidth+j*3+1], MAX(fre[i*superwidth+j*3+2], 
//                                                                                    MAX(fre[(i+1)*superwidth+j*3], MAX(fre[(i+1)*superwidth+j*3+1], MAX(fre[(i+1)*superwidth+j*3+2], MAX(fre[(i+2)*superwidth+j*3], MAX(fre[(i+2)*superwidth+j*3+1], fre[(i+2)*superwidth+j*3+2]))))))));
//            
//            float avg_red=(*((char *)(superImageData+i*superwidth*4+j*4*3))+*((char *)(superImageData+i*superwidth*4+(j+1)*4*3))+*((char *)(superImageData+i*superwidth*4+(j+2)*4*3))+
//                         *((char *)(superImageData+(i+1)*superwidth*4+j*4*3))+*((char *)(superImageData+(i+1)*superwidth*4+(j+1)*4*3))+*((char *)(superImageData+(i+1)*superwidth*4+(j+2)*4*3))+
//                         *((char *)(superImageData+(i+2)*superwidth*4+j*4*3))+*((char *)(superImageData+(i+2)*superwidth*4+(j+1)*4*3))+*((char *)(superImageData+(i+2)*superwidth*4+(j+2)*4*3)))/9.0;
//            
//            float avg_green=(*((char *)(superImageData+i*superwidth*4+j*4*3+1))+*((char *)(superImageData+i*superwidth*4+(j+1)*4*3+1))+*((char *)(superImageData+i*superwidth*4+(j+2)*4*3+1))+
//                         *((char *)(superImageData+(i+1)*superwidth*4+j*4*3+1))+*((char *)(superImageData+(i+1)*superwidth*4+(j+1)*4*3+1))+*((char *)(superImageData+(i+1)*superwidth*4+(j+2)*4*3+1))+
//                         *((char *)(superImageData+(i+2)*superwidth*4+j*4*3+1))+*((char *)(superImageData+(i+2)*superwidth*4+(j+1)*4*3+1))+*((char *)(superImageData+(i+2)*superwidth*4+(j+2)*4*3+1)))/9.0;
//            
//            float avg_blue=(*((char *)(superImageData+i*superwidth*4+j*4*3+2))+*((char *)(superImageData+i*superwidth*4+(j+1)*4*3+2))+*((char *)(superImageData+i*superwidth*4+(j+2)*4*3+2))+
//                         *((char *)(superImageData+(i+1)*superwidth*4+j*4*3+2))+*((char *)(superImageData+(i+1)*superwidth*4+(j+1)*4*3+2))+*((char *)(superImageData+(i+1)*superwidth*4+(j+2)*4*3+2))+
//                         *((char *)(superImageData+(i+2)*superwidth*4+j*4*3+2))+*((char *)(superImageData+(i+2)*superwidth*4+(j+1)*4*3+2))+*((char *)(superImageData+(i+2)*superwidth*4+(j+2)*4*3+2)))/9.0;
//            
////            float intensity=logf(fre[i*width+j]+1.0)/logf(max_int+1);
////            //NSLog([NSString stringWithFormat:@"The %f",intensity]);
////            float gamma=powf(intensity, 0.25);
////            *((char *)(imageData+i*width*4+j*4))=(int)(gamma*(*((char *)(imageData+i*width*4+j*4))));
////            *((char *)(imageData+i*width*4+j*4+1))=(int)(gamma*(*((char *)(imageData+i*width*4+j*4+1))));
////            *((char *)(imageData+i*width*4+j*4+2))=(int)(gamma*(*((char *)(imageData+i*width*4+j*4+2))));
//            
//            float intensity=logf(avg_fre+1.0)/logf(max_fre+1);
//            float gamma=powf(intensity, 0.25);
//            *((char *)(imageData+i*width*4+j*4))=(int)(gamma*avg_red);
//            *((char *)(imageData+i*width*4+j*4+1))=(int)(gamma*avg_green);
//            *((char *)(imageData+i*width*4+j*4+2))=(int)(gamma*avg_blue);
//        }
//    }
    
    
    
    
    CGDataProviderRef dataProvider=CGDataProviderCreateWithData(NULL, imageData, height * width * 4, NULL);
    CGImageRef imageRef=CGImageCreate(width, height, 8, 32, 4*width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big, dataProvider, NULL, NO, kCGRenderingIntentDefault);
    
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(dataProvider);
    CGContextDrawImage(contextRef, CGRectMake( 0, 0, width, height ), imageRef);
    
    //imgView.image=[UIImage imageWithCGImage:imageRef];
    UIImage *image=[UIImage imageWithCGImage:imageRef];
    [self performSelectorOnMainThread:@selector(completeGeneration:) withObject:image waitUntilDone:YES];
    CGImageRelease(imageRef);
    CGContextRelease(contextRef);
    free(imageData);
    free(superImageData);
    free(fre);
    free(fractal.pixels);
    free(choice);
    free(coeffs.ac);
    free(coeffs.bc);
    free(coeffs.cc);
    free(coeffs.dc);
    free(coeffs.ec);
    free(coeffs.fc);
    free(coeffs.colors);
    [pool release];
    
    
}

-(void)completeGeneration:(id)image
{
    imgView.image=image;
    //UIImageView *imageView=[[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //imageView.image=image;
    //[self.view addSubview:imageView];

    //[image release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [imgView release];
    [button release];
    [super dealloc];
}

@end
