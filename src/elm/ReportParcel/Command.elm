module ReportParcel.Command exposing (..)

import ReportParcel.Model as Model exposing (Model, ReportParcel, responseDecoder)
import ReportParcel.Msg as Msg exposing (Msg)
import Http exposing (..)
import RemoteData
import Json.Decode as Decode


postReportParcel : ReportParcel -> Cmd Msg
postReportParcel reportParcel =
    Http.post ("http://best-parcel-logistics.azurewebsites.net/api/parcel/" ++ reportParcel.trackingId ++ "/reportHop/" ++ reportParcel.trackingCode) Http.emptyBody Decode.string
        |> RemoteData.sendRequest
        |> Cmd.map Msg.OnPostResponse
