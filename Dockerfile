FROM golang:alpine

RUN apk add --no-cache git mercurial

RUN git clone https://github.com/go-yaml/yaml /go/src/gopkg.in/yaml.v2 && \
cd /go/src/gopkg.in/yaml.v2 && git checkout tags/v2.2.2 && \
git clone https://github.com/go-mgo/mgo /go/src/gopkg.in/mgo.v2 && \
cd /go/src/gopkg.in/mgo.v2 && git checkout -b v2 && \
go get -u github.com/aliyun/alibaba-cloud-sdk-go/sdk && \
git clone https://github.com/golang/time /go/src/golang.org/x/time

LABEL BmPods.version="2.0.31" maintainer="Jeorch"

ENV BM_HOME /go/bin

RUN go get github.com/alfredyang1986/blackmirror && \
go get github.com/alfredyang1986/BmServiceDef && \
go get github.com/alfredyang1986/BmPods

RUN go install -v github.com/alfredyang1986/BmPods

ADD deploy-config/ /go/bin/

WORKDIR /go/bin

ENTRYPOINT ["BmPods"]
