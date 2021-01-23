#TODO.Multi stage docker file
# first stage
# FROM python:3.8 AS builder
# COPY requirements.txt .

# # install dependencies to the local user directory (eg. /root/.local)
# RUN pip install --user -r requirements.txt

# # second unnamed stage
# FROM python:3.8-slim
# WORKDIR /code

# # copy only the dependencies installation from the 1st stage image
# COPY --from=builder /root/.local/bin /root/.local
# COPY web_api.py .

# # update PATH environment variable
# ENV PATH=/root/.local:$PATH

# CMD [ "python", "./web_api.py" ]
# set base image (host OS)
FROM python:3.8

# set the working directory in the container
WORKDIR /code

# copy the dependencies file to the working directory
COPY requirements.txt .

# install dependencies
RUN pip install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY web_api.py .

# command to run on container start
CMD [ "python", "./web_api.py" ]