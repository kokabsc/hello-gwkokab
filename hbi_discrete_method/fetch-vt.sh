#!/usr/bin/env bash

REPO="kokabsc/VTs"
PATH_IN_REPO="neural_vts/neural_vt_1_200_1000_ecc_matters.hdf5"

read OID SIZE < <(
	curl -Ls "https://raw.githubusercontent.com/${REPO}/refs/heads/main/${PATH_IN_REPO}" |
		awk '/oid sha256:/ {oid=$2} /^size / {size=$2} END {print substr(oid,8), size}'
)

JSON=$(curl -s \
	-H "Accept: application/vnd.git-lfs+json" \
	-H "Content-Type: application/vnd.git-lfs+json" \
	-X POST \
	-d "{\"operation\":\"download\",\"objects\":[{\"oid\":\"$OID\",\"size\":$SIZE}]}" \
	"https://github.com/${REPO}.git/info/lfs/objects/batch")

URL=$(echo "$JSON" | grep -o '"href": "[^"]*' | cut -d'"' -f4)

curl -L "$URL" -o "$(basename "$PATH_IN_REPO")"
