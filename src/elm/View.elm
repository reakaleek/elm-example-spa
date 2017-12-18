module View exposing (view)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Msg exposing (Msg)
import Model exposing (Model, Page)
import Warehouse.View exposing (view)
import Parcel.View exposing (view)

view : Model -> Html Msg
view model =
    div []
        [ renderHeader model
        , renderPage model
        ]

renderHeader : Model -> Html Msg
renderHeader model =
    header [ class "main-header" ] [
        div [ class "hero is-dark" ] [ 
            div [ class "hero-body" ] [
                h1 [ class "title has-text-centered" ] [
                    span [] [ text "Parcel " ],
                    span [ class "icon" ] [ i [ class "fa fa-ship"] [] ],
                    span [] [ text " Logistics" ]
                ]
            ],
            div [ class "hero-foot"] [
                div [ class "tabs is-centered is-boxed" ] [ 
                    ul [] [ 
                        li [ class (getActiveClass model.currentPage "Warehouse") ] [
                            a [ onClick (Msg.LinkTo "#warehouse") ] [
                                span [ class "icon" ] [
                                    i [ class "fa fa-home" ] []
                                ],
                                span [] [ text "Warehouse" ] 
                            ]
                        ],
                        li [ class (getActiveClass model.currentPage "Parcel") ] [
                            a [ onClick (Msg.LinkTo "#parcel") ] [
                                 span [ class "icon" ] [
                                    i [ class "fa fa-cube" ] []
                                ],
                                span [] [ text "Parcel" ] 
                            ] 
                        ],
                        li [ class (getActiveClass model.currentPage "TrackingInformation") ] [
                            a [ onClick (Msg.LinkTo "#tracking-information") ] [
                                span [ class "icon" ] [
                                    i [ class "fa fa-map-o" ] []
                                ],
                                span [] [ text "TrackingInformation" ] 
                            ]
                        ],
                        li [ class (getActiveClass model.currentPage "ReportParcel") ] [ 
                            a [ onClick (Msg.LinkTo "#report-parcel") ] [
                                 span [ class "icon" ] [
                                    i [ class "fa fa-bullseye" ] []
                                ],
                                span [] [ text "ReportParcel" ] 
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ]

getActiveClass: Model.Page -> String -> String
getActiveClass page pageName =
    if (toString page) == pageName
    then  "is-active"
    else ""

renderPage : Model -> Html Msg
renderPage model =
    let
        pageContent =
            case model.currentPage of
                Model.TrackingInformation ->
                    text "Home"

                Model.ReportParcel ->
                    text "Login"

                Model.Parcel ->
                    Parcel.View.view model.parcel
                        |> Html.map Msg.ParcelMsg
                Model.Warehouse ->
                    Warehouse.View.view model.warehouse
                        |> Html.map Msg.WarehouseMsg
    in
        div [ class "section" ] [
            div [ class "container"] [ pageContent ]
        ]
