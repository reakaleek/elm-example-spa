module Msg exposing (..)
import Model exposing (Page)
import Warehouse.Msg as Warehouse exposing (Msg)
import Parcel.Msg as Parcel exposing (Msg)
import Tracking.Msg as Tracking exposing (Msg)

type Msg
    = GoTo (Maybe Page)
    | LinkTo String
    | WarehouseMsg Warehouse.Msg
    | ParcelMsg Parcel.Msg
    | TrackingMsg Tracking.Msg
