module Views.Issues exposing (view, issueBox)

import Html5.DragDrop as DragDrop
import Msg exposing (Msg)
import Models.Issue exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


view : List Issue -> Html Msg
view issues =
    div []
        (List.map issueBox issues)


issueBox : Issue -> Html Msg
issueBox issue =
    div (class "box issue-box" :: DragDrop.draggable Msg.DnDIssue issue)
        [ article [ class "media" ]
            [ div [ class "media-content" ]
                [ div [ class "content" ]
                    [ p []
                        [ strong []
                            [ text issue.key ]
                        , text (" " ++ issue.summary)
                        ]
                    ]
                ]
            ]
        ]
