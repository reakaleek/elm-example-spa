module ReportParcel.Model exposing (..)
import Json.Decode as Decode exposing(Decoder)
import Json.Encode as Encode
import Json.Decode.Pipeline as Pipeline exposing (decode, required)

type alias Model = 
    {reportParcel: ReportParcel
     , response: String
     , isLoading: Bool   
    }

initModel : Model
initModel =
    Model (TrackingId "" TrackingCode "")


type alias ReportParcel = 
    {
        trackingId: String,
        trackingCode: String
    }

trackingIdDecoder: Decoder ReportParcel
trackingIdDecoder = decode TrackingId
    |> required "trackingId" Decode.string
    |> required "trackingCode" Decode.string

reportParcelEncodeObject: ReportParcel -> Encode.Value
reportParcelEncodeObject reportParcel =
    Encode.object
        [
            "trackingId" => Encode.string trackingId
            ,"trackingCode" => Encode.string trackingCode
        ]

parcelReportToString: ReportParcel -> String 
parcelReportToString reportParcel =
    Encode.encode 4 (reportParcelEncodeObject reportParcel)

(=>) : a -> b -> ( a, b )
(=>) =
    (,)
