module Tracking.Msg exposing (..)

import Tracking.Model as Model exposing (..)
import RemoteData exposing (WebData)


type Msg
    = OnGetResponse (WebData Model.TrackingInformation)
    | GetTrackingInformation
    | TrackingId String
