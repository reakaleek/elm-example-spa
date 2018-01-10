module ReportParcel.Model exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode
import Json.Decode.Pipeline as Pipeline exposing (decode, required)


type alias Model =
    { reportParcel : ReportParcel
    , response : String
    , isLoading : Bool
    }


initModel : Model
initModel =
    Model (ReportParcel "" "") "" False


type alias ReportParcel =
    { trackingId : String
    , trackingCode : String
    }


type alias Response =
    {}


responseDecoder : Decoder Response
responseDecoder =
    decode Response


reportParcelEncodeObject : ReportParcel -> Encode.Value
reportParcelEncodeObject reportParcel =
    Encode.object
        [ "trackingId" => Encode.string reportParcel.trackingId
        , "trackingCode" => Encode.string reportParcel.trackingCode
        ]


reportParcelToString : ReportParcel -> String
reportParcelToString reportParcel =
    Encode.encode 4 (reportParcelEncodeObject reportParcel)


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
