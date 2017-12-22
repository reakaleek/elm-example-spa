module Parcel.Msg exposing (..)
import RemoteData exposing (WebData)
import Parcel.Model as Model exposing (TrackingId)

type Msg 
    = OnPostResponse (WebData TrackingId) 
    | PostParcel
    | Weight String
    | FirstName String
    | LastName String
    | Street String
    | PostalCode String
    | City String