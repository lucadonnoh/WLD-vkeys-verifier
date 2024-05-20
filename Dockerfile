FROM node:22.2.0
# JQ lower than 1.7 converts big numbers to scientific notation
ARG JQ_VERSION=1.7.1
ENV SEMAPHORE_R1CS https://storage.googleapis.com/trustedsetup-a86f4.appspot.com/semaphore/semaphore30/semaphore30.r1cs

# Install dependencies
RUN curl -sSL https://github.com/jqlang/jq/releases/download/jq-${JQ_VERSION}/jq-linux-amd64 -o /usr/bin/jq && \
    chmod +x /usr/bin/jq && \
    npm install -g snarkjs@0.6.11 && \
    curl -L https://foundry.paradigm.xyz | bash && \
    . /root/.bashrc && \
    foundryup

COPY verification.sh /usr/bin/verification.sh

CMD /bin/verification.sh
