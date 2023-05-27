FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

RUN apt-get update && apt-get install git -y

RUN pip install -q -U bitsandbytes
RUN pip install -q -U git+https://github.com/huggingface/transformers.git
RUN pip install -q -U git+https://github.com/huggingface/peft.git
RUN pip install -q -U git+https://github.com/huggingface/accelerate.git

WORKDIR /code

COPY qlora/requirements.txt qlora/requirements.txt

WORKDIR /code/qlora

RUN pip install -q -r requirements.txt 

# For MPT.
RUN pip install einops

COPY qlora .

COPY scripts/train.sh .

COPY scripts/train_mpt.sh . 

ENTRYPOINT [ "sh" ]

CMD [ "train.sh" ]
