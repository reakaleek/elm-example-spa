module Msg exposing (..)
import Model exposing (Page)
import Warehouse.Msg as Warehouse exposing (Msg)

type Msg
    = GoTo (Maybe Page)
    | LinkTo String
    | WarehouseMsg Warehouse.Msg
