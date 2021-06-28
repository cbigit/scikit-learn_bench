#!/bin/bash

echo "Installing intel scikit-learn-intelex"
conda install -y scikit-learn-intelex -c conda-forge

echo 'Running configs/svm/*.json on:'$model

#Determine CPU
model_string=$(lscpu | grep 'Model name')
model=$(echo $model_string | awk '{print $6}')
echo "Running configs/svm/*.json on:"$model

#Set NUMEXPR_MAX_THREADS to handle this case
#   INFO: Note: detected 96 virtual cores but NumExpr set to maximum of 64, check "NUMEXPR_MAX_THREADS" environment variable.
#   INFO: Note: NumExpr detected 96 cores but "NUMEXPR_MAX_THREADS" not set, so enforcing safe limit of 8.
#   INFO: NumExpr defaulting to 8 threads.
#
lcpu_string=$(lscpu | grep 'CPU(s)')
lcpu_count=$(echo $lcpu_string | awk '{print $2}')
echo "Logical Cores="$lcpu_count
echo "Setting NUMEXPR_MAX_THREADS="$lcpu_count
export NUMEXPR_MAX_THREADS=lcpu_count

#Optimized sklearn
python runner.py --config configs/svm/svc_proba_sklearn.json --report 
##python /cnvrg/report_generator/report_generator.py --result-files /cnvrg/results.json --report-file /cnvrg/report1.xlsx --generation-config configs/svm/svc_proba_sklearn.json --merging full
mv results.json.xlsx results-$model-svc_proba_sklearn-optimized.xlsx

#Non-Optimized sklearn
python runner.py --config configs/svm/svc_proba_sklearn.json --no-intel-optimized --report 
mv results.json.xlsx results-$model-svc_proba_sklearn-non-optimized.xlsx

#XGBoost First
python runner.py --config configs/xgboost/xgb_cpu_main_config.json --report 
mv results.json.xlsx results-$model-xgboost-optimized.xlsx

#XGBoost Additional
python runner.py --config configs/xgboost/xgb_cpu_additional_config.json --report 
mv results.json.xlsx results-$model-xgboost-xgb_cpu_additional-optimized.xlsx

#Start 
#/opt/intel/oneapi/vtune/latest/bin64/vtune-backend --web-port=6006 --allow-remote-ui --data-directory=/cnvrg/vtune-results

#apt install -y linux-tools-common
#You may need to install the following packages for this specific kernel:
#apt install -y linux-tools-4.14.214-160.339.amzn2.x86_64
#apt install -y linux-cloud-tools-4.14.214-160.339.amzn2.x86_64

#You may also want to install one of the following packages to keep up to date:
#apt install -y linux-tools-160.339.amzn2.x86_64
#apt install -y linux-cloud-tools-160.339.amzn2.x86_64
