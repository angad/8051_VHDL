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
static const char *ng0 = "C:/Users/Angad Singh/Downloads/1 Trying S1S6/Lab1/multiplier.vhd";
extern char *IEEE_P_3499444699;

char *ieee_p_3499444699_sub_1704181104_3536714472(char *, char *, char *, char *, char *, char *);


static void work_a_1656347969_1516540902_p_0(char *t0)
{
    char t1[16];
    char t2[16];
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    int t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned int t13;

LAB0:    xsi_set_current_line(22, ng0);
    t3 = (t0 + 684U);
    t4 = *((char **)t3);
    t3 = (t0 + 3764U);
    t5 = (t0 + 776U);
    t6 = *((char **)t5);
    t5 = (t0 + 3780U);
    t7 = ieee_p_3499444699_sub_1704181104_3536714472(IEEE_P_3499444699, t2, t4, t3, t6, t5);
    t8 = (16 * 2);
    t9 = ieee_std_logic_arith_conv_unsigned_zeroext(IEEE_P_3499444699, t1, t7, t2, t8);
    t10 = (t0 + 1200U);
    t11 = *((char **)t10);
    t10 = (t11 + 0);
    t12 = (t1 + 12U);
    t13 = *((unsigned int *)t12);
    t13 = (t13 * 1U);
    memcpy(t10, t9, t13);
    xsi_set_current_line(23, ng0);
    t3 = (t0 + 1200U);
    t4 = *((char **)t3);
    t3 = (t0 + 2148);
    t5 = (t3 + 32U);
    t6 = *((char **)t5);
    t7 = (t6 + 40U);
    t9 = *((char **)t7);
    memcpy(t9, t4, 32U);
    xsi_driver_first_trans_fast(t3);
    t3 = (t0 + 2096);
    *((int *)t3) = 1;

LAB1:    return;
}

static void work_a_1656347969_1516540902_p_1(char *t0)
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

LAB0:    xsi_set_current_line(28, ng0);
    t2 = (t0 + 568U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 2104);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(29, ng0);
    t4 = (t0 + 960U);
    t8 = *((char **)t4);
    t4 = (t0 + 2184);
    t9 = (t4 + 32U);
    t10 = *((char **)t9);
    t11 = (t10 + 40U);
    t12 = *((char **)t11);
    memcpy(t12, t8, 32U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB3;

LAB5:    t4 = (t0 + 592U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

}


extern void work_a_1656347969_1516540902_init()
{
	static char *pe[] = {(void *)work_a_1656347969_1516540902_p_0,(void *)work_a_1656347969_1516540902_p_1};
	xsi_register_didat("work_a_1656347969_1516540902", "isim/ADD_isim_beh.exe.sim/work/a_1656347969_1516540902.didat");
	xsi_register_executes(pe);
}
