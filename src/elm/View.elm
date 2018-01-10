module View exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Msg exposing (Msg)
import Model exposing (Model, Page)
import Warehouse.View exposing (view)
import Parcel.View exposing (view)
<<<<<<< HEAD
import Tracking.View exposing (view)
import Model as Page exposing (Page)

=======
import ReportParcel.View exposing (view)
>>>>>>> reportparcel

view : Model -> Html Msg
view model =
    div []
        [ renderHeader model
        , renderPage model
        ]


renderHeader : Model -> Html Msg
renderHeader model =
    header [ class "main-header" ]
        [ renderHero model
        ]


renderHero : Model -> Html Msg
renderHero model =
    div [ class "hero is-dark" ]
        [ renderHeroBody
        , renderHeroFoot model
        ]


renderHeroBody : Html Msg
renderHeroBody =
    div [ class "hero-body" ]
        [ h1 [ class "title has-text-centered" ]
            [ span [] [ text "Parcel " ]
            , span [ class "icon" ] [ i [ class "fa fa-ship" ] [] ]
            , span [] [ text " Logistics" ]
            ]
        ]


renderHeroFoot : Model -> Html Msg
renderHeroFoot model =
    div [ class "hero-foot" ]
        [ div [ class "tabs is-centered is-boxed" ]
            [ ul []
                [ tabItem model.currentPage Page.Warehouse "#warehouse" "fa-home" "Warehouse"
                , tabItem model.currentPage Page.Parcel "#parcel" "fa-cube" "Parcel"
                , tabItem model.currentPage Page.TrackingInformation "#tracking-information" "fa-map-o" "Tracking Information"
                , tabItem model.currentPage Page.ReportParcel "#report-parcel" "fa-bullseye" "Report Parcel"
                ]
            ]
        ]


tabItem : Page -> a -> String -> String -> String -> Html Msg
tabItem currentPage page url icon txt =
    li [ class (getActiveClass currentPage (toString page)) ]
        [ a [ onClick (Msg.LinkTo url) ]
            [ faIcon icon
            , span [] [ text txt ]
            ]
        ]


faIcon : String -> Html Msg
faIcon faClass =
    span [ class "icon" ]
        [ i [ class ("fa " ++ faClass) ] []
        ]


getActiveClass : Model.Page -> String -> String
getActiveClass page pageName =
    if (toString page) == pageName then
        "is-active"
    else
        ""


renderPage : Model -> Html Msg
renderPage model =
    let
        pageContent =
            case model.currentPage of
                Page.TrackingInformation ->
                    Tracking.View.view model.tracking
                        |> Html.map Msg.TrackingMsg

                Page.ReportParcel ->
                    ReportParcel.View.view model.reportParcel
                        |> Html.map Msg.ReportParcelMsg

                Page.Parcel ->
                    Parcel.View.view model.parcel
                        |> Html.map Msg.ParcelMsg

                Page.Warehouse ->
                    Warehouse.View.view model.warehouse
                        |> Html.map Msg.WarehouseMsg
    in
        div [ class "section" ]
            [ div [ class "container" ] [ pageContent ]
            ]
