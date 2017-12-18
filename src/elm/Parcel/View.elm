module Parcel.View exposing (..)
import Parcel.Model as Model exposing (Model)
import Parcel.Msg as Msg exposing (Msg)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Json.Decode as Decode
view : Model -> Html Msg
view model =
    div [] [ 
        h2 [ class "title has-text-centered" ] [ text model.response ]
        , inputField "number" "Weight" (toString model.parcel.weight) Msg.Weight
        , inputField "text" "Firstname" model.parcel.receipient.firstName Msg.FirstName
        , inputField "text" "Lastname" model.parcel.receipient.lastName Msg.LastName
        , inputField "text" "Street" model.parcel.receipient.street Msg.Street
        , inputField "text" "Postal code"model.parcel.receipient.postalCode Msg.PostalCode
        , inputField "text" "City" model.parcel.receipient.city Msg.City
        , button [ class "button is-success is-outlined", onClick Msg.PostParcel ] [ text "Post Parcel" ]
    ]

inputField : String -> String -> String -> (String -> Msg) -> Html Msg
inputField inputType placeholdr val msg =
    div [ class "field" ] [
        div [ class "control" ] [
            input [ class "input", type_ inputType, value val, onInput msg, placeholder placeholdr ] []
        ]
    ]

onChange : (String -> msg) -> Attribute msg
onChange msgCreator =
    Html.Events.on "change" (Decode.map msgCreator Html.Events.targetValue)
