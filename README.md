# nburn-docker
A Dockerfile for creating an NetBurner Development Kit installation. It includes all utilities required to build and run any app, or your own file.

This Dockerfile has been tested and verified in all post 3.3.8 releases of the NNDK. 

# Usage

When building the docker image, you must specific a local location of a Linux install file. This file can be downloaded from [NetBurner Support](https://support.netburner.com/SelfService/Tools.html). You will also need to specify your development kit serial number.

### Build:
`docker build --build-arg NNDK_INSTALLER=NNDK-3.3.8-installer.run --build-arg SERIAL_NUMBER=EXAMPLE:123123123 -t nburn3:latest .`
### Run:
`docker run -it --rm nburn3:latest`

When you enter the nburn container, be sure to set your device platform and ip address:  
`export DEVIP=192.168.1.2`

`export PLATFORM=MOD5441X`

