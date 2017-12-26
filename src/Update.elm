module Update exposing (update)

import Msg exposing (Msg)
import Model exposing (Model)
import Models.Bucket exposing (Bucket)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg.AddBucket previousBucket ->
            ( addBucket model previousBucket, Cmd.none )


addBucket : Model -> Bucket -> Model
addBucket model previousBucket =
    model
