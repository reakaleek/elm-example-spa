module Warehouse.Update exposing (..)
import Warehouse.Model as Model exposing (Model, warehouseToString)
import Warehouse.Msg as Msg exposing (Msg)
import Warehouse.Command as Command exposing (fetchWarehouse, postWarehouse)
import RemoteData exposing (WebData)

update : Msg -> Model -> ( Model, Cmd Msg )

update msg model =
    case msg of
        Msg.GetWarehouse ->
            ({ model | getIsLoading = True }, fetchWarehouse)
        Msg.OnFetchWarehouse warehouse ->
            maybeWarehouseResponse warehouse { model | getIsLoading = False }
        Msg.OnResponse response ->
            maybePostResponse response { model | postIsLoading = False }
        Msg.PostWarehouse ->
            ({ model | postIsLoading = True }, postWarehouse model.warehouse)
        Msg.Change newContent ->
            ({model | warehouse = newContent}, Cmd.none)

maybeWarehouseResponse : WebData Model.Warehouse -> Model -> (Model, Cmd Msg)
maybeWarehouseResponse response  model =
    case response of
        RemoteData.NotAsked ->
            ({ model | response = "" }, Cmd.none)
        RemoteData.Loading ->
            ({ model | response = "Loading.." }, Cmd.none)
        RemoteData.Success warehouse ->
            ({ model | warehouse =  warehouseToString warehouse }, Cmd.none)
        RemoteData.Failure error ->
            ({ model | response = (toString error)}, Cmd.none)
            
maybePostResponse : WebData String -> Model -> (Model, Cmd Msg)
maybePostResponse response  model =
    case response of
        RemoteData.NotAsked ->
            ({ model | response = "" }, Cmd.none)
        RemoteData.Loading ->
            ({ model | response = "Loading.." }, Cmd.none)
        RemoteData.Success response ->
            ({ model | response = response }, Cmd.none)
        RemoteData.Failure error ->
            ({ model | response = (toString error)}, Cmd.none)