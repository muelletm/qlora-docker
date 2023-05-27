#! /bin/bash


if [ ! -d qlora ]; then
    git clone https://github.com/artidoro/qlora
fi


docker build . -t qlora
mkdir -p output
docker run --rm --name qlora --gpus all \
  --mount type=bind,source="$PWD/output",target=/output \
  --mount type=bind,source="$PWD/mpt-7b",target=/mpt-7b \
  qlora train_mpt.sh
