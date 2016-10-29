# Set the base image to use to armhf
FROM resin/rpi-raspbian:jessie

RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget git unzip vlc-nox python-gevent python-pip python-dev gcc && pip install psutil && DEBIAN_FRONTEND=noninteractive apt-get remove -y gcc python-pip python-dev && DEBIAN_FRONTEND=noninteractive apt-get autoremove && DEBIAN_FRONTEND=noninteractive apt-get clean
RUN cd / && wget https://dl.bintray.com/pipplware/dists/unstable/armv7/misc/acestream_rpi_3.1.5.tar.gz -O acestream_rpi.tar.gz && tar xfv acestream_rpi.tar.gz && rm acestream_rpi.tar.gz && ln -s /acestream/androidfs/system /system && ln -s /acestream/androidfs/sdcard /sdcard
RUN cd / && git clone https://github.com/AndreyPavlenko/aceproxy.git
RUN adduser --disabled-password --gecos "" aceproxy
EXPOSE 8000 8081 62062
VOLUME /aceproxy/ 
ADD aceconfig.py /aceproxy/aceconfig.py
ADD start_acestream.sh /start_acestream.sh
RUN chmod +x /start_acestream.sh

CMD ["/aceproxy/acehttp.py"]
