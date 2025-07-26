#!/usr/bin/env bash
#
#   This file echoes a bunch of color codes to the
#   terminal to demonstrate what's available.  Each
#   line is the color code of one forground color,
#   out of 17 (default + 16 escapes), followed by a
#   test use of that color on all nine background
#   colors (default + 8 escapes).
#

set -euo pipefail

TEXT='gYw'

echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m"

for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
    '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
    '  36m' '1;36m' '  37m' '1;37m'; do
    FG=${FGs// /}
    echo -en " ${FGs} \033[${FG}  ${TEXT}  "

    for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
        echo -en " \033[${FG}\033[${BG}  ${TEXT}  \033[0m"
    done

    echo
done
echo

echo -e "\n${BRIGHT_WHITE}Foreground Colors Variables:${NC}"
echo -e "  ${BLACK}${BG_WHITE}BLACK${NC}"
echo -e "  ${RED}${BG_BLACK}RED${NC}"
echo -e "  ${GREEN}${BG_BLACK}GREEN${NC}"
echo -e "  ${YELLOW}${BG_BLACK}YELLOW${NC}"
echo -e "  ${BLUE}${BG_BLACK}BLUE${NC}"
echo -e "  ${PURPLE}${BG_BLACK}PURPLE${NC}"
echo -e "  ${CYAN}${BG_BLACK}CYAN${NC}"
echo -e "  ${WHITE}${BG_BLACK}WHITE${NC}"

echo -e "\n${BRIGHT_WHITE}Bright Colors Variables:${NC}"
echo -e "  ${BRIGHT_BLACK}${BG_WHITE}BRIGHT_BLACK${NC}"
echo -e "  ${BRIGHT_RED}${BG_BLACK}BRIGHT_RED${NC}"
echo -e "  ${BRIGHT_GREEN}${BG_BLACK}BRIGHT_GREEN${NC}"
echo -e "  ${BRIGHT_YELLOW}${BG_BLACK}BRIGHT_YELLOW${NC}"
echo -e "  ${BRIGHT_BLUE}${BG_BLACK}BRIGHT_BLUE${NC}"
echo -e "  ${BRIGHT_PURPLE}${BG_BLACK}BRIGHT_PURPLE${NC}"
echo -e "  ${BRIGHT_CYAN}${BG_BLACK}BRIGHT_CYAN${NC}"
echo -e "  ${BRIGHT_WHITE}${BG_BLACK}BRIGHT_WHITE${NC}"

echo -e "\n${BRIGHT_WHITE}Background Colors Variables:${NC}"
echo -e "  ${WHITE}${BG_BLACK}BG_BLACK${NC}"
echo -e "  ${BLACK}${BG_RED}BG_RED${NC}"
echo -e "  ${BLACK}${BG_GREEN}BG_GREEN${NC}"
echo -e "  ${BLACK}${BG_YELLOW}BG_YELLOW${NC}"
echo -e "  ${BLACK}${BG_BLUE}BG_BLUE${NC}"
echo -e "  ${BLACK}${BG_PURPLE}BG_PURPLE${NC}"
echo -e "  ${BLACK}${BG_CYAN}BG_CYAN${NC}"
echo -e "  ${BLACK}${BG_WHITE}BG_WHITE${NC}"

echo -e "\n${BRIGHT_WHITE}Special Variables:${NC}"
echo -e "  ${NC}${BG_BLACK}NC${NC} (No Color/Reset)"

echo -e "\n${BRIGHT_WHITE}Usage Example:${NC}"
echo -e "  echo -e \"\${BRIGHT_GREEN}\${BG_RED}Success!\${NC}\""
echo
