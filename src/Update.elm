module Update exposing (update)

import Array exposing (Array)
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

        Msg.RemoveBucket index ->
            ( removeBucket model index, Cmd.none )

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


addBucketAfterIndex : Array Bucket -> Int -> Array Bucket
addBucketAfterIndex buckets index =
    let
        wantedIndex =
            index + 1

        withNewBucket =
            buckets
                |> Array.slice 0 wantedIndex
                |> Array.push (Bucket "Bucket" 0 [])

        bucketsAfter =
            Array.slice wantedIndex (Array.length buckets) buckets
    in
        Array.append withNewBucket bucketsAfter


removeBucket : Model -> Int -> Model
removeBucket model index =
    let
        bucket =
            Array.get index model.buckets
    in
        case bucket of
            Nothing ->
                model

            Just foundBucket ->
                let
                    bucketsBefore =
                        Array.slice 0 index model.buckets

                    bucketsAfter =
                        Array.slice (index + 1) (Array.length model.buckets) model.buckets
                in
                    { model
                        | issues = model.issues ++ foundBucket.issues
                        , buckets = Array.append bucketsBefore bucketsAfter
                    }


addIssueToBucket : Model -> Issue -> Position -> Array Bucket
addIssueToBucket model issue position =
    case position of
        First ->
            let
                justNewBucket =
                    Array.empty
                        |> Array.push (Bucket "Bucket" 0 [ issue ])
            in
                Array.append justNewBucket model.buckets

        Last ->
            Array.push (Bucket "Bucket" 0 [ issue ]) model.buckets

        Index index ->
            Array.indexedMap
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
