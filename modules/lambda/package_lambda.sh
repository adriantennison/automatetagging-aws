#!/bin/bash

# Navigate to the source directory
cd src

# Install Python packages from requirements.txt into a package directory
pip install --target ./package -r requirements.txt

# Add the Python code to the package directory
cp *.py package/

# Package everything into a zip file
cd package
zip -r ../lambda_function.zip .

# Clean up the packaging directory
cd ..
rm -rf package
