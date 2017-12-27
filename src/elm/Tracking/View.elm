module Tracking.View exposing (view)

import Tracking.Model as Model exposing (Model)
import Tracking.Msg as Msg exposing (Msg)
import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ renderForm model
        , renderTrackingInformation model
        ]


renderForm : Model -> Html Msg
renderForm model =
    div [ class "columns is-centered" ]
        [ div [ class "column is-12" ]
            [ div [ class "field has-addons" ]
                [ div [ class ("control is-expanded " ++ loadingClass model.isLoading) ]
                    [ input
                        [ class "input"
                        , placeholder "Tracking ID"
                        , onInput Msg.TrackingId
                        , value model.trackingId
                        ]
                        []
                    ]
                , div [ class "control" ]
                    [ button [ class "button is-info", onClick Msg.GetTrackingInformation ] [ text "Get Tracking Information" ]
                    ]
                ]
            , p [ class "help is-danger" ] [ text model.errorResponse ]
            ]
        ]


renderTrackingInformation : Model -> Html Msg
renderTrackingInformation model =
    div [ class "columns is-multiline" ]
        [ div [ class "column is-12" ]
            [ renderHopArrivals model.trackingInformation.visitedHops "Visited hops"
            ]
        , div [ class "column is-12" ]
            [ renderHopArrivals model.trackingInformation.futureHops "Future hops"
            ]
        ]


renderHopArrivals : List Model.HopArrival -> String -> Html Msg
renderHopArrivals lst title1 =
    if List.length lst > 0 then
        div []
            [ h4 [ class "title is-size-5" ] [ text title1 ]
            , renderHopArrivalList lst
            ]
    else
        div [] []


renderHopArrivalList : List Model.HopArrival -> Html Msg
renderHopArrivalList lst =
    lst
        |> List.map (\hopArrival -> li [] [ renderHopArrivalItem hopArrival ])
        |> ul []


renderHopArrivalItem : Model.HopArrival -> Html Msg
renderHopArrivalItem hopArrival =
    div [ class "field" ]
        [ div [ class "control" ]
            [ div [ class "tags has-addons" ]
                [ span [ class "tag is-dark is-medium" ] [ text hopArrival.code ]
                , span [ class "tag is-success is-medium" ] [ text hopArrival.dateTime ]
                ]
            ]
        ]


loadingClass : Bool -> String
loadingClass isLoading =
    if isLoading then
        "is-loading"
    else
        ""
