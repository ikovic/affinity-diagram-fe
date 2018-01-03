module Views.Buckets exposing (view)

import Array exposing (Array)
import Html5.DragDrop as DragDrop
import Models.Bucket exposing (Bucket)
import Models.Issue exposing (Issue)
import Html exposing (..)
import Html.Attributes exposing (attribute, class)
import Html.Events exposing (onClick)
import Views.Issues exposing (issueBox)
import Msg exposing (Msg, Position(..))


view : Array Bucket -> Html Msg
view buckets =
    div []
        ([ lockedLevel "First" First ]
            ++ Array.toList (Array.indexedMap bucketLevel buckets)
            ++ [ lockedLevel "Last" Last ]
        )


lockedLevel : String -> Position -> Html Msg
lockedLevel title position =
    div [ class "hero is-light bucket-container light-border--bottom" ]
        [ div [ class "hero-body bucket-body" ]
            [ div [ class "is-fullwidth" ]
                [ h5 [ class "title is-5" ]
                    [ text title ]
                , h6 [ class "subtitle is-6" ]
                    [ text "Drop issue here to create a new bucket" ]
                , div (class "bucket-holder margin-m--vertical" :: DragDrop.droppable Msg.DnDIssue position)
                    []
                ]
            ]
        ]


bucketLevel : Int -> Bucket -> Html Msg
bucketLevel index bucket =
    div [ class "hero bucket-container light-border--bottom" ]
        [ addBucket index
        , removeBucket index
        , div [ class "hero-body bucket-body" ]
            [ div [ class "is-fullwidth" ]
                [ h5 [ class "title is-5" ]
                    [ text bucket.label ]
                , h6 [ class "subtitle is-6" ]
                    [ text (toString bucket.points ++ " " ++ "SP") ]
                , div (class "bucket-holder margin-m--vertical" :: DragDrop.droppable Msg.DnDIssue (Index index))
                    (List.map issueInBucket bucket.issues)
                ]
            ]
        ]


addBucket : Int -> Html Msg
addBucket index =
    button [ class "add-bucket button is-primary is-rounded", onClick (Msg.AddBucket index) ]
        [ span [ class "icon" ]
            [ i [ class "fa fa-plus" ]
                []
            ]
        ]


removeBucket : Int -> Html Msg
removeBucket index =
    button [ class "remove-bucket button is-danger is-rounded", onClick (Msg.RemoveBucket index) ]
        [ span [ class "icon" ]
            [ i [ class "fa fa-minus" ]
                []
            ]
        ]


issueInBucket : Issue -> Html Msg
issueInBucket issue =
    issueBox issue
