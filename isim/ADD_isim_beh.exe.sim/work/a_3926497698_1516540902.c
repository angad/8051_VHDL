/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x1048c146 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Angad Singh/Downloads/1 Trying S1S6/Lab1/divider.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3499444699;

char *ieee_p_3499444699_sub_2254183471_3536714472(char *, char *, char *, char *, char *, char *);
char *ieee_p_3499444699_sub_2930370427_3536714472(char *, char *, char *, char *, int );


static void work_a_3926497698_1516540902_p_0(char *t0)
{
    char t15[16];
    char t16[16];
    char *t1;
    char *t2;
    char *t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    int t11;
    unsigned char t12;
    int t13;
    char *t14;
    char *t17;
    char *t18;
    char *t19;
    char *t20;

LAB0:    xsi_set_current_line(39, ng0);
    t1 = (t0 + 1788U);
    t2 = *((char **)t1);
    t1 = (t0 + 2236U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    memcpy(t1, t2, 16U);
    xsi_set_current_line(40, ng0);
    t1 = (t0 + 1880U);
    t2 = *((char **)t1);
    t1 = (t0 + 2304U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    memcpy(t1, t2, 16U);
    xsi_set_current_line(43, ng0);
    t1 = (t0 + 1880U);
    t2 = *((char **)t1);
    t4 = (15 - 14);
    t5 = (t4 * 1U);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t3 = (t0 + 2304U);
    t7 = *((char **)t3);
    t8 = (15 - 15);
    t9 = (t8 * 1U);
    t10 = (0 + t9);
    t3 = (t7 + t10);
    memcpy(t3, t1, 15U);
    xsi_set_current_line(44, ng0);
    t1 = (t0 + 1420U);
    t2 = *((char **)t1);
    t11 = (15 - 15);
    t4 = (t11 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t12 = *((unsigned char *)t1);
    t3 = (t0 + 2304U);
    t7 = *((char **)t3);
    t13 = (0 - 15);
    t8 = (t13 * -1);
    t9 = (1U * t8);
    t10 = (0 + t9);
    t3 = (t7 + t10);
    *((unsigned char *)t3) = t12;
    xsi_set_current_line(48, ng0);
    t1 = (t0 + 2304U);
    t2 = *((char **)t1);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t1 = ((IEEE_P_2592010699) + 2332);
    t12 = xsi_vhdl_greaterEqual(t1, t2, 16U, t3, 16U);
    if (t12 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 2236U);
    t2 = *((char **)t1);
    t11 = (0 - 15);
    t4 = (t11 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    *((unsigned char *)t1) = (unsigned char)2;

LAB3:    xsi_set_current_line(55, ng0);
    t1 = (t0 + 2236U);
    t2 = *((char **)t1);
    t1 = (t0 + 3252);
    t3 = (t1 + 32U);
    t7 = *((char **)t3);
    t14 = (t7 + 40U);
    t17 = *((char **)t14);
    memcpy(t17, t2, 16U);
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(56, ng0);
    t1 = (t0 + 2304U);
    t2 = *((char **)t1);
    t1 = (t0 + 3288);
    t3 = (t1 + 32U);
    t7 = *((char **)t3);
    t14 = (t7 + 40U);
    t17 = *((char **)t14);
    memcpy(t17, t2, 16U);
    xsi_driver_first_trans_fast(t1);
    t1 = (t0 + 3200);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(49, ng0);
    t7 = (t0 + 2236U);
    t14 = *((char **)t7);
    t11 = (0 - 15);
    t4 = (t11 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t7 = (t14 + t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_set_current_line(50, ng0);
    t1 = (t0 + 2304U);
    t2 = *((char **)t1);
    t1 = (t0 + 6492U);
    t3 = (t0 + 1512U);
    t7 = *((char **)t3);
    t3 = (t0 + 6364U);
    t14 = ieee_p_3499444699_sub_2254183471_3536714472(IEEE_P_3499444699, t16, t2, t1, t7, t3);
    t17 = ieee_p_3499444699_sub_2930370427_3536714472(IEEE_P_3499444699, t15, t14, t16, 16);
    t18 = (t0 + 2304U);
    t19 = *((char **)t18);
    t18 = (t19 + 0);
    t20 = (t15 + 12U);
    t4 = *((unsigned int *)t20);
    t4 = (t4 * 1U);
    memcpy(t18, t17, t4);
    goto LAB3;

}

static void work_a_3926497698_1516540902_p_1(char *t0)
{
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned char t16;
    unsigned char t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    int t24;
    int t25;
    int t26;

LAB0:    xsi_set_current_line(61, ng0);
    t2 = (t0 + 568U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 3208);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(62, ng0);
    t4 = (t0 + 1696U);
    t8 = *((char **)t4);
    t4 = (t0 + 3324);
    t9 = (t4 + 32U);
    t10 = *((char **)t9);
    t11 = (t10 + 40U);
    t12 = *((char **)t11);
    memcpy(t12, t8, 16U);
    xsi_driver_first_trans_fast(t4);
    xsi_set_current_line(63, ng0);
    t2 = (t0 + 1604U);
    t4 = *((char **)t2);
    t13 = (15 - 14);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t2 = (t4 + t15);
    t5 = (t0 + 3360);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    memcpy(t11, t2, 15U);
    xsi_driver_first_trans_delta(t5, 0U, 15U, 0LL);
    xsi_set_current_line(64, ng0);
    t2 = (t0 + 1420U);
    t4 = *((char **)t2);
    t13 = (15 - 14);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t2 = (t4 + t15);
    t5 = (t0 + 3396);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    memcpy(t11, t2, 15U);
    xsi_driver_first_trans_delta(t5, 0U, 15U, 0LL);
    xsi_set_current_line(66, ng0);
    t2 = (t0 + 684U);
    t4 = *((char **)t2);
    t6 = *((unsigned char *)t4);
    t7 = (t6 == (unsigned char)3);
    if (t7 == 1)
        goto LAB14;

LAB15:    t2 = (t0 + 776U);
    t5 = *((char **)t2);
    t2 = (t0 + 1972U);
    t8 = *((char **)t2);
    t16 = 1;
    if (16U == 16U)
        goto LAB17;

LAB18:    t16 = 0;

LAB19:    t3 = (!(t16));

LAB16:    if (t3 == 1)
        goto LAB11;

LAB12:    t10 = (t0 + 868U);
    t11 = *((char **)t10);
    t10 = (t0 + 2064U);
    t12 = *((char **)t10);
    t17 = 1;
    if (16U == 16U)
        goto LAB23;

LAB24:    t17 = 0;

LAB25:    t1 = (!(t17));

LAB13:    if (t1 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1236U);
    t4 = *((char **)t2);
    t24 = *((int *)t4);
    t1 = (t24 > 0);
    if (t1 != 0)
        goto LAB29;

LAB30:    t2 = (t0 + 1328U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)2);
    if (t3 != 0)
        goto LAB31;

LAB32:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 592U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(67, ng0);
    t19 = (t0 + 3432);
    t20 = (t19 + 32U);
    t21 = *((char **)t20);
    t22 = (t21 + 40U);
    t23 = *((char **)t22);
    *((int *)t23) = 15;
    xsi_driver_first_trans_fast(t19);
    xsi_set_current_line(68, ng0);
    t2 = (t0 + 3468);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t8 = (t5 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(69, ng0);
    t2 = (t0 + 3504);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t8 = (t5 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(70, ng0);
    t2 = xsi_get_transient_memory(16U);
    memset(t2, 0, 16U);
    t4 = t2;
    memset(t4, (unsigned char)2, 16U);
    t5 = (t0 + 3324);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    memcpy(t11, t2, 16U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(71, ng0);
    t2 = xsi_get_transient_memory(16U);
    memset(t2, 0, 16U);
    t4 = t2;
    memset(t4, (unsigned char)2, 16U);
    t5 = (t0 + 3360);
    t8 = (t5 + 32U);
    t9 = *((char **)t8);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    memcpy(t11, t2, 16U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(72, ng0);
    t2 = (t0 + 776U);
    t4 = *((char **)t2);
    t2 = (t0 + 3396);
    t5 = (t2 + 32U);
    t8 = *((char **)t5);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t4, 16U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 868U);
    t4 = *((char **)t2);
    t2 = (t0 + 3540);
    t5 = (t2 + 32U);
    t8 = *((char **)t5);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t4, 16U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(74, ng0);
    t2 = (t0 + 776U);
    t4 = *((char **)t2);
    t2 = (t0 + 3576);
    t5 = (t2 + 32U);
    t8 = *((char **)t5);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t4, 16U);
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(75, ng0);
    t2 = (t0 + 868U);
    t4 = *((char **)t2);
    t2 = (t0 + 3612);
    t5 = (t2 + 32U);
    t8 = *((char **)t5);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t4, 16U);
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

LAB11:    t1 = (unsigned char)1;
    goto LAB13;

LAB14:    t3 = (unsigned char)1;
    goto LAB16;

LAB17:    t13 = 0;

LAB20:    if (t13 < 16U)
        goto LAB21;
    else
        goto LAB19;

LAB21:    t2 = (t5 + t13);
    t9 = (t8 + t13);
    if (*((unsigned char *)t2) != *((unsigned char *)t9))
        goto LAB18;

LAB22:    t13 = (t13 + 1);
    goto LAB20;

LAB23:    t14 = 0;

LAB26:    if (t14 < 16U)
        goto LAB27;
    else
        goto LAB25;

LAB27:    t10 = (t11 + t14);
    t18 = (t12 + t14);
    if (*((unsigned char *)t10) != *((unsigned char *)t18))
        goto LAB24;

LAB28:    t14 = (t14 + 1);
    goto LAB26;

LAB29:    xsi_set_current_line(77, ng0);
    t2 = (t0 + 1236U);
    t5 = *((char **)t2);
    t25 = *((int *)t5);
    t26 = (t25 - 1);
    t2 = (t0 + 3432);
    t8 = (t2 + 32U);
    t9 = *((char **)t8);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    *((int *)t11) = t26;
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

LAB31:    xsi_set_current_line(79, ng0);
    t2 = (t0 + 1696U);
    t5 = *((char **)t2);
    t2 = (t0 + 3648);
    t8 = (t2 + 32U);
    t9 = *((char **)t8);
    t10 = (t9 + 40U);
    t11 = *((char **)t10);
    memcpy(t11, t5, 16U);
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(80, ng0);
    t2 = (t0 + 1604U);
    t4 = *((char **)t2);
    t2 = (t0 + 3684);
    t5 = (t2 + 32U);
    t8 = *((char **)t5);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t4, 16U);
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(81, ng0);
    t2 = (t0 + 3468);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t8 = (t5 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(82, ng0);
    t2 = (t0 + 3504);
    t4 = (t2 + 32U);
    t5 = *((char **)t4);
    t8 = (t5 + 40U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

}


extern void work_a_3926497698_1516540902_init()
{
	static char *pe[] = {(void *)work_a_3926497698_1516540902_p_0,(void *)work_a_3926497698_1516540902_p_1};
	xsi_register_didat("work_a_3926497698_1516540902", "isim/ADD_isim_beh.exe.sim/work/a_3926497698_1516540902.didat");
	xsi_register_executes(pe);
}
