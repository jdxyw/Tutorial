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

#define ARC4RANDOM_MAX      0x100000000

@implementation IFSViewController

@synthesize imgView;

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
    
    int width=320;
    int height=480;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc( height * width * 4 );
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
        }
    }
    
    int xmin=-2;
    int xmax=2;
    int ymin=-2;
    int ymax=2;
    
    int fre[320 * 480]={0};
    
    CGPoint p=CGPointZero;
    
    float x=arc4random()*1.0/ARC4RANDOM_MAX;
    float y=arc4random()*1.0/ARC4RANDOM_MAX;
    
    p.x=x*(xmax-xmin)+xmin;
    p.y=y*(ymax-ymin)+ymin;
    
    int MIN_ITERATE=10;
    int ite_from_start=0;
    
    IFSFunctions *ifsfunction=[[IFSFunctions alloc] init];
    
    for (int i=0; i<1000000; i++) {
        if(p.x<=160 && p.x >=-160 && p.y <= 240 && p.y >= -240)
        {
            //fre[((int)p.y+240)*320+(int)p.x+160]++;
                p=[ifsfunction caculate:p];
            
            int data_x=(int)(320*(p.x-xmin)/(xmax-xmin));
            int data_y=(int)(480*(p.y-ymin)/(ymax-ymin));
            
            if(data_x >=0 && data_x<320 && data_y >=0 && data_y < 480 && ite_from_start < 20000)
            {
                ite_from_start++;
                if(ite_from_start > MIN_ITERATE)
                {
                    *((char *)(imageData+data_y*width*4+data_x*4))=255;
                    *((char *)(imageData+data_y*width*4+data_x*4+1))=125;
                    *((char *)(imageData+data_y*width*4+data_x*4+2))=55;
                }
                fre[data_y*width+data_x]++;
            }
            else
            {
                ite_from_start=0;
                p=[ifsfunction caculate:p];
            }
        }
    }
    
    int max_int=0;
    for (int i=0; i<320*480; i++) {
        if (fre[i]>max_int) {
            max_int=fre[i];
        }
    }
    NSLog([NSString stringWithFormat:@"The max interation %f",logf(max_int+1)]);
//    for (int i=0; i<height; i++) {
//        for(int j=0;j<width;j++){
//            float intensity=logf(fre[i*width+j]+1.0)/logf(max_int+1);
//            //NSLog([NSString stringWithFormat:@"The %f",intensity]);
//            //float gamma=powf(intensity, 0.25);
//            *((char *)(imageData+i*width*4+j*4))=(int)intensity*255;
//            *((char *)(imageData+i*width*4+j*4+1))=(int)intensity*125;;
//            *((char *)(imageData+i*width*4+j*4+2))=(int)intensity*55;;
//        }
//    }
    
    CGDataProviderRef dataProvider=CGDataProviderCreateWithData(NULL, imageData, height * width * 4, NULL);
    CGImageRef imageRef=CGImageCreate(width, height, 8, 32, 4*width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big, dataProvider, NULL, NO, kCGRenderingIntentDefault);
    
    CGColorSpaceRelease(colorSpace);
    CGDataProviderRelease(dataProvider);
    CGContextDrawImage(contextRef, CGRectMake( 0, 0, width, height ), imageRef);
    
    imgView.image=[UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    CGContextRelease(contextRef);
    free(imageData);

    // Do any additional setup after loading the view from its nib.
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
    [super dealloc];
}

@end
