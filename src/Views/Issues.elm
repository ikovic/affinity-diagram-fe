module Views.Issues exposing (view)

import Models.Issue exposing (..)
import Html exposing (..)
import Html.Attributes exposing (attribute, class)


view : List Issue -> Html msg
view issues =
    div []
        (List.map issueBox issues)


issueBox : Issue -> Html msg
issueBox issue =
    div [ class "box" ]
        [ article [ class "media" ]
            [ div [ class "media-content" ]
                [ div [ class "content" ]
                    [ p []
                        [ strong []
                            [ text (issue.key ++ " " ++ issue.name) ]
                        ]
                    ]
                ]
            ]
        ]
