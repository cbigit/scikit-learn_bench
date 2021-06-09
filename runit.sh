#!/bin/bash

echo "Installing intel scikit-learn-intelex"
conda install -y scikit-learn-intelex -c conda-forge

echo "Running configs/svm/svc_proba_sklearn.json"
python runner.py --config configs/svm/svc_proba_sklearn.json
