module ReportParcel.Update exposing (..)

import ReportParcel.Model exposing (Model, ReportParcel)
import ReportParcel.Msg exposing (Msg)
import ReportParcel.Command exposing (postReportParcel)
import RemoteData exposing (WebData)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReportParcel.Msg.PostReportParcel ->
            ( { model | isLoading = True }, postReportParcel model.reportParcel )

        ReportParcel.Msg.OnPostResponse response ->
            maybeSuccess response { model | isLoading = False }

        ReportParcel.Msg.TrackingId trackingId ->
            ( model |> setTrackingId trackingId, Cmd.none )

        ReportParcel.Msg.TrackingCode trackingCode ->
            ( model |> setTrackingCode trackingCode, Cmd.none )


maybeSuccess : WebData String -> Model -> ( Model, Cmd Msg )
maybeSuccess response model =
    case response of
        RemoteData.NotAsked ->
            ( { model | response = "" }, Cmd.none )

        RemoteData.Loading ->
            ( { model | response = "Loading .." }, Cmd.none )

        RemoteData.Success response ->
            ( { model | response = "Successfully reported Parcel" }, Cmd.none )

        RemoteData.Failure error ->
            ( { model | response = (toString error) }, Cmd.none )


setTrackingId : String -> Model -> Model
setTrackingId value model =
    let
        oldReportParcel =
            model.reportParcel

        newTrackingId =
            value

        reportParcel =
            { oldReportParcel | trackingId = newTrackingId }
    in
        { model | reportParcel = reportParcel }


setTrackingCode : String -> Model -> Model
setTrackingCode value model =
    let
        oldReportParcel =
            model.reportParcel

        newTrackingCode =
            value

        reportParcel =
            { oldReportParcel | trackingCode = newTrackingCode }
    in
        { model | reportParcel = reportParcel }
