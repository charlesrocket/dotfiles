export ENV=$HOME/.kshrc
export LANG=en_US.UTF-8

xsetroot -cursor_name left_ptr
xsetroot -solid grey &

xterm -bg black -fg white +sb &

exec bspwm
