FROM ubuntu:16.04
MAINTAINER Scott Brown

RUN apt-get update -qq && apt-get install -y python-pip libssl-dev libffi-dev

RUN pip install --upgrade pip

COPY resources/requirements.txt /root/requirements.txt
RUN pip install -r /root/requirements.txt

RUN mkdir -p /etc/ansible/hosts
COPY resources/localhost.inventory /etc/ansible/hosts/localhost

ENTRYPOINT ["ansible-playbook"]

CMD ["--help"]

