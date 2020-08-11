FROM python:3.7-slim-stretch

RUN apt-get update && apt-get install -y vim

WORKDIR /tmp

# Upgrade pip
RUN pip install --upgrade pip
# install ansible and pip libs
COPY ./requirements.txt /tmp/
RUN if [ -f "requirements.txt" ]; then pip install -r requirements.txt && rm requirements.txt*; fi \
    # make work dir
    && mkdir /ansible \
    # make ssh dir
    && mkdir /root/.ssh

# add ansible config to user dir
ADD ./config/ansible.cfg /root/.ansible.cfg

# copy ssh keys
ADD ./ssh /root/.ssh

# config ssh, ansible.cfg permission
RUN chmod 600 /root/.ssh \
    && chmod 400 -R /root/.ssh/ \
    && rm /root/.ssh/.gitkeep \
    && chmod 400 -R /root/.ansible.cfg