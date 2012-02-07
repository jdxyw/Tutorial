#include "global.h"

#ifndef VARIATIONS_H
#define VARIATIONS_H

//POSSIBLE OPTIMIZATION.  instead of using function pointers, just use a macro 
//to make function names instead of function pointers.  can we make function
//names at runtime... probably not, actually.

//nonlinear transformation
typedef struct {
  int (*v)(coords * c,
           F_params * fp,
           V_params * vp);
  int use_fp;
  int use_vp;
  V_params vp;
} V_func;

typedef struct xform {
//    double var[flam3_nvariations];   /* interp coefs between variations */
//    double c[3][2];      /* the coefs to the affine part of the function */
//    double post[3][2];   /* the post transform */
//    double density;      /* probability that this function is chosen. 0 - 1 */
//    double color;     /* color coords for this function. 0 - 1 */
//    double color_speed;  /* scaling factor on color added to current iteration */
//    double animate;      /* whether or not this xform rotates (in sheep) >0 means stationary */
//    double opacity;   /* 0=invisible, 1=totally visible */
//    double vis_adjusted; /* adjusted visibility for better transitions */
//    
//    int padding;/* Set to 1 for padding xforms */
//    double wind[2]; /* winding numbers */
//    
//    int precalc_angles_flag;
//    int precalc_atan_xy_flag;
//    int precalc_atan_yx_flag;
//    double has_preblur;
//    int has_post;
    
    /* Params for new parameterized variations */
    /* Blob */
    double blob_low;
    double blob_high;
    double blob_waves;
    
    /* PDJ */
    double pdj_a;
    double pdj_b;
    double pdj_c;
    double pdj_d;
    
    /* Fan2 */
    double fan2_x;
    double fan2_y;
    
    /* Rings2 */
    double rings2_val;
    
    /* Perspective */
    double perspective_angle;
    double perspective_dist;
    
    /* Julia_N */
    double julian_power;
    double julian_dist;
    
    /* Julia_Scope */
    double juliascope_power;
    double juliascope_dist;
    
    /* Radial_Blur */
    double radial_blur_angle;
    
    /* Pie */
    double pie_slices;
    double pie_rotation;
    double pie_thickness;
    
    /* Ngon */
    double ngon_sides;
    double ngon_power;
    double ngon_circle;
    double ngon_corners;
    
    /* Curl */
    double curl_c1;
    double curl_c2;
    
    /* Rectangles */
    double rectangles_x;
    double rectangles_y;
    
    /* AMW */
    double amw_amp;
    
    /* Disc 2 */
    double disc2_rot;
    double disc2_twist;
    
    /* Supershape */
    double super_shape_rnd;
    double super_shape_m;
    double super_shape_n1;
    double super_shape_n2;
    double super_shape_n3;
    double super_shape_holes;
    
    /* Flower */
    double flower_petals;
    double flower_holes;
    
    /* Conic */
    double conic_eccentricity;
    double conic_holes;
    
    /* Parabola */
    double parabola_height;
    double parabola_width;
    
    /* Bent2 */
    double bent2_x;
    double bent2_y;
    
    /* Bipolar */
    double bipolar_shift;
    
    /* Cell */
    double cell_size;
    
    /* Cpow */
    double cpow_r;
    double cpow_i;
    double cpow_power; /* int in apo */
    
    /* Curve */
    double curve_xamp,curve_yamp;
    double curve_xlength,curve_ylength;
    
    /* Escher */
    double escher_beta;
    
    /* Lazysusan */
    double lazysusan_spin;
    double lazysusan_space;
    double lazysusan_twist;
    double lazysusan_x, lazysusan_y;
    
    /* Modulus */
    double modulus_x, modulus_y;
    
    /* Oscope */
    double oscope_separation;
    double oscope_frequency;
    double oscope_amplitude;
    double oscope_damping;
    
    /* Popcorn2 */
    double popcorn2_x, popcorn2_y, popcorn2_c;
    
    /* Separation */
    double separation_x, separation_xinside;
    double separation_y, separation_yinside;
    
    /* Split */
    double split_xsize;
    double split_ysize;
    
    /* Splits */
    double splits_x,splits_y;
    
    /* Stripes */
    double stripes_space;
    double stripes_warp;
    
    /* Wedge */
    double wedge_angle, wedge_hole;
    double wedge_count, wedge_swirl;
    
    /* Wedge_Julia */
    double wedge_julia_angle;
    double wedge_julia_count;
    double wedge_julia_power;
    double wedge_julia_dist;
    
    /* Wedge_Sph */
    double wedge_sph_angle, wedge_sph_count;
    double wedge_sph_hole, wedge_sph_swirl;
    
    /* Whorl */
    double whorl_inside, whorl_outside;
    
    /* Waves2 */
    double waves2_freqx, waves2_scalex;
    double waves2_freqy, waves2_scaley;
    
    /* Auger */
    double auger_sym, auger_weight;
    double auger_freq, auger_scale;
    
    /* Flux */
    double flux_spread;
    
    /* If perspective is used, precalculate these values */
    /* from the _angle and _dist                         */
    double persp_vsin;
    double persp_vfcos;
    
    /* If Julia_N is used, precalculate these values */
    double julian_rN;
    double julian_cn;
    
    /* If Julia_Scope is used, precalculate these values */
    double juliascope_rN;
    double juliascope_cn;
    
    /* if Wedge_Julia, precalculate */
    double wedgeJulia_rN;
    double wedgeJulia_cn;
    double wedgeJulia_cf;
    
    /* If Radial_Blur is used, precalculate these values */
    double radialBlur_spinvar;
    double radialBlur_zoomvar;
    
    /* Precalculate these values for waves */
    double waves_dx2;
    double waves_dy2;
    
    /* If disc2 is used, precalculate these values */
    double disc2_sinadd;
    double disc2_cosadd;
    double disc2_timespi;
    
//    /* If supershape is used, precalculate these values */
//    double super_shape_pm_4;
//    double super_shape_pneg1_n1;
//    
//    int num_active_vars;
//    double active_var_weights[flam3_nvariations];
//    int varFunc[flam3_nvariations];
//    
//    int motion_freq;
//    int motion_func;
//    
//    struct xform *motion;
//    int num_motion;
    
    
} flam3_xform;


//public

//initialization/teardown

extern int init_variations();
extern int cleanup_variations();

//accessors  
        
extern V_func * get_variations();
extern V_func * get_final();

//run functions
extern int run_v(V_func * v, coords * c, F_params * fp);

#endif
