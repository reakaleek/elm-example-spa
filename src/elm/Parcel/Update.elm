module Parcel.Update exposing (..)
import Parcel.Model exposing (Model, TrackingId, Parcel)
import Parcel.Msg exposing (Msg)
import Parcel.Command exposing (postParcel)
import RemoteData exposing (WebData)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Parcel.Msg.PostParcel ->
            ({ model | isLoading = True }, postParcel model.parcel)
        Parcel.Msg.OnPostResponse response ->
            maybeTrackingId response { model | isLoading = False }
        Parcel.Msg.Weight weight ->
            ( model |> setWeight weight, Cmd.none)
        Parcel.Msg.FirstName firstName ->
            ( model |> setFirstName firstName, Cmd.none)
        Parcel.Msg.LastName lastName ->
            ( model |> setLastName lastName, Cmd.none)
        Parcel.Msg.Street street ->
            ( model |> setStreet street, Cmd.none)
        Parcel.Msg.City city ->
            ( model |> setCity city, Cmd.none)
        Parcel.Msg.PostalCode postalCode ->
            ( model |> setPostalCode postalCode, Cmd.none)

maybeTrackingId : WebData TrackingId -> Model -> (Model, Cmd Msg)
maybeTrackingId response model = 
    case response of
        RemoteData.NotAsked ->
            ({ model | response = "" }, Cmd.none)
        RemoteData.Loading ->
            ({ model | response = "Loading.."} , Cmd.none)
        RemoteData.Success response ->
            ({ model | response = response.trackingId }, Cmd.none)
        RemoteData.Failure error ->
            ({ model | response = (toString error) }, Cmd.none)


setWeight: String -> Model -> Model
setWeight value model =
    let
        oldParcel = model.parcel
        newWeight = Result.withDefault 0 (String.toFloat value)
        parcel = { oldParcel | weight = newWeight }
    in
        { model | parcel = parcel }

setFirstName : String -> Model -> Model
setFirstName firstname model =
    let 
        parcel = (model.parcel |> setFirstName1 firstname)
    in
        { model | parcel = parcel }

setFirstName1 : String -> Parcel -> Parcel
setFirstName1 firstName parcel =
    let
        oldReceipient = parcel.receipient
        receipient = { oldReceipient | firstName = firstName }
    in
        { parcel | receipient = receipient }

setLastName : String -> Model -> Model
setLastName lastName model =
    let 
        parcel = (model.parcel |> setLastName1 lastName)
    in
        { model | parcel = parcel }

setLastName1 : String -> Parcel -> Parcel
setLastName1 lastName parcel =
    let
        oldReceipient = parcel.receipient
        receipient = { oldReceipient | lastName = lastName }
    in
        { parcel | receipient = receipient }

setStreet : String -> Model -> Model
setStreet street model =
    let 
        parcel = (model.parcel |> setStreet1 street)
    in
        { model | parcel = parcel }

setStreet1 : String -> Parcel -> Parcel
setStreet1 street parcel =
    let
        oldReceipient = parcel.receipient
        receipient = { oldReceipient | street = street }
    in
        { parcel | receipient = receipient }

setPostalCode : String -> Model -> Model
setPostalCode postalCode model =
    let 
        parcel = (model.parcel |> setPostalCode1 postalCode)
    in
        { model | parcel = parcel }
        
setPostalCode1 : String -> Parcel -> Parcel
setPostalCode1 postalCode parcel =
    let
        oldReceipient = parcel.receipient
        receipient = { oldReceipient | postalCode = postalCode }
    in
        { parcel | receipient = receipient }


setCity : String -> Model -> Model
setCity city model =
    let 
        parcel = (model.parcel |> setCity1 city)
    in
        { model | parcel = parcel }

setCity1 : String -> Parcel -> Parcel
setCity1 city parcel =
    let
        oldReceipient = parcel.receipient
        receipient = { oldReceipient | city = city }
    in
        { parcel | receipient = receipient }
