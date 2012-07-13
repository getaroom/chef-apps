name             "apps"
maintainer       "getaroom"
maintainer_email "devteam@roomvaluesteam.com"
license          "MIT"
description      "Configures Apps"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.0.0"

supports "debian"
supports "ubuntu"

recipe "apps::user", "Setup apps' user from the apps data bag."
