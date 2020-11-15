TARGET=evilg66k
PACKAGES=core database log parser

.PHONY: all
all: build

build:
	@go build -o ./bin/$(TARGET) -mod=vendor

clean:
	@go clean
	@rm -f ./bin/$(TARGET)

install:
	@mkdir -p /usr/share/evilg66k/phishlets
	@mkdir -p /usr/share/evilg66k/templates
	@cp ./phishlets/* /usr/share/evilg66k/phishlets/
	@cp ./templates/* /usr/share/evilg66k/templates/
	@cp ./bin/$(TARGET) /usr/local/bin
