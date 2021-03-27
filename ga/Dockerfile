FROM balenalib/raspeberrypi3-debian


# Set locales
ENV \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8

# copy files needed
COPY  file /file 
RUN cp /file/asoundrc.config /root/.asoundrc
RUN chmod +x /file/installCred.sh
RUN chmod +x /file/GA.sh

# Install packages
RUN apt-get update \
    && apt-get install -y \
      alsa-utils \
      python3 \
      python3-pip \
      portaudio19-dev \
      libffi-dev \
      libssl-dev \
    && rm -rf /var/lib/apt/lists/*


# # Install and set python
RUN pip3 install --upgrade setuptools wheel
# RUN pip3 install /file/grpcio-1.36.1-cp37-cp37m-linux_armv7l.whl /file/cryptography-3.4.7-cp37-cp37m-linux_armv7l.whl 

# Install google-assistant-sdk
RUN pip3 install --upgrade google-assistant-sdk[samples]

# Install the authorization tool:
RUN pip3 install --upgrade google-auth-oauthlib[tool]

# Run google-assistant
CMD /file/GA.sh 
