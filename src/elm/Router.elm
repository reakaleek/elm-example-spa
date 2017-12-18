module Router exposing (init, locFor, initalPageCmd)
import Navigation exposing (..)
import UrlParser exposing (..)
import Model exposing (Model)
import Msg exposing (Msg)
import Warehouse.Model exposing (Model)
import Parcel.Model exposing (Model)
import Warehouse.Command exposing (fetchWarehouse)
route : Parser (Model.Page -> a) a
route =
    oneOf
        [ UrlParser.map Model.Home (UrlParser.s "home")
        , UrlParser.map Model.Login (UrlParser.s "login")
        , UrlParser.map Model.Parcel (UrlParser.s "parcel")
        , UrlParser.map Model.Warehouse (UrlParser.s "warehouse")
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
                    Model.Home
                Just page ->
                    page
    in
        ( Model.Model page Warehouse.Model.initModel Parcel.Model.initModel, initalPageCmd page )

initalPageCmd : Model.Page -> Cmd Msg.Msg
initalPageCmd page =
    case page of
        Model.Warehouse ->
            Cmd.map Msg.WarehouseMsg fetchWarehouse
        _ ->
            Cmd.none