module Parcel.Model exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode
import Json.Decode.Pipeline as Pipeline exposing (decode, required)


type alias Model =
    { parcel : Parcel
    , response : String
    , isLoading : Bool
    }


initModel : Model
initModel =
    Model (Parcel 0 (Receipient "" "" "" "" "")) "" False


type alias TrackingId =
    { trackingId : String
    }


type alias Receipient =
    { firstName : String
    , lastName : String
    , street : String
    , postalCode : String
    , city : String
    }


type alias Parcel =
    { weight : Float
    , receipient : Receipient
    }


trackingIdDecoder : Decoder TrackingId
trackingIdDecoder =
    decode TrackingId
        |> required "trackingId" Decode.string


receipientDecoder : Decoder Receipient
receipientDecoder =
    decode Receipient
        |> required "firstName" Decode.string
        |> required "lastName" Decode.string
        |> required "street" Decode.string
        |> required "postalCode" Decode.string
        |> required "city" Decode.string


parcelDecoder : Decoder Parcel
parcelDecoder =
    decode Parcel
        |> required "weight" Decode.float
        |> required "receipient" receipientDecoder


receipientEncodeObject : Receipient -> Encode.Value
receipientEncodeObject receipient =
    Encode.object
        [ "firstName" => Encode.string receipient.firstName
        , "lastName" => Encode.string receipient.lastName
        , "street" => Encode.string receipient.street
        , "postalCode" => Encode.string receipient.postalCode
        , "city" => Encode.string receipient.city
        ]


parcelEncodeObject : Parcel -> Encode.Value
parcelEncodeObject parcel =
    Encode.object
        [ "weight" => Encode.float parcel.weight
        , "receipient" => receipientEncodeObject parcel.receipient
        ]


parcelToString : Parcel -> String
parcelToString parcel =
    Encode.encode 4 (parcelEncodeObject parcel)


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
