*Basic Characteristics of 10T CNTFET SRAM Cell

.TITLE '10T SRAM CNTFET'


***************************************************
*For optimal accuracy, convergence, and runtime
***************************************************
.options POST
.options AUTOSTOP
.options INGOLD=2     DCON=1
.options GSHUNT=1e-12 RMIN=1e-15 
.options ABSTOL=1e-5  ABSVDC=1e-4 
.options RELTOL=1e-2  RELVDC=1e-2 
.options NUMDGT=4     PIVOT=13

.param   TEMP=27
***************************************************


***************************************************
*Include relevant model files
***************************************************
.lib 'CNFET.lib' CNFET
***************************************************


***************************************************
*Beginning of circuit and device definitions
***************************************************
*Supplies and voltage params:
.param Supply=0.9  
.param VDDL=0.45	
.param Vin='Supply'
.param Vs='Supply'
.param Vlow='VDDL'

*Some CNFET parameters:
.param Ccsd=0      CoupleRatio=0
.param m_cnt=1     Efo=0.6     
.param Wg=0        Cb=40e-12
.param Lg=32e-9    Lgef=100e-9
.param Vfn=0       Vfp=0
.param m=19        n=0        
.param Hox=4e-9    Kox=16 

***********************************************************************
* Define power supply
***********************************************************************
Vdd     psource    Gnd     Vs
Vss     nsource    Gnd     0
*Vcom 	in	       Gnd	   Vin
Vsubn   nSub       Gnd      0
Vsubp   psource    pSub     0

***********************************************************************
* Main Circuits
***********************************************************************

XCNT4 VC VR psource pSub PCNFET n1=8 n2=n 

XCNT5 VC VR nsource nSub NCNFET n1=8  n2=n

XCNT6 VC psource Vlow nSub NCNFET n1=11  n2=n


XCNT7 VC WWL VL pSub PCNFET n1=19  n2=n 


XCNT1 VR VL psource pSub PCNFET n1=8  n2=n  

XCNT2 VR VL nsource nSub NCNFET n1=8  n2=n  

XCNT3 VR psource Vlow nSub NCNFET n1=11  n2=n


XCNT8 WBL WWL VL nSub NCNFET n1=19  n2=n 

XCNT9 RBL RWL VR nSub NCNFET n1=m  n2=n

XCNT10 RBL RWLB VR pSub PCNFET  n1=m  n2=n

C1 RBL Gnd 1f *Precharging trit Lines
.IC V(RBL)=0
.IC(VL)=0

*VPC RWL Gnd PULSE(0 0 5n 0n 0n 5n 10n)
*VPCb RWLB Gnd PULSE(0.9 0.9 5n 0n 0n 5n 10n)


VPC RWL Gnd PWL(0 0 
+19.95n 0
+20n 0.9
+29.95n 0.9
+30n 0 
+59.95n 0
+60n 0.9
+69.95n 0.9
+70n 0
+79.95n 0
+80n 0.9
+89.95n 0.9
+90n 0  
+129.95n 0
+130n 0.9
+149.95n 0.9
+150n 0 
+259.95n 0
+260n 0.9
+279.95n 0.9
+280n 0 ) 

VPCb RWLB Gnd PWL(0 0.9
+19.95n 0.9
+20n 0
+29.95n 0
+30n 0.9
+59.95n 0.9
+60n 0
+69.95n 0
+70n 0.9
+79.95n 0.9
+80n 0
+89.95n 0
+90n 0.9
+129.95n 0.9
+130n 0
+149.95n 0
+150n 0.9
+249.95n 0.9
+250n 0
+279.95n 0
+280n 0.9 )  

VP WBL Gnd PWL(0 0.9 
+99.5n 0.9 
+100n 0.45 
+199.5n 0.45 
+200n 0
+299.5n 0
+300n 0) 

*Vbit WWL Gnd PULSE(0.9 0.9 5n 0n 0n 5n 10n)

Vbit WWL Gnd PWL(0 0 
+19.95n 0
+20n 0.9
+29.95n 0.9
+30n 0 
+59.95n 0
+60n 0.9
+69.95n 0.9
+70n 0
+79.95n 0
+80n 0.9
+89.95n 0.9
+90n 0  
+129.95n 0
+130n 0.9
+149.95n 0.9
+150n 0 
+259.95n 0
+260n 0.9
+279.95n 0.9
+280n 0 ) 

.tran 25n 300n

.print I(Vdd)
.print power=par('V(Vdd)*I(Vdd)')
.end 
