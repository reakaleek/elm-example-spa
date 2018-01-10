module Model exposing (..)

import Warehouse.Model as Warehouse exposing (Model)
import Parcel.Model as Parcel exposing (Model)
import Tracking.Model as Tracking exposing (Model)
import ReportParcel.Model as ReportParcel exposing (Model)


type alias Model =
    { currentPage : Page
    , warehouse : Warehouse.Model
    , parcel : Parcel.Model
    , tracking : Tracking.Model
    , reportParcel : ReportParcel.Model
    }


type Page
    = TrackingInformation
    | ReportParcel
    | Parcel
    | Warehouse


initModel : Page -> Model
initModel page =
    Model page Warehouse.initModel Parcel.initModel Tracking.initModel ReportParcel.initModel
