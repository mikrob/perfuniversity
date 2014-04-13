#!/bin/sh

# Required when master-cap is installed localy
export DEV=1

# Install master-chef on the VMs
cap appserver-devoxx chef:install -s user=vagrant
cap toolserver-devoxx chef:install -s user=vagrant
cap dbserver-devoxx chef:install -s user=vagrant

# Generate local json configuration
cap appserver-devoxx chef:generate_local_json
cap toolserver-devoxx chef:generate_local_json
cap dbserver-devoxx chef:generate_local_json

# Run the installation on the VMs
cap appserver-devoxx chef
cap toolserver-devoxx chef
cap dbserver-devoxx chef