FROM ubuntu:14.04
MAINTAINER richardtape <rich@richardtape.com>

RUN apt-get update && apt-get install -y \
	unzip \
	vim \
	git-core \
	curl \
	wget \
	build-essential \
	python-software-properties \
	software-properties-common

# Install nginx
RUN add-apt-repository -y ppa:nginx/stable

RUN apt-get update && apt-get install -y \
	nginx

# Install HHVM
RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | sudo apt-key add -
RUN echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
RUN apt-get update && apt-get install -y \
	hhvm

# Configure hhvm
RUN /usr/share/hhvm/install_fastcgi.sh
RUN update-rc.d hhvm defaults
RUN service hhvm restart
RUN /usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60

VOLUME ["/website_files"]
EXPOSE 80
