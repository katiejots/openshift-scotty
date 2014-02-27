openshift-scotty
================

OpenShift Scotty quickstart.

To get this app running on OpenShift, [sign up for OpenShift Online](https://www.openshift.com/app/account/new), [install the RHC command line tools](https://www.openshift.com/developers/rhc-client-tools-install), and run the following commands:

    rhc setup
    rhc app create scottyapp http://www.accursoft.com/cartridges/scotty.yml --from-code=http://github.com/codemiller/openshift-scotty.git

For more information about the Haskell community cartridge, see https://github.com/accursoft/Haskell-Cloud. 

