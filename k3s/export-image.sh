#!/bin/bash

set -euTCo pipefail
set -x

k3s crictl image ls | grep docker | perl -alne 'print "$F[0]:$F[1]"' > list.txt

while read name; do 
    k3s ctr image export ${name##*/}.tar  $name --platform=linux/amd64;
done < list.txt

### import
# ls -1 *.tar | while read name; do k3s ctr image import $name; done

