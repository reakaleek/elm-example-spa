module ReportParcel.Msg exposing (..)
import RemoteData exposing (WebData)
import ReportParcel.Model as ReportParcel exposing (Model)

type Msg
    = OnPostResponse (WebData String)
    | PostReportParcel
    | TrackingId String
    | TrackingCode String