#! /bin/bash

if [ ! -d qlora ]; then
    git clone https://github.com/artidoro/qlora
fi

if [ ! -d "mpt-7b" ]; then
    # git lfs install
    git clone https://huggingface.co/cekal/mpt-7b
    pushd mpt-7b
    git fetch origin refs/pr/42:pr/42
    git checkout pr/42
    popd
fi


docker build . -t qlora
mkdir -p output
docker run --rm --name qlora --gpus all \
  --mount type=bind,source="$PWD/output",target=/output \
  --mount type=bind,source="$PWD/mpt-7b",target=/mpt-7b \
  qlora train_mpt.sh
