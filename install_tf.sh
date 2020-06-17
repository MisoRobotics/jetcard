#!/bin/sh
date

# Install the pre-built TensorFlow pip wheel
echo "\e[48;5;202m Install the pre-built TensorFlow pip wheel \e[0m"
sudo apt-get update
sudo apt-get install -y libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev
sudo apt-get install -y python3-pip
sudo -H pip3 install -U pip setuptools
sudo -H pip3 install -U numpy grpcio absl-py py-cpuinfo psutil portpicker six mock requests gast h5py astor termcolor protobuf keras-applications keras-preprocessing wrapt google-pasta
sudo -H pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow==1.15.2+nv20.4

# Install TensorFlow models repository
echo "\e[48;5;202m Install TensorFlow models repository \e[0m"
cd
url="https://github.com/tensorflow/models"
tf_models_dir="TF-models"
if [ ! -d "$tf_models_dir" ] ; then
	git clone $url $tf_models_dir
	cd "$tf_models_dir"/research
	git checkout 5f4d34fc
	wget -O protobuf.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.7.1/protoc-3.7.1-linux-aarch_64.zip
	# wget -O protobuf.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.7.1/protoc-3.7.1-linux-x86_64.zip
	unzip protobuf.zip
	./bin/protoc object_detection/protos/*.proto --python_out=.
	sudo -H python3 setup.py install
	cd slim
	sudo -H python3 setup.py install
fi

echo "\e[42m All done! \e[0m"

#record the time this script ends
date

