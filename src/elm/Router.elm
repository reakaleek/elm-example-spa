module Router exposing (init, locFor, initalPageCmd)

import Navigation exposing (..)
import UrlParser exposing (..)
import Model exposing (Model)
import Model as Page exposing (Page)
import Msg exposing (Msg)
import Warehouse.Model exposing (Model)
import Parcel.Model exposing (Model)
import ReportParcel.Model exposing (Model)
import Warehouse.Command exposing (fetchWarehouse)


route : Parser (Page -> a) a
route =
    oneOf
        [ UrlParser.map Page.TrackingInformation (UrlParser.s "tracking-information")
        , UrlParser.map Page.ReportParcel (UrlParser.s "report-parcel")
        , UrlParser.map Page.Parcel (UrlParser.s "parcel")
        , UrlParser.map Page.Warehouse (UrlParser.s "warehouse")
        ]


locFor : Location -> Msg
locFor location =
    parseHash route location
        |> Msg.GoTo


init : Location -> ( Model.Model, Cmd Msg )
init location =
    let
        page =
            case parseHash route location of
                Nothing ->
                    Model.Warehouse

                Just page ->
                    page
    in
        ( Model.initModel page, initalPageCmd page )


initalPageCmd : Page -> Cmd Msg.Msg
initalPageCmd page =
    case page of
        Model.Warehouse ->
            Cmd.map Msg.WarehouseMsg fetchWarehouse

        _ ->
            Cmd.none
