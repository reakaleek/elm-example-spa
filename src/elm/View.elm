module View exposing (view)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Msg exposing (Msg)
import Model exposing (Model, Page)
import Warehouse.View exposing (view)

view : Model -> Html Msg
view model =
    div []
        [ renderMenu model
        , renderPage model
        ]


renderMenu : Model -> Html Msg
renderMenu model =
    div [ class "tabs" ]
        [ 
            ul [] [ li [ class (getActiveClass model.currentPage "Home") ] [ a [ onClick (Msg.LinkTo "#home") ] [ text "Home" ] ]
            , li [ class (getActiveClass model.currentPage "Login") ] [ a [ onClick (Msg.LinkTo "#login") ] [ text "Login" ] ]
            , li [ class (getActiveClass model.currentPage "About") ] [ a [ onClick (Msg.LinkTo "#about") ] [ text "About" ] ]
            , li [ class (getActiveClass model.currentPage "Warehouse") ] [ a [ onClick (Msg.LinkTo "#warehouse") ] [ text "Warehouse" ] ]
            ]
        ]

getActiveClass: Model.Page -> String -> String
getActiveClass page pageName =
    if (toString page) == pageName
    then  "is-active"
    else ""

renderPage : Model -> Html Msg
renderPage model =
    let
        page_content =
            case model.currentPage of
                Model.Home ->
                    text "Home"

                Model.Login ->
                    text "Login"

                Model.About ->
                    text "About"
                Model.Warehouse ->
                    Warehouse.View.view model.warehouse
                        |> Html.map Msg.WarehouseMsg
    in
        section [ class "section" ] [
            div [ class "container" ] [ page_content ]
        ]
