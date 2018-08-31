{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString as B
import qualified Data.Text as T
import Data.Text.Encoding (encodeUtf8)
import Network.HTTP
import Network.URI (parseURI)
import Control.Monad

packString :: String -> B.ByteString
packString = encodeUtf8 . T.pack

downloadImage :: String -> String -> IO ()
downloadImage url file = do
    request <- get url
    B.writeFile file (packString request)

-- TODO: Check status code and do something if it's not 200
get :: String -> IO String
get url = do
    request <- simpleHTTP (getRequest url)
    return request >>= getResponseBody
