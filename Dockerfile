FROM texlive/texlive:latest
RUN apt-get update && apt-get install -y make

RUN mkdir -p /var/cv
WORKDIR /var/cv
COPY . .

ENTRYPOINT ["make"]
