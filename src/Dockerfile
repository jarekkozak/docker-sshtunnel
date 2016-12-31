# Copyright 2016 Jarosław Kozak
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:16.04

MAINTAINER jaroslaw.kozak68@gmail.com

# Install required packages and remove the apt packages cache when done.

RUN apt-get update && apt-get install -y \
	vim \
	sshpass \
	autossh \
	supervisor \
  && rm -rf /var/lib/apt/lists/*

#copy id does not work without this directory
RUN mkdir /root/.ssh

RUN mkdir /keys
ADD ./keys/* /keys/

EXPOSE 22
CMD ["supervisord", "-n"]

ADD genkeys.sh /genkeys.sh
ADD start-ssh.sh /start-ssh.sh

EXPOSE 1-65535
VOLUME ["/keys"]

RUN chmod +x /genkeys.sh
RUN chmod +x /start-ssh.sh
CMD ["/start-ssh.sh"]
