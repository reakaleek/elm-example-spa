module ReportPacel.Update exposing (..)
import ReportParcel.Model exposing (Model, ReportParcel)
import ReportParcel.Msg exposing (Msg)
import ReportParcel.Command exposing (postReportParcel)
import RemoteData exposing (WebData)

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of 
        ReportParcel.Msg.PostReportParcel ->
            ({ model | isLoading = True }, postReportParcel model.reportparcel)
        ReportParcel.Msg.OnPostResponse ->
            maybeSuccess response { model | isLoading = False }
        ReportParcel.Msg.TrackingId trackingId ->
            (model |> setTrackingId trackingId, Cmd.none)
        ReportParcel.Msg.TrackingCode trackingCode ->
            (model |> setTrackingCode trackingCode, Cmd.none)

maybeSuccess: WebData String -> Model -> (Model, Cmd Msg)
maybeSuccess response model = 
    case response of 
        RemoteData.NotASked ->
            ({ model | response = "" }, Cmd.none)
        RemoteData.Loading ->
            ({ model | response = "Loading .."}, Cmd.none)
        RemoteData.Success response ->
            ({ model | response = "Successfully reported Parcel"}, Cmd.none)
        RemoteData.Failure error ->
            ({ model | response = (toString error)}, Cmd.none)


setTrackingId: String -> Model -> Model
setTrackingId value model = 
    let 
        oldReportParcel = model.reportParcel
        newTrackingId = value
        reportParcel = { oldReportParcel | trackingId = newTrackingId }
    in
        { model | reportparcel = reportparcel }

        