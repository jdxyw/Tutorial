#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include "variations.h"

//globals

#define NVARIATIONS 6

//variations
V_func * variations;
V_func * variations1;
V_func * variations2;
V_func * variations3;
V_func * variations4;
V_func * variations5;
V_func * variations6;
V_func * variations7;
V_func * variations8;

int nv=0;

//final transformation
V_func * final;
F_params * finalfp;

flam3_xform* xform;

//nonlinear functions.  these are externally linked because pointers to them
//will be used in functio of this file
#define ARC4RANDOM_MAX      0x100000000
#define RSQUARED(c) ((c)->x*(c)->x + (c)->y*(c)->y)
#define INVRSQUARED(c) (1.0/RSQUARED(c))
#define R(c) (sqrtl(RSQUARED(c)))
#define INVR(c) (1.0/R(c))
#define EPS 0.000001
#define sincos(x,s,c) *(s)=sin(x); *(c)=cos(x);
#define NUMVAR 33
#define RANDOMXFORM (-1.0+2.0*1.0/(arc4random()%100))
#define Omega ((arc4random()/ARC4RANDOM_MAX)*M_PI)
#define Uniform_Random (arc4random()/ARC4RANDOM_MAX)

extern int flam3_random_bit(){
    static int n=0;
    static int l;
    if(0==n){
        l=random();
        n=20;
    }else{
        l=l>>1;
        n--;
    }
    return l&1;
}


