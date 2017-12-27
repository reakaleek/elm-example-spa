module Parcel.Command exposing (..)

import Parcel.Model as Model exposing (Model, Parcel, parcelToString, trackingIdDecoder)
import Parcel.Msg as Msg exposing (Msg)
import Http exposing (..)
import RemoteData


postParcel : Parcel -> Cmd Msg
postParcel parcel =
    Http.post "http://best-parcel-logistics.azurewebsites.net/api/parcel" (toJsonBody parcel) trackingIdDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msg.OnPostResponse


toJsonBody : Parcel -> Body
toJsonBody parcel =
    Http.stringBody "application/json" (parcelToString parcel)
