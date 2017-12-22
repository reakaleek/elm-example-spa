module Tracking.Command exposing (..)
import Tracking.Model as Model exposing (Model, TrackingInformation, trackingInformationDecoder, trackingInformationToJson)
import Tracking.Msg as Msg exposing (Msg)
import Http exposing (..)
import RemoteData


getTrackingInformation : String -> Cmd Msg
getTrackingInformation trackingId =
    Http.get ("http://best-parcel-logistics.azurewebsites.net/api/parcel/" ++ trackingId) trackingInformationDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msg.OnGetResponse