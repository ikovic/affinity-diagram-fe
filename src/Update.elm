module Update exposing (update)

import Html5.DragDrop as DragDrop
import Msg exposing (Msg, Position(..))
import Model exposing (Model)
import Models.Bucket exposing (Bucket)
import Models.Issue exposing (Issue)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.AddBucket index ->
            ( { model | buckets = addBucketAfterIndex model.buckets index }, Cmd.none )

        Msg.RemoveBucket bucket ->
            ( removeBucket model bucket, Cmd.none )

        Msg.DnDIssue msg_ ->
            let
                ( model_, result ) =
                    DragDrop.update msg_ model.dragDrop

                ( buckets, issues ) =
                    case result of
                        Nothing ->
                            ( model.buckets, model.issues )

                        Just ( issue, position ) ->
                            ( addIssueToBucket model issue position, removeIssueFromIssueList model issue )
            in
                ( { model
                    | dragDrop = model_
                    , buckets = buckets
                    , issues = issues
                  }
                , Cmd.none
                )

        Msg.LoadIssues (Ok loadedIssues) ->
            ( { model | issues = loadedIssues }, Cmd.none )

        Msg.LoadIssues (Err thingy) ->
            ( model, Cmd.none )


addBucketAfterIndex : List Bucket -> Int -> List Bucket
addBucketAfterIndex buckets index =
    let
        bucketsBefore =
            List.take (index + 1) buckets

        bucketsAfter =
            List.drop (index + 1) buckets
    in
        bucketsBefore ++ [ Bucket "123" "new" 0 [] ] ++ bucketsAfter


removeBucket : Model -> Bucket -> Model
removeBucket model bucket =
    { model
        | issues = model.issues ++ bucket.issues
        , buckets = List.filter (\b -> b.id /= bucket.id) model.buckets
    }


addIssueToBucket : Model -> Issue -> Position -> List Bucket
addIssueToBucket model issue position =
    case position of
        First ->
            [ Bucket "123" "new" 0 [ issue ] ] ++ model.buckets

        Last ->
            model.buckets ++ [ Bucket "123" "new" 0 [ issue ] ]

        Index index ->
            List.indexedMap
                (\idx b ->
                    let
                        found =
                            idx == index

                        validDrop =
                            isDropValid b.issues issue
                    in
                        if found && validDrop then
                            { b | issues = b.issues ++ [ issue ] }
                        else
                            b
                )
                model.buckets


removeIssueFromIssueList : Model -> Issue -> List Issue
removeIssueFromIssueList model issue =
    List.filter (\i -> i.id /= issue.id) model.issues


isDropValid : List Issue -> Issue -> Bool
isDropValid issues issue =
    not (List.member issue issues)
