module Tracking.Model exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode
import Json.Decode.Pipeline as Pipeline exposing (decode, required)


type alias Model =
    { trackingInformation : TrackingInformation
    , trackingId : String
    , errorResponse : String
    , isLoading : Bool
    }


initModel : Model
initModel =
    Model (TrackingInformation 0 [] []) "" "" False


type alias TrackingInformation =
    { state : Int
    , visitedHops : List HopArrival
    , futureHops : List HopArrival
    }


type alias HopArrival =
    { code : String
    , dateTime : String
    }



-- DECODE


hopArrivalDecoder : Decoder HopArrival
hopArrivalDecoder =
    decode HopArrival
        |> required "code" Decode.string
        |> required "dateTime" Decode.string


trackingInformationDecoder : Decoder TrackingInformation
trackingInformationDecoder =
    decode TrackingInformation
        |> required "state" Decode.int
        |> required "visitedHops" hopArrivalListDecoder
        |> required "futureHops" hopArrivalListDecoder


hopArrivalListDecoder : Decoder (List HopArrival)
hopArrivalListDecoder =
    Decode.list hopArrivalDecoder



-- ENCODE


hopArrivalEncodeObject : HopArrival -> Encode.Value
hopArrivalEncodeObject hopArrival =
    Encode.object
        [ "code" => Encode.string hopArrival.code
        , "dateTime" => Encode.string hopArrival.dateTime
        ]


trackingInformationEncodeObject : TrackingInformation -> Encode.Value
trackingInformationEncodeObject tr =
    Encode.object
        [ "state" => Encode.int tr.state
        , "visitedHops" => Encode.list (List.map hopArrivalEncodeObject tr.visitedHops)
        , "futureHops" => Encode.list (List.map hopArrivalEncodeObject tr.futureHops)
        ]


trackingInformationToJson : TrackingInformation -> String
trackingInformationToJson tr =
    Encode.encode 4 (trackingInformationEncodeObject tr)


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
