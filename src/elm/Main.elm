module Main exposing (..)

import Model exposing (Model)
import Msg exposing (Msg)
import Navigation exposing (..)
import View exposing (view)
import Update exposing (update)
import Router exposing (locFor, init)


main : Program Never Model Msg
main =
    Navigation.program locFor
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