extern void init_xform(){
    xform=(flam3_xform*)malloc(sizeof(flam3_xform));
    xform->blob_high=RANDOMXFORM;
    xform->blob_low=-RANDOMXFORM;
    xform->blob_waves=RANDOMXFORM;
    
    xform->pdj_a=RANDOMXFORM;
    xform->pdj_b=RANDOMXFORM;
    xform->pdj_c=RANDOMXFORM;
    xform->pdj_d=RANDOMXFORM;
    
    xform->fan2_x=RANDOMXFORM;
    xform->fan2_y=RANDOMXFORM;
    
    xform->rings2_val=RANDOMXFORM;
    
    xform->perspective_angle=RANDOMXFORM;
    xform->perspective_dist=RANDOMXFORM;
    
    xform->persp_vsin=RANDOMXFORM;
    xform->persp_vfcos=RANDOMXFORM;
    
    xform->radial_blur_angle=RANDOMXFORM;
    
    xform->disc2_rot=RANDOMXFORM;
    xform->disc2_twist=RANDOMXFORM;
    xform->disc2_sinadd=RANDOMXFORM;
    xform->disc2_cosadd=RANDOMXFORM;
    xform->disc2_timespi=RANDOMXFORM;
    
    xform->flower_petals=RANDOMXFORM;
    xform->flower_holes=RANDOMXFORM;
    
    xform->parabola_height=RANDOMXFORM;
    xform->parabola_width=RANDOMXFORM;
    
    xform->bent2_x=RANDOMXFORM;
    xform->bent2_y=RANDOMXFORM;
    
    xform->bipolar_shift=RANDOMXFORM;
    
    xform->cell_size=RANDOMXFORM;
    
    xform->cpow_r=RANDOMXFORM;
    xform->cpow_i=RANDOMXFORM;
    xform->cpow_power=RANDOMXFORM;
    
    xform->curve_xamp=RANDOMXFORM;
    xform->curve_yamp=RANDOMXFORM;
    
    xform->escher_beta = RANDOMXFORM;
    xform->lazysusan_space = RANDOMXFORM;
    xform->lazysusan_twist = RANDOMXFORM;
    xform->lazysusan_spin = RANDOMXFORM;
    xform->lazysusan_x = RANDOMXFORM;
    xform->lazysusan_y = RANDOMXFORM;
    xform->modulus_x = RANDOMXFORM;
    xform->modulus_y = RANDOMXFORM;
    xform->oscope_separation = RANDOMXFORM;
    xform->oscope_frequency = M_PI;
    xform->oscope_amplitude = RANDOMXFORM;
    xform->oscope_damping = RANDOMXFORM;
    xform->popcorn2_c = RANDOMXFORM;
    xform->popcorn2_x = RANDOMXFORM;
    xform->popcorn2_y = RANDOMXFORM;
    xform->separation_x = RANDOMXFORM;
    xform->separation_xinside = RANDOMXFORM;
    xform->separation_y = RANDOMXFORM;
    xform->separation_yinside = RANDOMXFORM;
    xform->split_xsize = RANDOMXFORM;
    xform->split_ysize = RANDOMXFORM;
    xform->splits_x = RANDOMXFORM;
    xform->splits_y = RANDOMXFORM;
    xform->stripes_space = RANDOMXFORM;
    xform->stripes_warp = RANDOMXFORM;
    xform->wedge_angle = RANDOMXFORM;
    xform->wedge_hole = RANDOMXFORM;
    xform->wedge_count = RANDOMXFORM;
    xform->wedge_swirl = RANDOMXFORM;
    xform->wedge_sph_angle = RANDOMXFORM;
    xform->wedge_sph_hole = RANDOMXFORM;
    xform->wedge_sph_count = RANDOMXFORM;
    xform->wedge_sph_swirl = RANDOMXFORM;
    
    xform->wedge_julia_power = RANDOMXFORM;
    xform->wedge_julia_dist = RANDOMXFORM;
    xform->wedge_julia_count = RANDOMXFORM;
    xform->wedge_julia_angle = RANDOMXFORM;
    xform->wedgeJulia_cf = RANDOMXFORM;
    xform->wedgeJulia_cn = RANDOMXFORM;
    xform->wedgeJulia_rN = RANDOMXFORM;
    xform->whorl_inside = RANDOMXFORM;
    xform->whorl_outside = RANDOMXFORM;
    
    xform->waves2_scalex = RANDOMXFORM;     
    xform->waves2_scaley = RANDOMXFORM;     
    xform->waves2_freqx = RANDOMXFORM;      
    xform->waves2_freqy = RANDOMXFORM;  
    
    xform->auger_freq = RANDOMXFORM;
    xform->auger_weight = RANDOMXFORM;
    xform->auger_sym = RANDOMXFORM;
    xform->auger_scale = RANDOMXFORM;     
    
    xform->flux_spread = RANDOMXFORM;
    
    xform->julian_power = RANDOMXFORM;
    xform->julian_dist = RANDOMXFORM;
    xform->julian_rN = RANDOMXFORM;
    xform->julian_cn = RANDOMXFORM;
    xform->juliascope_power = RANDOMXFORM;
    xform->juliascope_dist = RANDOMXFORM;
    xform->juliascope_rN = RANDOMXFORM;
    xform->juliascope_cn = RANDOMXFORM;
    xform->radialBlur_spinvar = RANDOMXFORM;
    xform->radialBlur_zoomvar = RANDOMXFORM;
    xform->pie_slices = RANDOMXFORM;
    xform->pie_rotation = RANDOMXFORM;
    xform->pie_thickness = RANDOMXFORM;
    xform->ngon_sides = RANDOMXFORM;
    xform->ngon_power = RANDOMXFORM;
    xform->ngon_circle = RANDOMXFORM;
    xform->ngon_corners = RANDOMXFORM;
    xform->curl_c1 = RANDOMXFORM;
    xform->curl_c2 = RANDOMXFORM;
    xform->rectangles_x = RANDOMXFORM;
    xform->rectangles_y = RANDOMXFORM;
    xform->amw_amp = RANDOMXFORM;
    xform->super_shape_rnd = RANDOMXFORM;
    xform->super_shape_m = RANDOMXFORM;
    xform->super_shape_n1 = RANDOMXFORM;
    xform->super_shape_n2 = RANDOMXFORM;
    xform->super_shape_n3 = RANDOMXFORM;
    xform->super_shape_holes = RANDOMXFORM;
    xform->conic_eccentricity = RANDOMXFORM;
}

//linear
//NO FP, NO VP
extern int v0(coords * c,
              F_params * fp,
              V_params * vp){
  //v0 doesn't modify anything
  return 1;              
}

//sinusoidal
//NO FP, NO VP
extern int v1(coords * c,
              F_params * fp,
              V_params * vp){
  c->x=sinl(c->x);
  c->y=sinl(c->y);            
  return 1;            
}

//spherical
//NO FP, NO VP
extern int v2(coords * c,
              F_params * fp,
              V_params * vp){
  static long double invrsquared;
  invrsquared = INVRSQUARED(c);
  c->x=c->x*invrsquared;
  c->y=c->y*invrsquared;            
  return 1;            
}

//swirl
//NO FP, NO VP
extern int v3(coords * c,
              F_params * fp,
              V_params * vp){
  static long double rsquared; 
  static long double sinrs;
  static long double cosrs;
  
  rsquared = RSQUARED(c);
  sinrs = sinl(rsquared);
  cosrs = cosl(rsquared);
  c->x = c->x*sinrs - c->y*cosrs;
  c->y = c->x*cosrs + c->y*sinrs;
  return 1;
}

