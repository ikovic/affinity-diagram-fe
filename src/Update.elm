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
