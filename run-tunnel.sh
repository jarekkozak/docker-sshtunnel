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

#Expose just mapped ports
ports=$(echo $REMOTE_PORTS | tr ";" "\n")
EXPOSE=""
for port in $ports
do
EXPOSE="$EXPOSE --expose=$port"
done



echo "Locally mapped ports $PARAM"

docker run -d $EXPOSE $PARAM \
	-e PASS=$PASS \
	-e HOST=$HOST \
	-e REMOTE_PORTS=$REMOTE_PORTS \
	--name $CONTAINER $IMAGE


	

