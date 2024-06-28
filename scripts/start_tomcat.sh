#!/bin/bash
/usr/local/tomcat/bin/startup.sh
sudo systemctl enable --now tomcat
sudo systemctl restart tomcat
