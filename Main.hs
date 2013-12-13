{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import System.Environment
import Control.Monad
import Network.Wai.Middleware.RequestLogger
import Data.Default (def)
import Network.Wai.Handler.Warp (settingsPort, settingsHost)
import Data.Conduit.Network

opts :: String -> Int -> Options
opts ip port = def { verbose = 0
                   , settings = (settings def) { settingsHost = Host ip, settingsPort = port }
               }

main :: IO ()
main = do 
     (ip:port:args) <- getArgs
     scottyOpts (opts ip $ read port) $ do
         middleware logStdoutDev
         get "/" $ text "Hello World!"

