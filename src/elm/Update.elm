module Update exposing (..)
import Model exposing (Model)
import Msg exposing (Msg)
import Navigation exposing (newUrl)
import Warehouse.Update exposing (update)
import Warehouse.Command exposing (fetchWarehouse)
import Parcel.Update exposing (update)
import Router exposing (initalPageCmd)

update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.GoTo maybepage ->
            case maybepage of
                Nothing ->
                    ( { model | currentPage = Model.Home }, Cmd.none )

                Just page ->                        
                    ({ model | currentPage = page }, initalPageCmd page)

        Msg.LinkTo path ->
            ( model, newUrl path )
        Msg.WarehouseMsg subMsg ->
            let 
                (newModel, newCmd) =
                    Warehouse.Update.update subMsg model.warehouse
            in
                ({ model | warehouse = newModel}, Cmd.map Msg.WarehouseMsg newCmd)
        Msg.ParcelMsg subMsg ->
            let
                (newModel, newCmd) =
                    Parcel.Update.update subMsg model.parcel
            in
                ({ model | parcel = newModel}, Cmd.map Msg.ParcelMsg newCmd)