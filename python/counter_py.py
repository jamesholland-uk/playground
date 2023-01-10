#!/usr/bin/env python

# Written by: William A Thomas

# This python script is to count items on the firewall and report
# their output to that you can see if you are getting close to capacity

import requests
import urllib3
import xml.etree.ElementTree as ET
from getpass import getpass

edlcount = 0
addcount = 0
custappcount = 0
servcount = 0
appocount = 0
decpcount = 0
natpcount = 0
secpcount = 0
pbfcount = 0
dospcount = 0
sdwanpcount = 0
tunnelcount = 0
ldapserv = 0
kerbcount = 0  # Not implimented yet
mfaserv = 0  # Not implimented yet
netflowserv = 0  # Not implimented yet
radiusserv = 0  # Not implimented yet
samlserv = 0  # Not implimented yet
tacplusserv = 0  # Not implimented yet
routecount = 0
admincount = 0


print(
    """
****************************************************************
*                                                              *
*             SCRIPT RUNNING - Usage Counter                   *
*                                                              *
****************************************************************"""
)

pano_ip = input("Enter the Firewall IP Address: ")
print("--I will ask for your username and password to pull your API key--")
userid = input("Enter your user ID for the PAN device: ")
userpass = getpass("Enter your user password for the PAN device (password is hidden): ")
keyurl = "https://%s/api/?type=keygen&user=%s&password=%s" % (pano_ip, userid, userpass)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
keyxml = requests.get(
    keyurl, verify=False
)  # Also needed to ignore SSL security warnings
document = ET.fromstring(keyxml.content)  # parse XML info
for result in document:  # Look at results
    for key in result.findall("key"):  # Look for the key in the results
        apikey = key.text  # Store the key

# ---------------EDL----------------
print("\n----- Checking Current Counts Now -----\n")
print("Checking - EDL Capacities")
url = (
    "https://%s/api/?type=op&cmd=<request><system><external-list><list-capacities></list-capacities></external-list></system></request>&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:  # Start after root (result)
    for answer in result:  # Start iterating after devices (entries)
        for value in answer.findall(
            "running-cap"
        ):  # look for the IPs listed in the members
            edlcount = edlcount + int(value.text)  # print them in the cli
print("Done")

# ---------------ADDRESS----------------
print("Checking - Address Objects")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/address&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for address in result:
        for entry in address.findall("entry"):
            addcount += 1
print("Done")

# ---------------APPLICATIONS----------------
print("Checking - Custom Applications")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/application&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for app in result:
        for entry in app.findall("entry"):
            custappcount += 1
print("Done")

# ---------------SERVICES----------------
print("Checking - Services")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/service&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for service in result:
        for entry in service.findall("entry"):
            servcount += 1
print("Done")

# ---------------SECURITY RULES----------------
print("Checking - Security Rules")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/rulebase/security/rules&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for rules in result:
        for entry in rules.findall("entry"):
            secpcount += 1
print("Done")

# ---------------NAT RULES----------------
print("Checking - NAT Rules")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/rulebase/nat/rules&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for rules in result:
        for entry in rules.findall("entry"):
            natpcount += 1
print("Done")

# ---------------DECRYPTION RULES----------------
print("Checking - Decryption Rules")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/rulebase/decryption/rules&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for rules in result:
        for entry in rules.findall("entry"):
            decpcount += 1
print("Done")

# ---------------APP OVERRIDE RULES----------------
print("Checking - App Override Rules")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/rulebase/application-override/rules&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for rules in result:
        for entry in rules.findall("entry"):
            appocount += 1
print("Done")

# ---------------PBF RULES----------------
print("Checking - PBF Rules")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/rulebase/pbf/rules&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for rules in result:
        for entry in rules.findall("entry"):
            pbfcount += 1
print("Done")

# ---------------DOS RULES----------------
print("Checking - DOS Rules")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/rulebase/dos/rules&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for rules in result:
        for entry in rules.findall("entry"):
            dospcount += 1
print("Done")

# ---------------SD-WAN RULES----------------
print("Checking - SDWAN Rules")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/rulebase/sdwan/rules&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for rules in result:
        for entry in rules.findall("entry"):
            sdwanpcount += 1
print("Done")

# ---------------TUNNEL-INSPECT RULES----------------
print("Checking - Tunnel Inspection Rules")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/devices/entry[@name='localhost.localdomain']/vsys/entry[@name='vsys1']/rulebase/tunnel-inspect/rules&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for rules in result:
        for entry in rules.findall("entry"):
            tunnelcount += 1
print("Done")

# ---------------LDAP Servers----------------
print("Checking - LDAP Servers")
url = (
    "https://%s/api/?type=config&action=get&xpath=/config/shared/server-profile/ldap&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for ldap in result:
        for entry in ldap:
            for server in entry:
                for serventry in server.findall("entry"):
                    ldapserv += 1
print("Done")

# ---------------ROUTES----------------
print("Checking - Total Routes on the Device")
url = (
    "https://%s/api/?type=op&cmd=<show><routing><summary></summary></routing></show>&key=%s"
    % (pano_ip, apikey)
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for entry in result:
        for allroutes in entry.findall("All-Routes"):
            for total in allroutes.findall("total"):
                routecount = int(total.text)
print("Done")

# ---------------ADMINS----------------
print("Checking - Total Admins on Device")
url = "https://%s/api/?type=op&cmd=<show><admins><all></all></admins></show>&key=%s" % (
    pano_ip,
    apikey,
)
urllib3.disable_warnings(
    urllib3.exceptions.InsecureRequestWarning
)  # Ignore SSL security warnings
xml = requests.get(url, verify=False)  # Also needed to ignore SSL security warnings
document = ET.fromstring(xml.content)
for result in document:
    for admins in result:
        for entry in admins.findall("entry"):
            admincount += 1
print("Done")

print("\n --- RESULTS ---")
print("Total EDL Values = " + str(edlcount))
print("Total Address Objects = " + str(addcount))
print("Total Custom Applications = " + str(custappcount))
print("Total Service Objects = " + str(servcount))
print("Total Security Policies = " + str(secpcount))
print("Total NAT Policies = " + str(natpcount))
print("Total Decryption Policies = " + str(decpcount))
print("Total Application Override Policies = " + str(appocount))
print("Total PBF Policies = " + str(pbfcount))
print("Total DOS Policies = " + str(dospcount))
print("Total SDWAN Policies = " + str(sdwanpcount))
print("Total Tunnel Inspection Policies = " + str(tunnelcount))
print("LDAP Servers = " + str(ldapserv))
print("Total Routes = " + str(routecount))
print("Total Administrators = " + str(admincount))

print("\n")
