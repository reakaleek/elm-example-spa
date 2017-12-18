module Parcel.Msg exposing (..)
import RemoteData exposing (WebData)
import Parcel.Model as Parcel exposing (Model)

type Msg 
    = OnPostResponse (WebData Parcel.TrackingId) 
    | PostParcel
    | Weight String
    | FirstName String
    | LastName String
    | Street String
    | PostalCode String
    | City String