FROM python:3.9-slim

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    git \
    python3-tk \
    portaudio19-dev \
    ffmpeg \
    curl \
    && rm -rf /var/lib/apt/lists/*  

RUN pip install --upgrade pip
COPY requirements.txt /root/
WORKDIR /root/
RUN pip install -r requirements.txt
RUN pip install 'torch>=2.0'

ENTRYPOINT ["python", "src/app.py"]