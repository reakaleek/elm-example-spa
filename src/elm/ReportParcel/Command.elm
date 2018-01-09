module ReportParcel.Command exposing (..)
import ReportParcel.Model as Model exposing (Model, ReportParcel, reportParcelToString, responseDecoder)
import ReportParcel.Msg as Msg exposing (Msg)
import Http exposing (..)
import RemoteData

postReportParcel : ReportParcel -> Cmd Msg 
postReportParcel reportParcel = 
    Http.post "http://best-parcel-logistics.azurewebsites.net/api/reportparcel" (Http.stringBody "application/json" (reportParcelToString reportParcel)) responseDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msg.OnPostResponse