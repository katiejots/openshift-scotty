{-# LANGUAGE OverloadedStrings #-}

import Control.Applicative ((<$>))

import Data.Aeson((.=), object)
import Data.Conduit.Network()
import Data.Default (def)
import Data.String (fromString)

import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static (staticPolicy, noDots, addBase, (>->))
import Network.Wai.Handler.Warp (setHost, setPort, defaultSettings)

import System.Environment (getArgs, lookupEnv)
import System.FilePath (combine)

import Web.Scotty (Options(..), ActionM
                  , scottyOpts, middleware
                  , setHeader, get, post, file, json
                  , param)

-- | you need to call the server like this:
--   
-- >> server 127.0.0.1 8080
main :: IO ()
main = do 
     opts <- commandLineOptions
     base <- baseFolder
     scottyOpts opts $ do
         middleware logStdoutDev
         middleware $ staticPolicy (noDots >-> addBase (combine base "static"))

         get  "/"        $ showIndexPage base
         get  "/about"   $ showAboutPage base

         post "/api/add" $ addNumbers

showIndexPage :: FilePath -> ActionM ()
showIndexPage base = do
   setHeader "Content-Type" "text/html"
   file $ combine base "static/index.html"

showAboutPage :: FilePath -> ActionM ()
showAboutPage base = do
   setHeader "Content-Type" "text/html"
   file $ combine base "static/about.html"

-- | gets two numbers from the request and 
-- returns a JSON object with the numbers and their sum
addNumbers :: ActionM ()
addNumbers = do
   a <- read <$> param "a"
   b <- read <$> param "b"
   let res = a+b :: Int
   json $ object [ "a"   .= a
                 , "b"   .= b
                 , "sum" .= res ]


-- | reads scotty-options from the command-line arguments
-- expects at least two arguments: first the IP to be used followed by the port
commandLineOptions :: IO Options
commandLineOptions = do
  (ip:port:_) <- getArgs
  let sets = setPort (read port) . setHost (fromString ip) $ defaultSettings
  return $ def { verbose = 0, settings = sets }

baseFolder :: IO FilePath
baseFolder = do
    maybe "." id <$>  lookupEnv repoDirEnvName


repoDirEnvName :: String
repoDirEnvName = "OPENSHIFT_REPO_DIR"
