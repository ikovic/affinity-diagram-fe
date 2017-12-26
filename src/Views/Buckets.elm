module Views.Buckets exposing (..)

import Models.Bucket exposing (Bucket)
import Models.Issue exposing (Issue)
import Html exposing (..)
import Html.Attributes exposing (attribute, class)
import Views.Issues exposing (issueBox)


view : List Bucket -> Html msg
view buckets =
    div []
        (List.map bucketLevel buckets)


bucketLevel : Bucket -> Html msg
bucketLevel bucket =
    div [ class "hero is-light" ]
        [ div [ class "hero-body bucket-body" ]
            [ div [ class "is-fullwidth light-border--bottom" ]
                [ h5 [ class "title is-5" ]
                    [ text bucket.label ]
                , h6 [ class "subtitle is-6" ]
                    [ text (toString bucket.points ++ " " ++ "SP") ]
                , div [ class "level margin-m--vertical" ]
                    (List.map issueInBucket bucket.issues)
                ]
            ]
        ]


issueInBucket : Issue -> Html msg
issueInBucket issue =
    div [ class "level-item" ]
        [ issueBox issue ]
