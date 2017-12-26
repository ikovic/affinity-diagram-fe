module Views.Header exposing (view)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, href, id, placeholder, src, alt)


view : Html msg
view =
    nav [ attribute "aria-label" "main navigation", class "navbar has-shadow", attribute "role" "navigation" ]
        [ div [ class "container" ]
            [ div [ class "navbar-brand" ]
                [ a [ class "navbar-item", href "https://bulma.io" ]
                    [ img
                        [ alt "Bulma: a modern CSS framework based on Flexbox"
                        , attribute "height" "28"
                        , src "https://bulma.io/images/bulma-logo.png"
                        , attribute "width" "112"
                        ]
                        []
                    ]
                ]
            ]
        ]
