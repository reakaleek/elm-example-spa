module Warehouse.View exposing (..)

import Warehouse.Model exposing (Model)
import Warehouse.Msg exposing (Msg)
import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [ class "field" ]
            [ p [ class ("control " ++ loadingClass model.getIsLoading) ]
                [ textarea [ value model.warehouse, class "textarea", rows 12, onInput Warehouse.Msg.Change ] []
                ]
            ]
        , div [ class "field" ]
            [ p [ class "help" ] [ text model.response ]
            ]
        , div [ class "field is-grouped" ]
            [ p [ class "control" ]
                [ button [ class ("button is-success " ++ loadingClass model.postIsLoading), onClick Warehouse.Msg.PostWarehouse ]
                    [ span [ class "icon" ]
                        [ i [ class "fa fa-floppy-o" ] []
                        ]
                    , span []
                        [ text "post warehouse"
                        ]
                    ]
                ]
            , p [ class "control" ]
                [ button [ class ("button is-info " ++ loadingClass model.getIsLoading), onClick Warehouse.Msg.GetWarehouse ]
                    [ span [ class "icon" ]
                        [ i [ class "fa fa-refresh" ] []
                        ]
                    , span []
                        [ text "reload"
                        ]
                    ]
                ]
            ]
        ]


loadingClass : Bool -> String
loadingClass isLoading =
    if isLoading then
        "is-loading"
    else
        ""
