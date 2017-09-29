#!/bin/bash
cd "$( dirname "$( readlink -f "$0" )" )"
GEM="./gnomeshell-extension-manage"
USER_PATH="$HOME/.local/share/gnome-shell/extensions"
SYSTEM_PATH="/usr/share/gnome-shell/extensions"

echo "REMOVE PREINSTALLED EXTENSIONS..."

rem_system="sudo $GEM --remove --system --extension-id"
$rem_system 6 # /applications-menu/
$rem_system 16 # /auto-move-windows/
$rem_system 600 # /launch-new-instance/
$rem_system 18 # /native-window-placement/
$rem_system 8 # /places-status-indicator/
$rem_system 19 # /user-themes/
$rem_system 602 # /window-list/
$rem_system 10 # /windownavigator/
$rem_system 7 # /removable-drive-menu/
$rem_system 881 # /screenshot-window-sizer/
# -------- below: remove root installation and reinstall in user land 
$rem_system 21 # /workspace-indicator/
$rem_system 15 # /alternatetab/

echo "RE-INSTALL USER EXTENSIONS..."

inst_user="$GEM --install --user --extension-id"
$inst_user 21 # /workspace-indicator/
$inst_user 15 # /alternatetab/
$inst_user 307 # /dash-to-dock/
$inst_user 959 # /disable-workspace-switcher-popup/
$inst_user 118 # /no-topleft-hot-corner/
$inst_user 39 # /put-windows/
$inst_user 1031 # /topicons/

echo "--- USER PATH:"
ls -l $USER_PATH
echo "--- SYS PATH:"
ls -l $SYSTEM_PATH
