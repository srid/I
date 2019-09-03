{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TypeFamilies #-}
module Backend where

import Data.Dependent.Sum (DSum ((:=>)))
import Data.Functor.Identity (Identity (..))

import Snap

import Obelisk.Backend
import Obelisk.Route hiding (decode, encode)

import Common.Route

backend :: Backend BackendRoute FrontendRoute
backend = Backend
  { _backend_run = \serve ->
      serve requestHandler
  , _backend_routeEncoder = fullRouteEncoder
  }
  where
    requestHandler :: MonadSnap m => R BackendRoute -> m ()
    requestHandler = \case
      BackendRoute_Missing :=> Identity () -> do
        writeLBS "404"
      BackendRoute_AddMood :=> Identity () -> do
        writeLBS "TODO"
