#!/bin/sh

cp /etc/resolv.conf /miredo/etc/
cp /etc/hosts /miredo/etc/
cp /etc/resolv.conf /miredo/etc/resolv.conf

mkdir -p /miredo/dev/
mount -o bind /dev /miredo/dev

mkdir /miredo/sys
mount -o bind /sys /miredo/sys
mkdir /miredo/proc
mount -o bind /proc /miredo/proc
mkdir -p /miredo/var/run

sed -i '1s/sh/bash/' /miredo/etc/miredo/client-hook

echo "Running miredo"
chroot /miredo /bin/bash -c "miredo -c /etc/miredo.conf -u nobody"

set -e

# no arguments passed
# or first arg is `-f` or `--some-option`
if [ "$#" -eq 0 -o "${1#-}" != "$1" ]; then
	# add our default arguments
	set -- dockerd \
		--host=unix:///var/run/docker.sock \
		--host=tcp://0.0.0.0:2375 \
		--storage-driver=vfs \
		"$@"
fi

if [ "$1" = 'dockerd' ]; then
	# if we're running Docker, let's pipe through dind
	# (and we'll run dind explicitly with "sh" since its shebang is /bin/bash)
	set -- sh "$(which dind)" "$@"
fi

exec "$@"