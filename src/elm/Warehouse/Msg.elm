module Warehouse.Msg exposing (..)

import RemoteData exposing (WebData)
import Warehouse.Model exposing (Warehouse)


type Msg
    = OnFetchWarehouse (WebData Warehouse)
    | GetWarehouse
    | OnResponse (WebData String)
    | PostWarehouse
    | Change String