//horseshoe
//NO FP, NO VP
//extern int v4(coords * c,
//              F_params * fp,
//              V_params * vp){
//  static long double invr;
//  invr = INVR(c);
//  c->x = invr*(c->x - c->y)*(c->x + c->y);
//  c->y = invr*2.0*c->x*c->y;
//  return 1;              
//}

//polar
extern int v4(coords *c,
              F_params *fp,
              V_params *vp){
    float theta=atan2(c->x,c->y);
    float r=R(c);
    
    c->x=theta/M_PI;
    c->y=r-1.0;
    
    return 1;
}

//handkerchief
extern int v5(coords *c,
              F_params *fp,
              V_params *vp){
    float theta=atan2(c->x,c->y);
    float r=R(c);
    
    c->x=sinl(theta+r)*r;
    c->y=cosl(theta-r)*r;
    return 1;
}

//heart
extern int v6(coords *c,
              F_params *fp,
              V_params *vp){
    float theta=atan2(c->x,c->y);
    float r=R(c);
    theta*=r;
    
    c->x=sin(theta)*r;
    c->y=cos(theta)*(-r);
    return 1;
}

//disc
extern int v7(coords *c,
              F_params *fp,
              V_params *vp){
    float piX=c->x*M_PI;
    float piY=c->y*M_PI;
    float theta=atan2(piX,piY);
    float r=sqrt(piX*piX+piY*piY);
    
    c->x=sinl(r)*theta/M_PI;
    c->y=cosl(r)*theta/M_PI;
    return 1;
}

//spiral
extern int v8(coords *c,
              F_params *fp,
              V_params *vp){
    float theta=atan2(c->x,c->y);
    float r=R(c)+EPS;
    
    c->x=(cosl(theta)+sinl(r))/r;
    c->y=(sinl(theta)-cosl(r))/r;
    return 1;
}

//hyperbolic
extern int v9(coords *c,
              F_params *fp,
              V_params *vp){
    float theta=atan2(c->x,c->y);
    float r=R(c)+EPS;
    
    c->x=sinl(theta)/r;
    c->y=cosl(theta)*r;
    return 1;
}

//diamond
extern int v10(coords *c,
               F_params *fp,
               V_params *vp){
    float theta=atan2(c->x,c->y);
    float r=R(c)+EPS;
    
    c->x=sinl(theta)*cosl(r);
    c->y=cosl(theta)*sinl(r);
    return 1;
}

//ex
extern int v11(coords *c,
               F_params *fp,
               V_params *vp){
    float theta=atan2(c->x,c->y);
    float r=R(c)+EPS;
    
    double n0=sinl(theta+r);
    double n1=cosl(theta-r);
    
    double m0=n0*n0*n0*r;
    double m1=n1*n1*n1*r;
    
    c->x=m0+m1;
    c->y=m0-m1;
    return 1;
}

//Julia
extern int v12(coords *c,
               F_params *fp,
               V_params *vp){
    
    double theta=atan2(c->x,c->y)/2.0;
    if(flam3_random_bit()) theta+=M_PI;
    double r=pow(c->x*c->x+c->y*c->y,0.25);
    c->x=r*cosl(theta);
    c->y=r*sinl(theta);
    return 1;
}

//bent
extern int v13(coords *c,
               F_params *fp,
               V_params *vp){
    if(c->x < 0.0)
        c->x=c->x*2.0;
    if(c->y < 0.0)
        c->y=c->y/2.0;
    return 1;
}

//waves
extern int v14(coords *c,
               F_params *fp,
               V_params *vp){
    
    //Currently I use the bent implementation
    if(c->x < 0.0)
        c->x=c->x*2.0;
    if(c->y < 0.0)
        c->y=c->y/2.0;
    return 1;
}

//fisheye
extern int v15(coords *c,
               F_params *fp,
               V_params *vp){
    double theta=atan2(c->x,c->y);
    double r=R(c);
    r=2*r/(r+1);
    
    c->x=r*cosl(theta);
    c->y=r*sinl(theta);
    return 1;
}

//popcorn
extern int v16(coords *c,
               F_params *fp,
               V_params *vp){
    //Currently, I use the exponential imlementation
    double dx=exp(c->x-1.0);
    double dy=c->y*M_PI;
    
    c->x=cosl(dy)*dx;
    c->y=sinl(dy)*dx;
    return 1;
    
}

