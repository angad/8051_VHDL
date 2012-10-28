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
static const char *ng0 = "C:/Users/Angad Singh/Downloads/1 Trying S1S6/Lab1/int_rom.vhd";
extern char *IEEE_P_3620187407;

int ieee_p_3620187407_sub_514432868_3965413181(char *, char *, char *);


static void work_a_3399119904_3212880686_p_0(char *t0)
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
    int t11;
    int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(49, ng0);
    t1 = (t0 + 684U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 776U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB5;

LAB6:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 36435);
    t5 = (t0 + 1928);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast_port(t5);

LAB3:    t1 = (t0 + 1884);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 36427);
    t6 = (t0 + 1928);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 40U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 8U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 1132U);
    t5 = *((char **)t1);
    t1 = (t0 + 868U);
    t6 = *((char **)t1);
    t1 = (t0 + 3568U);
    t11 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t6, t1);
    t12 = (t11 - 0);
    t13 = (t12 * 1);
    xsi_vhdl_check_range_of_index(0, 4095, 1, t11);
    t14 = (8U * t13);
    t15 = (0 + t14);
    t7 = (t5 + t15);
    t8 = (t0 + 1928);
    t9 = (t8 + 32U);
    t10 = *((char **)t9);
    t16 = (t10 + 40U);
    t17 = *((char **)t16);
    memcpy(t17, t7, 8U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB3;

}


extern void work_a_3399119904_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3399119904_3212880686_p_0};
	xsi_register_didat("work_a_3399119904_3212880686", "isim/ADD_isim_beh.exe.sim/work/a_3399119904_3212880686.didat");
	xsi_register_executes(pe);
}
