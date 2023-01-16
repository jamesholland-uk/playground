#! /usr/bin/env python3

# Code to lookup VMs (virtual machines) AKA images, listed in Azure

# pip install azure-identity
# pip install install azure-mgmt-compute
# export AZURE_CLIENT_ID=abc123
# export AZURE_TENANT_ID=abc123
# export AZURE_CLIENT_SECRET=abc123

import re
from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient

subscription_id = "abc123"
location = "eastus"
publisher_name = "PaloAltoNetworks"

# Acquire a credential object
token_credential = DefaultAzureCredential()

compute_client = ComputeManagementClient(token_credential, subscription_id)

print("-----Offers")
offers = compute_client.virtual_machine_images.list_offers(location, publisher_name)
for offer in offers:
    print(offer.name)
# cortex_xsoar
# panorama
# pcce_twistlock
# prisma-sd-wan-ion-virtual-appliance
# vmseries-beta
# vmseries-flex
# vmseries-forms
# vmseries1

print("-----SKUs")
skus = compute_client.virtual_machine_images.list_skus(location, publisher_name, Offer)
for sku in skus:
    print(sku.name)
# bundle1
# bundle2
# bundle3
# byol

print("-----Images")
for sku in skus:
    images = compute_client.virtual_machine_images.list(location, publisher_name, Offer, sku.name)
    for image in images:
        print(sku.name + ":" + image.name)
