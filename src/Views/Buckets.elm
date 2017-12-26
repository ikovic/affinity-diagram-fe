module Views.Buckets exposing (view)

import Models.Bucket exposing (Bucket)
import Models.Issue exposing (Issue)
import Html exposing (..)
import Html.Attributes exposing (attribute, class)
import Views.Issues exposing (issueBox)


view : List Bucket -> Html msg
view buckets =
    div []
        ([ lockedLevel "First" ]
            ++ (List.map bucketLevel buckets)
            ++ [ lockedLevel "Last" ]
        )


lockedLevel : String -> Html msg
lockedLevel label =
    div [ class "hero is-light bucket-container" ]
        [ div [ class "hero-body bucket-body" ]
            [ div [ class "is-fullwidth light-border--bottom padding-l--bottom" ]
                [ h5 [ class "title is-5" ]
                    [ text label ]
                , h6 [ class "subtitle is-6" ]
                    [ text "Drop issue here to create a new row" ]
                ]
            ]
        ]


bucketLevel : Bucket -> Html msg
bucketLevel bucket =
    div [ class "hero bucket-container" ]
        [ addBucket
        , removeBucket
        , div [ class "hero-body bucket-body" ]
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


addBucket : Html msg
addBucket =
    button [ class "add-bucket button is-primary is-rounded" ]
        [ span [ class "icon" ]
            [ i [ class "fa fa-plus" ]
                []
            ]
        ]


removeBucket : Html msg
removeBucket =
    button [ class "remove-bucket button is-danger is-rounded" ]
        [ span [ class "icon" ]
            [ i [ class "fa fa-minus" ]
                []
            ]
        ]


issueInBucket : Issue -> Html msg
issueInBucket issue =
    div [ class "level-item" ]
        [ issueBox issue ]
