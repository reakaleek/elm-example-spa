module ReportParcel.View exposing (..)

import ReportParcel.Model as Model exposing (Model)
import ReportParcel.Msg as Msg exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Json.Decode as Decode


view : Model -> Html Msg
view model =
    div []
        [ h2 [ class "title has-text-centered" ] [ text model.response ]
        , inputField "text" "TrackingId" model.reportParcel.trackingId Msg.TrackingId
        , inputField "text" "TrackingCode" model.reportParcel.trackingCode Msg.TrackingCode
        , button [ class ("button is-success " ++ loadingClass model.isLoading), onClick Msg.PostReportParcel ] [ text "Report Parcel" ]
        ]


loadingClass : Bool -> String
loadingClass isLoading =
    if isLoading then
        "is-loading"
    else
        ""


inputField : String -> String -> String -> (String -> Msg) -> Html Msg
inputField inputType placeholdr val msg =
    div [ class "field" ]
        [ div [ class "control" ]
            [ input [ class "input", type_ inputType, value val, onInput msg, placeholder placeholdr ] []
            ]
        ]


onChange : (String -> msg) -> Attribute msg
onChange msgCreator =
    Html.Events.on "change" (Decode.map msgCreator Html.Events.targetValue)
