{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString as B
import Network.HTTP
import Network.URI (parseURI)
import Control.Monad
import Text.Printf
-- I don't think this program even compiles at the moment.

downloadImage :: String -> String -> IO ()
downloadImage url file = do
    request <- get url
    case request of
        Nothing -> putStrLn $ "Invalid status code!"
        Just image -> B.writeFile file image
  where
    get url = let uri = case parseURI url of
                      Nothing -> error $ "Invalid URI: " ++ url
                      Just u  -> u in simpleHTTP (defaultGETRequest_ uri) >>= getResponseBody

-- This doesn't work currently.
get :: String -> IO (Maybe (IO String))
get url = do
    request <- simpleHTTP (getRequest url)
    responseCode <- getResponseCode request
    if responseCode /= (2, 0, 0) then
        return Nothing
    else
       return (Just (getResponseBody request))

main :: IO ()
main =  mapM_ print [1..10]
