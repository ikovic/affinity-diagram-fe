module Update exposing (update)

import Html5.DragDrop as DragDrop
import Msg exposing (Msg)
import Model exposing (Model)
import Models.Bucket exposing (Bucket)
import Models.Issue exposing (Issue)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.AddBucket previousBucket ->
            ( addBucket model previousBucket, Cmd.none )

        Msg.RemoveBucket bucket ->
            ( removeBucket model bucket, Cmd.none )

        Msg.DragDropMsg msg_ ->
            let
                ( model_, result ) =
                    DragDrop.update msg_ model.dragDrop
            in
                ( { model
                    | dragDrop = model_
                    , buckets =
                        case result of
                            Nothing ->
                                model.buckets

                            Just ( issue, bucket ) ->
                                addIssueToBucket model issue bucket
                    , issues =
                        case result of
                            Nothing ->
                                model.issues

                            Just ( issue, bucket ) ->
                                removeIssueFromIssueList model issue bucket
                  }
                , Cmd.none
                )


addBucket : Model -> Bucket -> Model
addBucket model previousBucket =
    { model
        | buckets =
            List.foldl
                (\bucket a ->
                    if bucket.id == previousBucket.id then
                        a ++ [ previousBucket, Bucket (toString (List.length a + 1)) "new" 0 [] ]
                    else
                        a ++ [ bucket ]
                )
                []
                model.buckets
    }


removeBucket : Model -> Bucket -> Model
removeBucket model bucket =
    { model
        | buckets = List.filter (\b -> b.id /= bucket.id) model.buckets
    }


addIssueToBucket : Model -> Issue -> Bucket -> List Bucket
addIssueToBucket model issue bucket =
    if isDropValid bucket.issues issue /= True then
        model.buckets
    else
        List.map
            (\b ->
                if bucket.id == b.id then
                    { b | issues = b.issues ++ [ issue ] }
                else
                    b
            )
            model.buckets


removeIssueFromIssueList : Model -> Issue -> Bucket -> List Issue
removeIssueFromIssueList model issue bucket =
    if isDropValid bucket.issues issue /= True then
        model.issues
    else
        List.filter (\i -> i.id /= issue.id) model.issues


isDropValid : List Issue -> Issue -> Bool
isDropValid issues issue =
    not (List.member issue issues)
