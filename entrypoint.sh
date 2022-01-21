#!/bin/sh

set -e
USER_HOME=${USER_HOME:-/home/user}
USER_NAME=${USER_NAME:-user}
USER_ID=${USER_ID:-9001}
GROUP_NAME=${GROUP_NAME:-group}
GROUP_ID=${GROUP_ID:-9001}
mkdir -p $USER_HOME
groupadd -g $GROUP_ID -o $GROUP_NAME
useradd --shell /bin/bash -u $USER_ID -o -c "" -g $GROUP_NAME -M -d $USER_HOME $USER_NAME
chown $USER_NAME:$GROUP_NAME $USER_HOME
exec /usr/local/bin/gosu $USER_NAME "$@"
