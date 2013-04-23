SERVERNAME=$1
USER=$2
HOME=$3

rsync -vr -e ssh "." $USER@$SERVERNAME:$HOME --exclude '*.bbprojectd' --exclude '.DS_Store' --exclude '.git'
