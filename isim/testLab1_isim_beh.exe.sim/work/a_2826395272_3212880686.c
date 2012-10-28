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
static const char *ng0 = "C:/Users/Angad Singh/Downloads/1 Trying S1S6/Lab1/int_handler.vhd";



static void work_a_2826395272_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned char t17;
    unsigned char t18;
    char *t19;
    char *t20;
    char *t21;
    int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned char t30;
    unsigned char t31;
    char *t32;
    char *t33;

LAB0:    xsi_set_current_line(28, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 568U);
    t4 = xsi_signal_has_event(t1);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 1908);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(29, ng0);
    t1 = (t0 + 3554);
    t6 = (t0 + 1952);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 3U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(33, ng0);
    t2 = (t0 + 776U);
    t6 = *((char **)t2);
    t13 = (7 - 7);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t2 = (t6 + t16);
    t17 = *((unsigned char *)t2);
    t18 = (t17 == (unsigned char)2);
    if (t18 != 0)
        goto LAB10;

LAB12:    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t13 = (0 - 7);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t2 + t16);
    t4 = *((unsigned char *)t1);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB15;

LAB16:    t3 = (unsigned char)0;

LAB17:    if (t3 != 0)
        goto LAB13;

LAB14:    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t13 = (1 - 7);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t2 + t16);
    t4 = *((unsigned char *)t1);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB20;

LAB21:    t3 = (unsigned char)0;

LAB22:    if (t3 != 0)
        goto LAB18;

LAB19:    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t13 = (2 - 7);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t2 + t16);
    t4 = *((unsigned char *)t1);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB25;

LAB26:    t3 = (unsigned char)0;

LAB27:    if (t3 != 0)
        goto LAB23;

LAB24:    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t13 = (3 - 7);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t2 + t16);
    t4 = *((unsigned char *)t1);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB30;

LAB31:    t3 = (unsigned char)0;

LAB32:    if (t3 != 0)
        goto LAB28;

LAB29:    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t13 = (4 - 7);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t2 + t16);
    t4 = *((unsigned char *)t1);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB35;

LAB36:    t3 = (unsigned char)0;

LAB37:    if (t3 != 0)
        goto LAB33;

LAB34:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 3575);
    t5 = (t0 + 1952);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 3U);
    xsi_driver_first_trans_fast_port(t5);

LAB11:    goto LAB3;

LAB7:    t2 = (t0 + 592U);
    t5 = *((char **)t2);
    t11 = *((unsigned char *)t5);
    t12 = (t11 == (unsigned char)3);
    t3 = t12;
    goto LAB9;

LAB10:    xsi_set_current_line(34, ng0);
    t7 = (t0 + 3557);
    t9 = (t0 + 1952);
    t10 = (t9 + 32U);
    t19 = *((char **)t10);
    t20 = (t19 + 40U);
    t21 = *((char **)t20);
    memcpy(t21, t7, 3U);
    xsi_driver_first_trans_fast_port(t9);
    goto LAB11;

LAB13:    xsi_set_current_line(37, ng0);
    t7 = (t0 + 3560);
    t9 = (t0 + 1952);
    t10 = (t9 + 32U);
    t19 = *((char **)t10);
    t20 = (t19 + 40U);
    t21 = *((char **)t20);
    memcpy(t21, t7, 3U);
    xsi_driver_first_trans_fast_port(t9);
    goto LAB11;

LAB15:    t5 = (t0 + 960U);
    t6 = *((char **)t5);
    t22 = (1 - 7);
    t23 = (t22 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t5 = (t6 + t25);
    t12 = *((unsigned char *)t5);
    t17 = (t12 == (unsigned char)3);
    t3 = t17;
    goto LAB17;

LAB18:    xsi_set_current_line(40, ng0);
    t7 = (t0 + 3563);
    t9 = (t0 + 1952);
    t10 = (t9 + 32U);
    t19 = *((char **)t10);
    t20 = (t19 + 40U);
    t21 = *((char **)t20);
    memcpy(t21, t7, 3U);
    xsi_driver_first_trans_fast_port(t9);
    goto LAB11;

LAB20:    t5 = (t0 + 960U);
    t6 = *((char **)t5);
    t22 = (5 - 7);
    t23 = (t22 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t5 = (t6 + t25);
    t12 = *((unsigned char *)t5);
    t17 = (t12 == (unsigned char)3);
    t3 = t17;
    goto LAB22;

LAB23:    xsi_set_current_line(43, ng0);
    t7 = (t0 + 3566);
    t9 = (t0 + 1952);
    t10 = (t9 + 32U);
    t19 = *((char **)t10);
    t20 = (t19 + 40U);
    t21 = *((char **)t20);
    memcpy(t21, t7, 3U);
    xsi_driver_first_trans_fast_port(t9);
    goto LAB11;

LAB25:    t5 = (t0 + 960U);
    t6 = *((char **)t5);
    t22 = (3 - 7);
    t23 = (t22 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t5 = (t6 + t25);
    t12 = *((unsigned char *)t5);
    t17 = (t12 == (unsigned char)3);
    t3 = t17;
    goto LAB27;

LAB28:    xsi_set_current_line(46, ng0);
    t7 = (t0 + 3569);
    t9 = (t0 + 1952);
    t10 = (t9 + 32U);
    t19 = *((char **)t10);
    t20 = (t19 + 40U);
    t21 = *((char **)t20);
    memcpy(t21, t7, 3U);
    xsi_driver_first_trans_fast_port(t9);
    goto LAB11;

LAB30:    t5 = (t0 + 960U);
    t6 = *((char **)t5);
    t22 = (7 - 7);
    t23 = (t22 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t5 = (t6 + t25);
    t12 = *((unsigned char *)t5);
    t17 = (t12 == (unsigned char)3);
    t3 = t17;
    goto LAB32;

LAB33:    xsi_set_current_line(49, ng0);
    t9 = (t0 + 3572);
    t19 = (t0 + 1952);
    t20 = (t19 + 32U);
    t21 = *((char **)t20);
    t32 = (t21 + 40U);
    t33 = *((char **)t32);
    memcpy(t33, t9, 3U);
    xsi_driver_first_trans_fast_port(t19);
    goto LAB11;

LAB35:    t5 = (t0 + 868U);
    t6 = *((char **)t5);
    t22 = (1 - 7);
    t23 = (t22 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t5 = (t6 + t25);
    t17 = *((unsigned char *)t5);
    t18 = (t17 == (unsigned char)3);
    if (t18 == 1)
        goto LAB38;

LAB39:    t7 = (t0 + 868U);
    t8 = *((char **)t7);
    t26 = (0 - 7);
    t27 = (t26 * -1);
    t28 = (1U * t27);
    t29 = (0 + t28);
    t7 = (t8 + t29);
    t30 = *((unsigned char *)t7);
    t31 = (t30 == (unsigned char)3);
    t12 = t31;

LAB40:    t3 = t12;
    goto LAB37;

LAB38:    t12 = (unsigned char)1;
    goto LAB40;

}


extern void work_a_2826395272_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2826395272_3212880686_p_0};
	xsi_register_didat("work_a_2826395272_3212880686", "isim/testLab1_isim_beh.exe.sim/work/a_2826395272_3212880686.didat");
	xsi_register_executes(pe);
}
