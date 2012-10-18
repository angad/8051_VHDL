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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *IEEE_P_0774719531;
char *WORK_P_3647430093;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    work_p_3647430093_init();
    work_a_1231860622_2346685868_init();
    ieee_p_0774719531_init();
    work_a_2455163171_2488642777_init();
    work_a_0393052997_2342772313_init();
    work_a_0846406752_3212880686_init();
    work_a_1111616105_0338507630_init();
    work_a_1656347969_1516540902_init();
    work_a_3399119904_3212880686_init();
    work_a_0946206428_0000452272_init();
    work_a_3926497698_1516540902_init();
    work_a_2826395272_3212880686_init();
    work_a_0469606924_3212880686_init();
    work_a_0001905836_2372691052_init();


    xsi_register_tops("work_a_0001905836_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    IEEE_P_0774719531 = xsi_get_engine_memory("ieee_p_0774719531");
    WORK_P_3647430093 = xsi_get_engine_memory("work_p_3647430093");

    return xsi_run_simulation(argc, argv);

}
