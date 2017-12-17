module Model exposing (..)
import Warehouse.Model as Warehouse exposing (Model)

type alias Model =
    { currentPage : Page
    , warehouse: Warehouse.Model
    }

type Page
    = Home
    | Login
    | About
    | Warehouse
