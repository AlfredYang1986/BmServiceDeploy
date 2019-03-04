FROM golang:alpine

RUN apk add --no-cache git mercurial

RUN git clone https://github.com/go-yaml/yaml /go/src/gopkg.in/yaml.v2
RUN cd /go/src/gopkg.in/yaml.v2 && git checkout tags/v2.2.2

RUN git clone https://github.com/go-mgo/mgo /go/src/gopkg.in/mgo.v2
RUN cd /go/src/gopkg.in/mgo.v2 && git checkout -b v2

LABEL BmPods.version="2.0.11" maintainer="Jeorch"

RUN go get github.com/alfredyang1986/blackmirror

RUN go get github.com/alfredyang1986/BmServiceDef

RUN go get github.com/alfredyang1986/BmPods

ADD deploy-config/ /go/bin/

ENV BM_HOME /go/bin

RUN go install -v github.com/alfredyang1986/BmPods

WORKDIR /go/bin

ENTRYPOINT ["BmPods"]
