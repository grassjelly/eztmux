#!/usr/bin/env bash

set -e 

TMUX_CONFIG_DIR=$HOME/.config/tmuxinator/eztmux

sudo apt update
sudo apt install -y tmuxinator xsel
mkdir -p $TMUX_CONFIG_DIR
rm -rf $TMUX_CONFIG_DIR/tmux-yank
git clone https://github.com/tmux-plugins/tmux-yank $TMUX_CONFIG_DIR/tmux-yank
cat << EOF > $TMUX_CONFIG_DIR/.tmux.conf
set -g mouse on
set -g default-terminal "screen-256color"
# pane border
set -g pane-border-style fg='#6272a4'
set -g pane-active-border-style fg='#ff79c6'
# message text
set -g message-style bg='#44475a',fg='#8be9fd'
set -g status-style bg='#44475a',fg='#bd93f9'
# status right
set-option -g status on
set -g status-interval 1
set -g status-fg white
set-option -g status-left-length 250

set-option -g status-right-length 250
set -g status-right '#(uptime)'
set -g status-left "#(vmstat -SM 1 2 | awk 'END {print \"CPU:\"100-\$15\"%\"}')#(free -h | awk '/Mem:/ {print \" MEM:\"\$3}')#(echo \" \")"
set -g @plugin 'tmux-plugins/tmux-yank'
#set -g @yank_action 'copy-pipe'
set -g @yank_selection_mouse 'clipboard'
run-shell $TMUX_CONFIG_DIR/tmux-yank/yank.tmux
EOF

rm -rf $TMUX_CONFIG_DIR/eztmux
git clone https://github.com/grassjelly/eztmux $TMUX_CONFIG_DIR/eztmux

TO_WRITE="alias eztmux=\"\$HOME/.config/tmuxinator/eztmux/eztmux/./eztmux $@\""
if ! grep -qF '$TO_WRITE' "$HOME/.bashrc" ; then
    echo $TO_WRITE >> $HOME/.bashrc
fi

echo "eztmux installed!"
