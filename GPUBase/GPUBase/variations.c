#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include "variations.h"

//globals

#define NVARIATIONS 5

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

#define RSQUARED(c) ((c)->x*(c)->x + (c)->y*(c)->y)
#define INVRSQUARED(c) (1.0/RSQUARED(c))
#define R(c) (sqrtl(RSQUARED(c)))
#define INVR(c) (1.0/R(c))
#define EPS 0.000001

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

#define RANDOMXFORM (-1.0+2.0*1.0/(arc4random()%100))

extern void init_xform(){
    xform=(flam3_xform*)malloc(sizeof(flam3_xform));
    
    xform->blob_high=RANDOMXFORM;
    xform->blob_low=-1.0;
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
                              &v20,&v21,&v22,&v23,&v24};
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
    variations[j].v=v[arc4random()%25];
    variations[j].use_fp = 0;
    variations[j].use_vp = 0;
    variations[j].vp = vp;
  }

    for(j=0; j<nv; j++){
        variations1[j].v=v[arc4random()%25];
        variations1[j].use_fp = 0;
        variations1[j].use_vp = 0;
        variations1[j].vp = vp;
    }

    for(j=0; j<nv; j++){
        variations2[j].v=v[arc4random()%25];
        variations2[j].use_fp = 0;
        variations2[j].use_vp = 0;
        variations2[j].vp = vp;
    }

    for(j=0; j<nv; j++){
        variations3[j].v=v[arc4random()%25];
        variations3[j].use_fp = 0;
        variations3[j].use_vp = 0;
        variations3[j].vp = vp;
    }

    for(j=0; j<nv; j++){
        variations4[j].v=v[arc4random()%25];
        variations4[j].use_fp = 0;
        variations4[j].use_vp = 0;
        variations4[j].vp = vp;
    }
    for(j=0; j<nv; j++){
        variations5[j].v=v[arc4random()%25];
        variations5[j].use_fp = 0;
        variations5[j].use_vp = 0;
        variations5[j].vp = vp;
    }
    for(j=0; j<nv; j++){
        variations6[j].v=v[arc4random()%25];
        variations6[j].use_fp = 0;
        variations6[j].use_vp = 0;
        variations6[j].vp = vp;
    }
    for(j=0; j<nv; j++){
        variations7[j].v=v[arc4random()%25];
        variations7[j].use_fp = 0;
        variations7[j].use_vp = 0;
        variations7[j].vp = vp;
    }
    for(j=0; j<nv; j++){
        variations8[j].v=v[arc4random()%25];
        variations8[j].use_fp = 0;
        variations8[j].use_vp = 0;
        variations8[j].vp = vp;
    }

  //final transformation
  final = malloc(sizeof(V_func));
  final->v=v[arc4random()%25];
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
