module ReportParcel.Command exposing (..)
import ReportParcel.Model as Model exposing (Model, ReportParcel, responseDecoder)
import ReportParcel.Msg as Msg exposing (Msg)
import Http exposing (..)
import RemoteData

postReportParcel : String -> Cmd Msg 
postReportParcel reportParcel = 
    Http.post ("http://best-parcel-logistics.azurewebsites.net/api/reportparcel/" ++ reportParcel.trackingId ++ "/reportHop/" ++ reportParcel.trackingCode) responseDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msg.OnPostResponse