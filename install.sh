#!/bin/bash

if [[ ! "${UID}" = "0" ]]; then
    echo "Please switch to root user !!!"
    exit 1
fi

echo "All Done."
exit 0