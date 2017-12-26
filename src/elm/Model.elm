module Model exposing (..)
import Warehouse.Model as Warehouse exposing (Model)
import Parcel.Model as Parcel exposing (Model)
import Tracking.Model as Tracking exposing (Model)

type alias Model =
    { currentPage : Page
    , warehouse: Warehouse.Model
    , parcel: Parcel.Model
    , tracking: Tracking.Model
    }

type Page
    = TrackingInformation
    | ReportParcel
    | Parcel
    | Warehouse