//exponential
extern int v17(coords *c,
               F_params *fp,
               V_params *vp){
    double dx=exp(c->x-1.0);
    double dy=c->y*M_PI;
    
    c->x=cosl(dy)*dx;
    c->y=sinl(dy)*dx;
    return 1;
}

//power
extern int v18(coords *c,
               F_params *fp,
               V_params *vp){
    double theta=atan2(c->x,c->y);
    double r=R(c);
    
    double rTheta=pow(r,sinl(theta));
    
    c->x=rTheta*cosl(theta);
    c->y=rTheta*sinl(theta);
    return 1;
}

//cosine
extern int v19(coords *c,
               F_params *fp,
               V_params *vp){
    c->x=cosl(c->x*M_PI)*cosh(c->y);
    c->y= -sin(c->x*M_PI)*sinh(c->y);
    
    return 1;
}

//rings
extern int v20(coords *c,
               F_params *fp,
               V_params *vp){
    
    //Currently, I use the cosine to instead
    c->x=cosl(c->x*M_PI)*cosh(c->y);
    c->y= -sin(c->x*M_PI)*sinh(c->y);
    
    return 1;
}

//fan
extern int v21(coords *c,
               F_params *fp,
               V_params *vp){
    
    //Currently, I use the cosine to instead
    c->x=cosl(c->x*M_PI)*cosh(c->y);
    c->y= -sin(c->x*M_PI)*sinh(c->y);
    
    return 1;
    
}

//blob
extern int v22(coords *c,
               F_params *fp,
               V_params *vp){
    double theta=atan2(c->x, c->y);
    double r=R(c);
    r=r*(xform->blob_low+(xform->blob_high-xform->blob_low)*
         (0.5+0.5*sin(xform->blob_waves*theta)));
    
    c->x=sin(theta)*r;
    c->y=cos(theta)*r;
    return 1;
}

//pdj
extern int v23(coords *c,
               F_params *fp,
               V_params *vp){
    double nx1=cos(xform->pdj_b*c->x);
    double nx2=sin(xform->pdj_c*c->x);
    double ny1=sin(xform->pdj_a*c->y);
    double ny2=cos(xform->pdj_d*c->y);
    
    c->x=ny1-nx1;
    c->y=nx2-ny2;
    return 1;
}

//fan2
extern int v24(coords *c,
               F_params *fp,
               V_params *vp){
    double theta=atan2(c->x, c->y);
    double r=R(c);
    
    double dy=xform->fan2_y;
    double dx=M_PI*(xform->fan2_x*xform->fan2_x+EPS);
    double dx2=dx*0.5;
    double t=theta+dy-dx*(int)((theta+dy)/dx);
    if(t>dx2)
        theta=theta-dx2;
    else
        theta=theta+dx2;
    
    c->x=sin(theta)*r;
    c->y=cos(theta)*r;
    return 1;
}

//rings2
extern int v25(coords *c,
               F_params *fp,
               V_params *vp){
    double theta=atan2(c->x,c->y);
    double r=R(c);
    double dx=xform->rings2_val*xform->rings2_val+EPS;
	r += -2.0*dx*(int)((r+dx)/(2.0*dx)) + r * (1.0-dx);
	
	c->x=sin(theta)*r;
	c->y=cos(theta)*r;
	return 1;
}

//eyefish
extern int v26(coords *c,
               F_params *fp,
               V_params *vp){
	double r= 2.0 / (R(c)+1.0);
	
	c->x = r*c->x;
	c->y = r*c->y;
	return 1;
}

//bubble
extern int v27(coords *c,
               F_params *fp,
               V_params *vp){
    //currently use the eyefish
    double r= 4.0 / (R(c)+4.0);
	
	c->x = r*c->x;
	c->y = r*c->y;
	return 1;
}

//cylinder
extern int v28(coords *c,
               F_params *fp,
               V_params *vp){
	c->x=sin(c->x);
	c->y=c->y;
	
	return 1;
}

//perspective
extern int v29(coords *c,
               F_params *fp,
               V_params *vp){
	double t = 1.0 / (xform->perspective_dist - c->y * xform->persp_vsin);
	
	c->x=xform->perspective_dist * c->x * t;
	c->y=xform->persp_vfcos * c->y * t;
	return 1;
}

