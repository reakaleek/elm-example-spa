module Update exposing (..)

import Model exposing (Model)
import Model as Page exposing (Page)
import Msg exposing (Msg)
import Navigation exposing (newUrl)
import Warehouse.Update exposing (update)
import Parcel.Update exposing (update)
import Tracking.Update exposing (update)
import ReportParcel.Update exposing (update)
import Router exposing (initalPageCmd)


update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.GoTo maybepage ->
            case maybepage of
                Nothing ->
                    ( { model | currentPage = Page.Warehouse }, Cmd.none )

                Just page ->
                    ( { model | currentPage = page }, initalPageCmd page )

        Msg.LinkTo path ->
            ( model, newUrl path )

        Msg.WarehouseMsg subMsg ->
            let
                ( newModel, newCmd ) =
                    Warehouse.Update.update subMsg model.warehouse
            in
                ( { model | warehouse = newModel }, Cmd.map Msg.WarehouseMsg newCmd )

        Msg.ParcelMsg subMsg ->
            let
                ( newModel, newCmd ) =
                    Parcel.Update.update subMsg model.parcel
            in
                ( { model | parcel = newModel }, Cmd.map Msg.ParcelMsg newCmd )

        Msg.TrackingMsg subMsg ->
            let
                ( newModel, newCmd ) =
                    Tracking.Update.update subMsg model.tracking
            in
                ( { model | tracking = newModel }, Cmd.map Msg.TrackingMsg newCmd )

        Msg.ReportParcelMsg subMsg ->
            let
                (newModel, newCmd) =
                    ReportParcel.Update.update subMsg model.reportParcel
            in
                ({ model | reportParcel = newModel}, Cmd.map Msg.ReportParcelMsg newCmd)

