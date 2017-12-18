module Warehouse.Command exposing (..)
import Warehouse.Msg as Msg exposing (Msg)
import Http
import RemoteData
import Warehouse.Model exposing (warehouseDecoder)
import Json.Decode as Decode

fetchWarehouse : Cmd Msg
fetchWarehouse =
    Http.get "http://best-parcel-logistics.azurewebsites.net/api/warehouse" warehouseDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msg.OnFetchWarehouse

postWarehouse : String -> Cmd Msg
postWarehouse str = 
    Http.post "http://best-parcel-logistics.azurewebsites.net/api/warehouse" (Http.stringBody "application/json" str) Decode.string
        |> RemoteData.sendRequest
        |> Cmd.map Msg.OnResponse