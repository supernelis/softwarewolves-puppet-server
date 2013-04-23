FOLDER=<%= install_dir %>
EXAMPLE=<%= example_js %>

CMD="node $FOLDER/softwarewolves/app/examples/$EXAMPLE" 

until $CMD; do
    echo "Server 'myserver' crashed with exit code $?.  Respawning.." >&2
    sleep 1
done