//noise
extern int v30(coords *c,
               F_params *fp,
               V_params *vp){
	double tmpr, sinr, cosr, r;
	tmpr = Uniform_Random * 2 * M_PI;
	sinr=sin(tmpr);
	cosr=cos(tmpr);
	r=Uniform_Random;
	
	c->x=c->x*r*cosr;
	c->y=c->y*r*sinr;
	return 1;
}

//JuliaN
extern int v31(coords *c,
               F_params *fp,
               V_params *vp){
	int t_rnd = trunc((xform->julian_rN)*Uniform_Random);
    double theta=atan2(c->x, c->y);
    double tempr=(t_rnd*2*M_PI+theta)/xform->julian_power;
    double r=pow(R(c), xform->julian_power/xform->julian_dist);
    double sina=sin(tempr);
    double cosa=cos(tempr);
    
    c->x=r*cosa;
    c->y=r*sina;
	return 1;
}

//JuliaScope
extern int v32(coords *c,
               F_params *fp,
               V_params *vp){
    int t_rnd = trunc((xform->juliascope_rN) * Uniform_Random);
    
    double tmpr, r;
    double sina, cosa;
    
    if ((t_rnd & 1) == 0)
        tmpr = (2 * M_PI * t_rnd + RANDOMXFORM*atan2(c->x, c->y)) / xform->juliascope_power;
    else
        tmpr = (2 * M_PI * t_rnd - RANDOMXFORM*atan2(c->x, c->y)) / xform->juliascope_power;
    
    sincos(tmpr,&sina,&cosa);
    
    r = pow(R(c), xform->juliascope_dist/xform->juliascope_power);
    
    c->x=r*cosa;
    c->x=r*sina;
    return 1;
}

//Blur
extern int v33(coords *c,
               F_params *fp,
               V_params *vp){
    double tmpr, sinr, cosr, r;
    
    tmpr = Uniform_Random * 2 * M_PI;
    sincos(tmpr,&sinr,&cosr);
    r = Uniform_Random;
    
    c->x=r*cosr;
    c->y=r*sinr;
    return 1;

}

//gaussian
extern int v34(coords *c,
               F_params *fp,
               V_params *vp){
    double ang, r, sina, cosa;
    
    ang =Uniform_Random * 2 * M_PI;
    sincos(ang,&sina,&cosa);
    
    r = Uniform_Random+Uniform_Random+Uniform_Random+Uniform_Random - 2.0 ;
    
    c->x=r*cosa;
    c->y=r*sina;
    return 1;
}

//radial blur
extern int v35(coords *c,
               F_params *fp,
               V_params *vp){
    double rndG, ra, rz, tmpa, sa, ca;
    
    /* Get pseudo-gaussian */
    rndG = Uniform_Random+Uniform_Random+Uniform_Random+Uniform_Random - 2.0 ;
    
    /* Calculate angle & zoom */
    ra = R(c);
    tmpa = atan2(c->x, c->y) + xform->radialBlur_spinvar*rndG;
    sincos(tmpa,&sa,&ca);
    rz = xform->radialBlur_zoomvar * rndG - 1;
    
    c->x= ra*ca+rz*c->x;
    c->y= ra*sa+rz*c->y;
    return 1;
}

//pie
extern int v36(coords *c,
               F_params *fp,
               V_params *vp){
    double a, r, sa, ca;
    int sl;
    
    sl = (int) (Uniform_Random * xform->pie_slices + 0.5);
    a = xform->pie_rotation +
    2.0 * M_PI * (sl + Uniform_Random* xform->pie_thickness) / xform->pie_slices;
    r = RANDOMXFORM;
    sincos(a,&sa,&ca);
    
    c->x=r*ca;
    c->y=r*sa;
    return 1;
}




//public functions (in the header)

