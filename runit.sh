#!/bin/bash

echo "Installing intel scikit-learn-intelex"
conda install -y scikit-learn-intelex -c conda-forge

echo "Running configs/svm/svc_proba_sklearn.json"

#Optimized sklearn
python runner.py --config configs/svm/svc_proba_sklearn.json
python /cnvrg/report_generator/report_generator.py --result-files /cnvrg/results.json --report-file /cnvrg/report.xlsx --generation-config configs/svm/svc_proba_sklearn.json --merging none

#Non-Optimized sklearn
python runner.py --config configs/svm/svc_proba_sklearn.json --no-intel-optimized
python /cnvrg/report_generator/report_generator.py --result-files /cnvrg/results.json --report-file /cnvrg/report.xlsx --generation-config configs/svm/svc_proba_sklearn.json --merging full

#XGBoost First
python runner.py --config configs/xgboost/xgb_cpu_main_config.json
python /cnvrg/report_generator/report_generator.py --result-files /cnvrg/results.json --report-file /cnvrg/report.xlsx --generation-config configs/xgboost/xgb_cpu_main_config.json --merging full

#XGBoost Additional
python runner.py --config configs/xgboost/xgb_cpu_additional_config.json
python /cnvrg/report_generator/report_generator.py --result-files /cnvrg/results.json --report-file /cnvrg/report.xlsx --generation-config configs/xgb_cpu_additional_config.json --merging full

#Start 
#/opt/intel/oneapi/vtune/latest/bin64/vtune-backend --web-port=6006 --alloww-remote-ui

#apt install -y linux-tools-common
#You may need to install the following packages for this specific kernel:
#apt install -y linux-tools-4.14.214-160.339.amzn2.x86_64
#apt install -y linux-cloud-tools-4.14.214-160.339.amzn2.x86_64

#You may also want to install one of the following packages to keep up to date:
#apt install -y linux-tools-160.339.amzn2.x86_64
#apt install -y linux-cloud-tools-160.339.amzn2.x86_64
    
