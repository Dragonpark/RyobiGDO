FROM Dragonpark/RyobiGDO:0.1.0
MAINTAINER dragonpark <dragonpark@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
RUN add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"
RUN apt-get update -q

# Install Dependencies
RUN apt-get install -qy npm wget
RUN npm install ws request

# Install RyobiGDOProxy v0.2.5
RUN mkdir /opt/RyobiGDOProxy
RUN wget -P /opt/RyobiGDOProxy https://raw.githubusercontent.com/Madj42/RyobiGDO/master/RyobiGDOProxy.js
RUN chown -R nobody:users /opt/RyobiGDOProxy

EXPOSE 8024

CMD ["nodejs", "/opt/RyobiGDOProxy/RyobiGDOProxy.js"]
