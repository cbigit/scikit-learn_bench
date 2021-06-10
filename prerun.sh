#!/bin/bash
#
#
# oneAPI-AIKit has multiple virtual environments.  Two are implemented in this script [pytorch, tensorflow]
#   base                     /opt/intel/oneapi/intelpython/latest
#   2021.1.1                 /opt/intel/oneapi/intelpython/latest/envs/2021.1.1
#   pytorch               *  /opt/intel/oneapi/intelpython/latest/envs/pytorch
#   pytorch-1.5.0            /opt/intel/oneapi/intelpython/latest/envs/pytorch-1.5.0
#   tensorflow               /opt/intel/oneapi/intelpython/latest/envs/tensorflow
#   tensorflow-2.2.0         /opt/intel/oneapi/intelpython/latest/envs/tensorflow-2.2.0
#
#
# These can be selected in cnvrg by:
#     a) Populating this prerun.sh in the Files area of the project
#     b) Adding an env key value in cnvrg Project->Settings-> MYENV tensorflow (or other)
# 
# This script will add to the .cshrc to activate consoles and add the kernel to jupyter for notebooks.
#export MYENV=tensorflow
apt update
apt-get -y install git

if [ "$MYENV" == "tensorflow" ]; then 
    echo "Activating optimized Intel tensorflow virtual environment & jupyter kernal as idp"
    echo 'source activate tensorflow' >> ~/.bashrc
    conda run -n $MYENV pip install ipykernel matplotlib nibabel tqdm tensorflow_datasets psutil py-cpuinfo
    conda run -n $MYENV python3 -m ipykernel install --name $MYENV --display-name idp
elif [ "$MYENV" == "ovino" ]; then
    conda create -n $MYENV python=3
    echo "Activating open-vino as ovino"
    echo 'source activate ovino' >> ~/.bashrc
    python -m pip install --upgrade pip
    export PATH=/root/.local/bin:$PATH
    pip install python_version
    conda run -n $MYENV pip install ipykernel openvino-dev
    conda run -n $MYENV python3 -m ipykernel install --name $MYENV --display-name ovino
elif [ "$MYENV" == "pytorch" ]; then
    echo "Activating optimized Intel pytorch virtual environment & jupyter kernal as itorch"
    echo 'source activate pytorch' >> ~/.bashrc
    conda run -n $MYENV pip install ipykernel
    conda run -n $MYENV python3 -m ipykernel install --name $MYENV --display-name itorch
else 
    echo "oneAPI-AIKit startup with no virtual environment installed i.e. base"
fi


#https://medium.com/intel-analytics-software/leverage-intel-optimizations-in-scikit-learn-f562cb9d5544
#https://github.com/intel/scikit-learn-intelex
#python3 -m pip install -r sklearn_bench/requirements.txt
pip install openpyxl
conda install -y scikit-learn-intelex -c conda-forge


