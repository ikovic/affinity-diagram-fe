module Views.Buckets exposing (view)

import Html5.DragDrop as DragDrop
import Models.Bucket exposing (Bucket)
import Models.Issue exposing (Issue)
import Html exposing (..)
import Html.Attributes exposing (attribute, class)
import Html.Events exposing (onClick)
import Views.Issues exposing (issueBox)
import Msg exposing (Msg)


view : List Bucket -> Html Msg
view buckets =
    div []
        ([ lockedLevel "First" ]
            ++ (List.map bucketLevel buckets)
            ++ [ lockedLevel "Last" ]
        )


lockedLevel : String -> Html msg
lockedLevel label =
    div [ class "hero is-light bucket-container light-border--bottom" ]
        [ div [ class "hero-body bucket-body" ]
            [ div [ class "is-fullwidth padding-l--bottom" ]
                [ h5 [ class "title is-5" ]
                    [ text label ]
                , h6 [ class "subtitle is-6" ]
                    [ text "Drop issue here to create a new row" ]
                ]
            ]
        ]


bucketLevel : Bucket -> Html Msg
bucketLevel bucket =
    div [ class "hero bucket-container light-border--bottom" ]
        [ addBucket bucket
        , removeBucket bucket
        , div [ class "hero-body bucket-body" ]
            [ div [ class "is-fullwidth" ]
                [ h5 [ class "title is-5" ]
                    [ text bucket.label ]
                , h6 [ class "subtitle is-6" ]
                    [ text (toString bucket.points ++ " " ++ "SP") ]
                , div (class "level margin-m--vertical" :: DragDrop.droppable Msg.DragDropMsg bucket)
                    (List.map issueInBucket bucket.issues)
                ]
            ]
        ]


addBucket : Bucket -> Html Msg
addBucket previousBucket =
    let
        message =
            Msg.AddBucket previousBucket
    in
        button [ class "add-bucket button is-primary is-rounded", onClick message ]
            [ span [ class "icon" ]
                [ i [ class "fa fa-plus" ]
                    []
                ]
            ]


removeBucket : Bucket -> Html Msg
removeBucket bucket =
    let
        message =
            Msg.RemoveBucket bucket
    in
        button [ class "remove-bucket button is-danger is-rounded", onClick message ]
            [ span [ class "icon" ]
                [ i [ class "fa fa-minus" ]
                    []
                ]
            ]


issueInBucket : Issue -> Html Msg
issueInBucket issue =
    div [ class "level-item" ]
        [ issueBox issue ]
