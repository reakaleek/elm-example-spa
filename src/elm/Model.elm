module Model exposing (..)
import Warehouse.Model as Warehouse exposing (Model)
import Parcel.Model as Parcel exposing (Model)


type alias Model =
    { currentPage : Page
    , warehouse: Warehouse.Model
    , parcel: Parcel.Model
    }

type Page
    = TrackingInformation
    | ReportParcel
    | Parcel
    | Warehouse
