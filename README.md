#openshift-scotty

OpenShift Scotty quickstart.

To get this app running on OpenShift, [sign up for OpenShift Online](https://www.openshift.com/app/account/new), [install the RHC command line tools](https://www.openshift.com/developers/rhc-client-tools-install), and run the following commands:

    rhc setup
    rhc app create scottyapp http://www.accursoft.com/cartridges/scotty.yml --from-code=http://github.com/CarstenKoenig/openshift-scotty.git

For more information about the Haskell community cartridge, see https://github.com/accursoft/Haskell-Cloud. 

## using cabal-sandbox
To use a cabal sandbox with this just run

   cabal sandbox init
   cabal install --dependencies-only

## testing it localy
To test this localy you can execute something like this:

   cabal run 127.0.0.1 8080

After this you should be able to navigate to [http://localhost:8080](http://localhost:8080) with your favorite browswer and see the app in action.
