#!/bin/csh
#
# The LM Job
#
rm -f cosmo_eu_job
#################################################
# number of processors
#################################################

set NPX=2
set NPY=2
set NPIO=0
set CPN=4                   # cores per node
set NP1=`expr $NPX \* $NPY`
set NP=4
set N1=`expr $NP + $CPN - 1`
set NODES=`expr $N1 \/ $CPN` # number of physical nodes

set DATE=2018121400
set RUNDIR=$PWD
set FORM=ncdf
set BASE=/home/winash12/meteorology_project/cosmo_weather_model/reference_data
set INIDIR=$BASE/COSMO_7_input
set BD_DIR=$BASE/COSMO_7_input
set OUTPUT=$BASE/COSMO_7_output
cat > cosmo_eu_job << ****

#################################################
# batch commandos
#################################################

#PBS -q xc_normal
#PBS -l select=$NODES
#PBS -l place=scatter
#PBS -j oe
#PBS -N cosmo7

cd ${RUNDIR}

#################################################
# global settings
#################################################

rm -f YU* M_*
#rm -f $OUTPUT/l*


#################################################
# cat together the INPUT*-files
#################################################

cat > INPUT_ORG << end_input_org
 &LMGRID
  startlat_tot  = 5.0, startlon_tot  = 65.0,
  pollat=90.0,        pollon=-180.0,
  dlat=0.0625,        dlon=0.0625,
  ie_tot=401,         je_tot=561,        ke_tot=50,
 /
 &RUNCTL
  hstart = 0.0,   hstop  = 120.0,   dt      = 66.0,    ydate_ini='$DATE',
  nprocx = $NPX,  nprocy = $NPY,   nprocio = $NPIO,
  lphys      = .TRUE.,   luse_rttov    = .FALSE.,   luseobs = .FALSE.,  leps = .FALSE.,
  lreorder   = .FALSE.,  lreproduce    = .FALSE.,   itype_timing = 4,
  ldatatypes = .TRUE.,   ltime_barrier = .FALSE.,   ncomm_type=3,
  nboundlines=3, idbg_level = 22, lartif_data=.FALSE,
  ldfi=.FALSE., ldebug_io=.TRUE., lprintdeb_all=.FALSE.,
 /
 &TUNING
  c_soil   =   1.0,
  clc_diag =   0.5,
  crsmin   = 150.0,
  qc0      =   0.0,
  q_crit   =   4.0,
  qi0      =   0.0,
  rat_can  =   1.0,
  rat_lam  =   1.0,
  rat_sea  =  10.0,
  tur_len  = 500.0,
  v0snow   =  25.0,
  tkhmin   =   0.4,
  tkmmin   =   0.4,
  cloud_num= 100.0e6,
 /
end_input_org

cat > INPUT_IO  << end_input_io
 &IOCTL
  lasync_io=.FALSE., l_ke_in_gds=.TRUE., ngribout=1,
  yform_read='ncdf',
 /
 &DATABASE
 /
 &GRIBIN
  lan_t_so0=.TRUE., lan_t_cl=.TRUE., lan_w_cl=.TRUE., lan_vio3=.TRUE.,
  lan_hmo3=.TRUE., lan_plcov=.TRUE., lan_lai=.TRUE., lan_rootdp=.TRUE.,
  lan_t_snow=.TRUE., lan_w_i=.TRUE., lan_w_snow=.TRUE., lan_rho_snow=.TRUE.,
  lan_w_so=.TRUE.,
  hincbound=3.0,
  lchkini=.TRUE.,    lchkbd =.TRUE., lbdana=.FALSE.,
  lana_qi=.TRUE.,    llb_qi=.TRUE.,  lana_rho_snow=.TRUE., 
  lana_qr_qs=.TRUE., llb_qr_qs=.TRUE.,
  ydirini='$INIDIR',
  ydirbd='$BD_DIR',
 /
 &GRIBOUT
    hcomb=0.0,120.0,1.0
    lanalysis=.false.,
    lcheck=.true.,
    yform_write='$FORM',
    lwrite_const=.true.,
    l_fi_filter=.true.,
    yvarml='U         ','V         ','W         ','T         ',
           'QV        ','QC        ','QI        ','P         ',
           'TKE       ','CLC       ','QR        ','QS        ',
           'PS        ','T_SNOW    ','T_S       ','W_SNOW    ',
           'QV_S      ','W_I       ','RAIN_GSP  ','SNOW_GSP  ',
           'RAIN_CON  ','SNOW_CON  ','U_10M     ','V_10M     ',
           'T_2M      ','TD_2M     ','TMIN_2M   ','TMAX_2M   ',
           'VMAX_10M  ','TCM       ','TCH       ','CLCT      ',
           'CLCH      ','CLCM      ','CLCL      ','ALB_RAD   ',
           'ASOB_S    ','ATHB_S    ','ASOB_T    ','ATHB_T    ',
           'APAB_S    ','ASWDIR_S  ','ASWDIFD_S ','ASWDIFU_S ',
           'TOT_PREC  ','Z0        ','AUMFL_S   ','AVMFL_S   ',
           'ASHFL_S   ','ALHFL_S   ','BAS_CON   ','TOP_CON   ',
           'HTOP_DC   ','RUNOFF_S  ','RUNOFF_G  ','PMSL      ',
           'T_G       ','HTOP_CON  ','HBAS_CON  ','HZEROCL   ',
           'CLCT_MOD  ','CLDEPTH   ','TDIV_HUM  ','TWATER    ',
           'AEVAP_S   ','CAPE_CON  ','TQI       ','TQC       ',
           'TQV       ','TQR       ','TQS       ','T_SO      ',
           'W_SO      ','W_SO_ICE  ','FRESHSNW  ','QCVG_CON  ',
                        'SNOWLMT   ','RHO_SNOW  ','H_SNOW    ',
           'RELHUM_2M ','ZHD       ','ZTD       ','ZWD       ',
           'CAPE_ML   ','CIN_ML    ','DPSDT     ',
           'T_MNW_LK  ','T_WML_LK  ','T_BOT_LK  ','C_T_LK    ',
           'H_ML_LK   ','T_ICE     ','H_ICE     ',
    yvarpl='T         ','RELHUM    ','U         ','V         ',
           'FI        ','OMEGA     ','QV        ','TD        ',
    plev=  50., 100., 150., 200., 250., 300.,
        350., 400., 450., 500., 550., 600.,
        650., 700., 750., 800., 850., 900.,
        925., 1000.,1005.,1010.,
    yvarzl='T         ','RELHUM    ','U         ','V         ',
           'P         ','W         ',
    yvarsl='SYNMSG',
    zlev=500.0,1000.0,1500.0,2000.0,3000.0,5000.0,
  ydir='$OUTPUT',
 /
