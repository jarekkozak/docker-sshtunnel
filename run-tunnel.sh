#/bin/bash
if [ -f ./config ]; then
 . config
fi

ports=$(echo $LOCAL_PORTS | tr ";" "\n")
PARAM=""
for port in $ports
do
PARAM="$PARAM -p $port"
done

echo "Locally mapped ports $PARAM"

docker run -d $PARAM \
	-e PASS=$PASS \
	-e HOST=$HOST \
	-e REMOTE_PORTS=$REMOTE_PORTS \
	--name $CONTAINER $IMAGE


	

