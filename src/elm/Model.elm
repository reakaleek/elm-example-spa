module Model exposing (..)
import Warehouse.Model as Warehouse exposing (Model)
import Parcel.Model as Parcel exposing (Model)
import ReportParcel.Model as ReportParcel exposing (Model)


type alias Model =
    { currentPage : Page
    , warehouse: Warehouse.Model
    , parcel: Parcel.Model
    , reportParcel: ReportParcel.Model
    }

type Page
    = TrackingInformation
    | ReportParcel
    | Parcel
    | Warehouse

