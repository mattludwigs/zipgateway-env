# zipgateway-env

Docker env for compiling and running zipgateway.

When building a Z/IP Client library it would be nice to be able to compile,
test, and run `zipgateway` locally without having to think about installing
and configuring your system. This has proven to be challenging for
various reasons. This docker environment was made to help streamline the
process. It allows you to compile and run different versions on `zipgateway`
and uses your host machine networking to allow this to be ran as if it were
running natively.

General and hardware system requirements:
  * Docker
  * Tuntap kernel module
    * Mac OSX - `brew install tuntap`
  * Z-Wave Bridge Controller
    * [Z-Wave 500](https://www.digikey.com/products/en?mpart=ACC-UZB3-U-BRG&v=336)
    * [Z-Wave 700](https://www.digikey.com/product-detail/en/silicon-labs/SLUSB001A/336-5899-ND/9867108)
  * Ubuntu 18+
  * Mac OSX (currently not tested or documented but should work, but might need to run some extra commands)
  * [Silicon Labs zipgateway source](https://www.silabs.com/products/development-tools/software/z-wave/controller-sdk/z-ip-gateway-sdk)

Supported `zipgateway` versions:
  * `2.81.03`
  * `7.11.01`
  * `7.17.01`

## Getting Started

First you will need to clone the repo and checkout the latest

```
git clone https://github.com/mattludwigs/zipgateawy-env.git
git checkout v0.1.0
```

Then you will need to build the docker image

```
./env.sh build
```

Lastly, you can run the environment

```
./env.sh
```

This will place into the docker image and now you do things like compile and
run `zipgateway`.

They primary way to do this is via the `zgw` cli tool that is provided.


### zgw

The `zgw` is a cli tool for compiling and running `zipgateway`.

### Compiling zipgateway

To compile the `zipgateway` binary you will first need to [download](https://www.silabs.com/products/development-tools/software/z-wave/controller-sdk/z-ip-gateway-sdk)
it from Silicon Labs website. This will require you to register and login but
it is free to download and development against.

This will download a compressed file that you will need extract somewhere.

For the following steps we will be using the `zipgateway` version `2.81.03`
which is the current downloadable version from Silicon Labs' website. However,
these steps should remain true for other support `zipgateway` versions.

The extracted file tree will look something like:

```
├── Binaries
├── Doxygen
├── PDF
├── REL14467-3.doc
├── REL14467-3.pdf
├── Source
└── ZIP GW 2.81.03 Active.zip
```

Then in side the `Source` directory there will be another tar file that will
look like `zipgateway-<version>-Source.tar.gz2`. You will want to extract that
as well. Now the directory tree int eh `Source` directory will look like

```
├── pyzip_ver1_21.zip
├── zipgateway-2.81.03-Source
└── zipgateway-2.81.03-Source.tar.bz2
```

Inside the untared source directory contains the source. In order to get the
source in the desired location for `zipgateway-env` to compile it run the
following:

```
cp -rv zipgateway-2.81.03/* <path_to_zipgateway_env_project>/zipgateway-source/2.81.03
```

If you are using a different supported `zipgateway` version feel free to switch
out the versions accordingly.

Now we will want to run the env and tell it to compile `zipgateway` for us:

```
./env.sh
zgw compile 2.81.03
```

This should compile and setup additional configuration files needed for
`zipgateway`.

### Cross compiling `zipgateway`

To cross compile for raspberry pi (arm) architecture, set the CROSS environment
variable and run `zgw compile as above`

```
export CROSS=true
zgw compile 7.17.01
```

The resulting `zipgateway` binary will be suitable for running on a raspberry pi

### Running `zipgateway`

To run zipgateway ensure that you have your Z-Wave bridge controller in your
computer and shows up as a device in the `/dev` directory. For the below
example we assume that USB device is `/dev/ttyUSB0` and we are going run
version `2.81.03`:

```
./env.sh
zgw run /dev/ttyUSB0 2.81.03
```
