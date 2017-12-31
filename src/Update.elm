module Update exposing (update)

import Random
import Html5.DragDrop as DragDrop
import Msg exposing (Msg)
import Model exposing (Model)
import Models.Bucket exposing (Bucket)
import Models.Issue exposing (Issue)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.AddBucket previousBucket ->
            ( model, Random.generate (Msg.SaveBucket previousBucket) (Random.int 1 100000) )

        Msg.SaveBucket bucket id ->
            ( addBucket model bucket id, Cmd.none )

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

        Msg.LoadIssues (Ok loadedIssues) ->
            ( { model | issues = loadedIssues }, Cmd.none )

        Msg.LoadIssues (Err thingy) ->
            ( model, Cmd.none )


addBucket : Model -> Bucket -> Int -> Model
addBucket model previousBucket id =
    { model
        | buckets =
            List.foldl
                (\bucket a ->
                    if bucket.id == previousBucket.id then
                        a ++ [ previousBucket, Bucket (toString id) "new" 0 [] ]
                    else
                        a ++ [ bucket ]
                )
                []
                model.buckets
    }


removeBucket : Model -> Bucket -> Model
removeBucket model bucket =
    { model
        | issues = model.issues ++ bucket.issues
        , buckets = List.filter (\b -> b.id /= bucket.id) model.buckets
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
