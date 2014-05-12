{-# LANGUAGE OverloadedStrings #-}
import Data.Default (def)
import Data.String (fromString)
import Data.Monoid (mconcat)

import System.Environment (getArgs)

import Network.Wai.Handler.Warp (setHost, setPort, defaultSettings)
import Network.Wai.Middleware.RequestLogger (logStdoutDev)

import Web.Scotty (Options(..), scottyOpts, middleware
                  , get, post, param, text, html)

main :: IO ()
main = do
    opts <- commandLineOptions
    scottyOpts opts $ do
        middleware logStdoutDev
        get "/" $ text "Hello World!"
        get "/:word" $ do
            beam <- param "word"
            html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]

commandLineOptions :: IO Options
commandLineOptions = do
    (ip:port:_) <- getArgs
    let sets = setPort (read port) . setHost (fromString ip) $ defaultSettings
    return $ def { verbose = 0, settings = sets }