end_input_io

cat > INPUT_DYN << end_input_dyn
 &DYNCTL
    l2tls=.true.,
    lcond=.true.,
    irunge_kutta=1,
    irk_order=3,
    iadv_order=3,
    y_scalar_advect='BOTT2_STRANG',
    itype_fast_waves=2,
    itype_bbc_w=114,
    ldyn_bbc=.false.,
    l_diff_Smag=.true.,
    lhordiff=.true.,
      itype_hdiff=2,
      hd_corr_p_bd=0.0,
      hd_corr_p_in=0.0,
      hd_corr_trcr_bd=0.0,
      hd_corr_trcr_in=0.0,
      hd_corr_t_bd=0.0,
      hd_corr_t_in=0.0,
      hd_corr_u_bd=0.25,
      hd_corr_u_in=0.25,
      hd_dhmax=250.,
    itype_outflow_qrsg=1,
    ldiabf_lh=.true.,
      rlwidth=85000.0,
    lspubc=.true.,
      rdheight=18000.0,
      nrdtau=5,
    xkd=0.1,
 /
end_input_dyn

cat > INPUT_PHY << end_input_phy
 &PHYCTL
    lgsp=.TRUE.,
      itype_gscp=3,
    lrad=.TRUE.,
      nradcoarse=1,
      lradf_avg=.FALSE.
      hincrad=1.0,
      lforest=.TRUE.,
      itype_aerosol=2,
      itype_albedo=3,
    ltur=.TRUE.,
      ninctura=1,
      lexpcor=.FALSE.,
      ltmpcor=.FALSE.,
      lprfcor=.FALSE.,
      lnonloc=.FALSE.,
      lcpfluc=.FALSE.,
      limpltkediff=.TRUE.,
      itype_turb=3,
      imode_turb=1,
      itype_tran=2,
      imode_tran=1,
      itype_wcld=2,
      icldm_rad =4,
      icldm_turb=2,
      icldm_tran=0,
      itype_synd=2,
    lsoil=.TRUE.,
      itype_evsl=2,
      itype_trvg=2,
      lmelt=.TRUE.,
      lmelt_var=.TRUE.,
      ke_soil = 7,
      czml_soil = 0.005, 0.02, 0.06, 0.18, 0.54, 1.62, 4.86, 14.58,
    llake=.FALSE.,
    lseaice=.FALSE.,
    lconv=.TRUE.,
      nincconv=4,
      itype_conv=0,
      lcape=.FALSE.,
    lsso=.FALSE.,
      ltkesso=.TRUE.,
 /
end_input_phy

cat > INPUT_DIA << end_input_dia
 &DIACTL
  ltestsuite=.FALSE.
  itype_diag_gusts=1,
  n0meanval=0, nincmeanval=1,
  lgplong=.TRUE., lgpshort=.FALSE., lgpspec=.FALSE.,
  n0gp=0,      hincgp=1.0,
  stationlist_tot= 0, 0, 50.050,  8.600, 'Frankfurt-Flughafen',
                   0, 0, 52.220, 14.135, 'Lindenberg_Obs',
                   0, 0, 52.167, 14.124, 'Falkenberg',
 /
end_input_dia

#################################################
# run the program
#################################################

# machine specific for my Linux WS
setenv ECCODES_DEFINITION_PATH /home/winash12/meteorology_project/cosmo_weather_model/int2lm_180226_2.05/ec-2.8.0/definitions.edzw:/home/winash12/meteorology_project/cosmo_weather_model/int2lm_180226_2.05/ec-2.8.0/definitions


setenv ECCODES_SAMPLES_PATH /home/winash12/meteorology_project/cosmo_weather_model/int2lm_180226_2.05/ec-2.8.0/ec-2.8.0/samples-19.1/


#mpirun --tag-output -np 4 valgrind /home/aswin/meteorology_project/cosmoWeatherModel/cosmo_160310_5.04/lmparbin_all

#/opt/allinea/forge/bin/ddt mpirun --mca btl tcp,self -np 4  /home/aswin/meteorology_project/cosmoWeatherModel/cosmo_160310_5.04/lmparbin_all


mpirun  -np 4  /home/winash12/meteorology_project/cosmo_weather_model/cosmo_180223_5.05/lmparbin_all

chmod +x ./cosmo_eu_job
