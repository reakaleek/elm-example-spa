module Warehouse.Model exposing (..)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline exposing (decode, required)
import Json.Encode as Encode exposing (Value)

type alias Model =
    { warehouse: String
    , response: String
    , getIsLoading: Bool
    , postIsLoading: Bool
    }

initModel : Model
initModel = 
    { warehouse = ""
    , response = ""
    , getIsLoading = True
    , postIsLoading = False
    }

type alias Warehouse =
    { code: String
    , description: String
    , duration: Float
    , nextHops: ChildWarehouses
    , trucks: List Truck
    }

type ChildWarehouses = ChildWarehouses (List Warehouse)

type alias Truck =
    { code: String
    , numberPlate: String
    , latitude: Float
    , longitude: Float
    , radius: Float
    , duration: Float
    }

warehouseDecoder : Decoder Warehouse
warehouseDecoder =
    Decode.map5 Warehouse
        (Decode.field "code" Decode.string)
        (Decode.field "description" Decode.string)
        (Decode.field "duration" Decode.float)
        (Decode.field "nextHops" childWarehousesDecoder)
        (Decode.field "trucks" trucksDecoder)

childWarehousesDecoder : Decode.Decoder ChildWarehouses
childWarehousesDecoder = 
    Decode.map ChildWarehouses (Decode.list (Decode.lazy (\_ -> warehouseDecoder)))

trucksDecoder : Decode.Decoder (List Truck)
trucksDecoder =
    Decode.list truckDecoder

warehouseEncodeObject : Warehouse -> Encode.Value
warehouseEncodeObject warehouse =
    Encode.object
        [ "code" => Encode.string warehouse.code
        , "description" => Encode.string warehouse.description
        , "duration" => Encode.float warehouse.duration
        {- "nextHops" => ???? -}
        , "nextHops" => Encode.list (List.map warehouseEncodeObject (getWarehouseList warehouse.nextHops)) 
        , "trucks" => Encode.list (List.map truckEncodeObject warehouse.trucks)
        ]

warehouseToString : Warehouse -> String
warehouseToString warehouse = 
    Encode.encode 4 (warehouseEncodeObject warehouse)

getWarehouseList: ChildWarehouses -> List Warehouse
getWarehouseList childWarehouses =
    case childWarehouses of
        ChildWarehouses list ->
            list

truckDecoder : Decode.Decoder Truck
truckDecoder = decode Truck
    |> required "code" Decode.string
    |> required "numberPlate" Decode.string
    |> required "latitude" Decode.float
    |> required "longitude" Decode.float
    |> required "radius" Decode.float
    |> required "duration" Decode.float

truckEncodeObject : Truck -> Encode.Value
truckEncodeObject truck =
    Encode.object
        [ "code" => Encode.string truck.code
        , "numberPlate" => Encode.string truck.numberPlate
        , "latitude" => Encode.float truck.latitude
        , "longitude" => Encode.float truck.longitude
        , "radius" => Encode.float truck.radius
        , "duration" => Encode.float truck.duration
        ]

(=>) : a -> b -> ( a, b )
(=>) =
    (,)