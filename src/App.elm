module App exposing (..)

import Html exposing (section, div, text)
import Html.Attributes exposing (class)
import Views.Header as Header


main : Html.Html msg
main =
    div []
        [ Header.view
        , section [ class "section" ]
            [ div [ class "container" ]
                [ div [ class "columns" ]
                    [ div [ class "column is-one-quarter hero is-fullheight" ]
                        [ text "is-one-quarter" ]
                    , div [ class "column hero is-fullheight" ]
                        [ text "Auto" ]
                    ]
                ]
            ]
        ]
