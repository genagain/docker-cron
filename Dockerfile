FROM ubuntu:latest

RUN apt-get update && apt-get install -y python3.8 && apt-get install -y python3-pip
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

RUN pip3 install pipenv

# Add crontab file in the cron directory

#Install Cron
RUN apt-get -y install cron

# Give execution rights on the cron job
RUN chmod 664 /etc/crontab
COPY crontab /etc/crontab
COPY . .
RUN chmod 744 test.py

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

CMD cron -f && tail /var/log/cron.log
