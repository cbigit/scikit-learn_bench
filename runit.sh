#!/bin/bash

echo "Installing intel scikit-learn-intelex"
conda install -y scikit-learn-intelex -c conda-forge

echo "Running configs/svm/svc_proba_sklearn.json"

#Optimized sklearn
python runner.py --config configs/svm/svc_proba_sklearn.json

#Non-Optimized sklearn
python runner.py --config configs/svm/svc_proba_sklearn.json --no-intel-optimized

#XGBoost First
python runner.py --config configs/xgboost/xgb_cpu_main_config.json

#XGBoost Additional
python runner.py --config configs/xgboost/xgb_cpu_additional_config.json
