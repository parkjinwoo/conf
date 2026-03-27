#!/bin/sh
# status-format[1] 설정: Ctrl+b 누르면 단축키 힌트 표시
# #{?client_prefix,A,B} 내부에서 콤마 사용 불가 → #[attr] 태그를 개별 분리
# %%%% = strftime 이중 처리로 % 표시

B='#[bg=#313244]#[fg=#cdd6f4]'
K='#[bg=#45475a]#[fg=#f9e2af]'
S='#[fg=#6c7086]'
G='#[fg=#6c7086]│'

P="#[bg=#89b4fa]#[fg=#1e1e2e]#[bold] PREFIX #[default]${B}"
P="${P} ${G} ${K} \" ${B} hsplit ${S}· ${K} %%%% ${B} vsplit ${S}· ${K} ←↑↓→ ${B} move ${S}· ${K} x ${B} close ${S}· ${K} z ${B} zoom"
P="${P} ${G} ${K} c ${B} new ${S}· ${K} n/p ${B} nav ${S}· ${K} 0-9 ${B} sel"
P="${P} ${G} ${K} d ${B} detach ${S}· ${K} s ${B} list"
P="${P} ${G} ${K} [ ${B} copy ${S}· ${K} : ${B} cmd ${S}· ${K} ? ${B} keys"

N="${B}${S} Ctrl+b #[fg=#585b70]for tmux commands"

tmux set -g 'status-format[1]' "#{?client_prefix,${P},${N}}"
