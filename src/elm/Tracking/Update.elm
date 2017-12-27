module Tracking.Update exposing (..)

import Tracking.Model as Model exposing (Model)
import Tracking.Msg as Msg exposing (Msg)
import Tracking.Command as Command exposing (getTrackingInformation)
import RemoteData exposing (WebData)
import Http exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.OnGetResponse response ->
            maybeTrackingInformation response { model | isLoading = False }

        Msg.GetTrackingInformation ->
            ( { model | isLoading = True }, getTrackingInformation model.trackingId )

        Msg.TrackingId trackingId ->
            ( { model | trackingId = trackingId }, Cmd.none )


maybeTrackingInformation : WebData Model.TrackingInformation -> Model -> ( Model, Cmd Msg )
maybeTrackingInformation response model =
    case response of
        RemoteData.NotAsked ->
            ( { model | errorResponse = "" }, Cmd.none )

        RemoteData.Loading ->
            ( { model | isLoading = True }, Cmd.none )

        RemoteData.Success response ->
            ( { model | trackingInformation = response, errorResponse = "" }, Cmd.none )

        RemoteData.Failure error ->
            ( { model | trackingInformation = (Model.TrackingInformation 0 [] []), errorResponse = (getErrorMsg error) }, Cmd.none )


getErrorMsg : Error -> String
getErrorMsg error =
    case error of
        Http.BadStatus response ->
            response.body

        _ ->
            "An error occured."
