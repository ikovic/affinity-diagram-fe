module Model exposing (Model, initialModel)

import Array exposing (Array)
import Html5.DragDrop as DragDrop
import Models.Issue exposing (Issue)
import Models.Bucket exposing (Bucket)
import Msg exposing (Position)


type alias Model =
    { issues : List Issue, buckets : Array Bucket, dragDrop : DragDrop.Model Issue Position }


initialModel : Model
initialModel =
    { issues =
        []
    , buckets =
        Array.fromList
            [ { id = "123321"
              , label = "Start here"
              , points = 1
              , issues =
                    []
              }
            ]
    , dragDrop = DragDrop.init
    }
