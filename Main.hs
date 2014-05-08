{-# LANGUAGE OverloadedStrings #-}

import Data.Conduit.Network()
import Data.Default (def)
import Data.String (fromString)

import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Handler.Warp (setHost, setPort, defaultSettings)

import System.Environment (getArgs)

import Web.Scotty (Options(..), scottyOpts, middleware, get, text)

-- | you need to call the server like this:
--   
-- >> server 127.0.0.1 8080
main :: IO ()
main = do 
     opts <- commandLineOptions
     scottyOpts opts $ do
         middleware logStdoutDev
         get "/" $ text "Hello World!"

-- | reads scotty-options from the command-line arguments
-- expects at least two arguments: first the IP to be used followed by the port
commandLineOptions :: IO Options
commandLineOptions = do
  (ip:port:_) <- getArgs
  let sets = setPort (read port) . setHost (fromString ip) $ defaultSettings
  return $ def { verbose = 0, settings = sets }
