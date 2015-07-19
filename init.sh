SURVIVALSCREENNAME="gm4"
UHCSCREENNAME="uhc"

UHCSERVERDIR="/minecraft/servers/uhc"
UHCWORLDDIR="$UHCSERVERDIR/world"

SEEDFILE="/minecraft/automation/uhc/seeds"
WORLDLIST="/minecraft/automation/uhc/worlds"

# Stop the Survival server.
echo "Stopping Survival server on screen $SURVIVALSCREENNAME."
#screen -x $SCREENNAME -X stuff "`printf "stop\r"`"

# Delete any existing UHC worlds if needed
if [ -d $UHCWORLDDIR ]
then
	echo "Deleting old UHC world."
	rm -v -rf $UHCWORLDDIR
fi

: <<'end_long_comment'
# Pick from a list of world seeds and edit the world seed.
echo "Choosing a random seed and applying it to the server."
SEED=$(shuf -n 1 $SEEDFILE)
echo "Picked seed $SEED."
sed -i "/level-seed/c\level-seed=$SEED" "$UHCSERVERDIR/server.properties"
end_long_comment

# Pick from a list of pre-genned worlds and copy it to the server.
echo "Choosing a random world and copying it to the server."
WORLDFILE=$(shuf -n 1 $WORLDLIST)
echo "Extracting world $WORLDFILE."
tar vxf $WORLDFILE -C $UHCSERVERDIR

# Start the UHC server.
echo "Starting the UHC server."
#/minecraft/startupscripts/uhc.sh