//loads variations, allocates memory for variations and assigns them for use
//returns the number of variations initialized on success, 0 on failure
extern int init_variations(){
  int j;
  init_xform();
  int (*v[])(coords * c,
           F_params * fp,
           V_params * vp) = { &v0, &v1, &v2, &v3, &v4,
                              &v5, &v6, &v7, &v8, &v9,
                              &v10,&v11,&v12,&v13,&v14,
                              &v15,&v16,&v17,&v18,&v19,
                              &v20,&v21,&v22,&v23,&v24,
                              &v25,&v26,&v27,&v28,&v29,
                              &v30,&v31,&v32,&v33,&v34,
                              &v35,&v36};
  V_params vp;
  //try and load variations
  /*
  if(!load_variations()){
    printf("init_variations: load_variations failed... returning FALSE\n");
    return 0;
  }
  */
  //fill variations array
  nv = NVARIATIONS;
  vp.p = NULL;
  vp.np = 0;
  variations = malloc(sizeof(V_func) * nv);
    variations1 = malloc(sizeof(V_func) * nv);
    variations2 = malloc(sizeof(V_func) * nv);
    variations3 = malloc(sizeof(V_func) * nv);
    variations4 = malloc(sizeof(V_func) * nv);
    variations5 = malloc(sizeof(V_func) * nv);
    variations6 = malloc(sizeof(V_func) * nv);
    variations7 = malloc(sizeof(V_func) * nv);
    variations8 = malloc(sizeof(V_func) * nv);
  for(j=0; j<nv; j++){
    variations[j].v=v[arc4random()%NUMVAR];
    variations[j].use_fp = 0;
    variations[j].use_vp = 0;
    variations[j].vp = vp;
  }

    for(j=0; j<nv; j++){
        variations1[j].v=v[arc4random()%NUMVAR];
        variations1[j].use_fp = 0;
        variations1[j].use_vp = 0;
        variations1[j].vp = vp;
    }

    for(j=0; j<nv; j++){
        variations2[j].v=v[arc4random()%NUMVAR];
        variations2[j].use_fp = 0;
        variations2[j].use_vp = 0;
        variations2[j].vp = vp;
    }

    for(j=0; j<nv; j++){
        variations3[j].v=v[arc4random()%NUMVAR];
        variations3[j].use_fp = 0;
        variations3[j].use_vp = 0;
        variations3[j].vp = vp;
    }

    for(j=0; j<nv; j++){
        variations4[j].v=v[arc4random()%NUMVAR];
        variations4[j].use_fp = 0;
        variations4[j].use_vp = 0;
        variations4[j].vp = vp;
    }
    for(j=0; j<nv; j++){
        variations5[j].v=v[arc4random()%NUMVAR];
        variations5[j].use_fp = 0;
        variations5[j].use_vp = 0;
        variations5[j].vp = vp;
    }
    for(j=0; j<nv; j++){
        variations6[j].v=v[arc4random()%NUMVAR];
        variations6[j].use_fp = 0;
        variations6[j].use_vp = 0;
        variations6[j].vp = vp;
    }
    for(j=0; j<nv; j++){
        variations7[j].v=v[arc4random()%NUMVAR];
        variations7[j].use_fp = 0;
        variations7[j].use_vp = 0;
        variations7[j].vp = vp;
    }
    for(j=0; j<nv; j++){
        variations8[j].v=v[arc4random()%NUMVAR];
        variations8[j].use_fp = 0;
        variations8[j].use_vp = 0;
        variations8[j].vp = vp;
    }

  //final transformation
  final = malloc(sizeof(V_func));
  final->v=v[arc4random()%NUMVAR];
  final->use_fp = 0;
  final->use_vp = 0;
  //final->vp will just contain some random bit pattern
  finalfp = NULL;
  /*
  for(j=0; j<nv; j++){
    variations[j] = get_variation(j);
    if(variations[j] == NULL){
      printf("init_variations: get_variation(%d) failed... returning FALSE\n");
      return 0;
    }
  }
  */
  
  return nv;
}

//only call this after init_variations has been called, so nv will be set
extern int cleanup_variations(){
  int j;
  
  printf("cleanup_variations: about to free\n");
  
  for(j=0; j<nv; j++){
    if(variations[j].vp.np != 0)
      free(variations[j].vp.p);
  }
  free(variations);
  free(final);
  free(xform);
  return 1;
}

//accessors

extern V_func * get_variations(){
  return variations;
}
extern V_func * get_variations1(){
    return variations1;
}
extern V_func * get_variations2(){
    return variations2;
}
extern V_func * get_variations3(){
    return variations3;
}
extern V_func * get_variations4(){
    return variations4;
}
extern V_func * get_variations5(){
    return variations5;
}
extern V_func * get_variations6(){
    return variations6;
}
extern V_func * get_variations7(){
    return variations7;
}
extern V_func * get_variations8(){
    return variations8;
}

extern V_func * get_final(){
  return final;
}

#define NONLINEAR(v,c,fp) ((*(v)->v)(c, fp, &(v)->vp))

//run nonlinear function
//returns v->v's return value
extern int run_v(V_func * v, coords * c, F_params * fp){
  return NONLINEAR(v,c,fp);
}
