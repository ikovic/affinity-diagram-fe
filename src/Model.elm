module Model exposing (Model, initialModel)

import Html5.DragDrop as DragDrop
import Models.Issue exposing (Issue)
import Models.Bucket exposing (Bucket)


type alias Model =
    { issues : List Issue, buckets : List Bucket, dragDrop : DragDrop.Model Issue Bucket }


initialModel : Model
initialModel =
    { issues =
        []
    , buckets =
        [ { id = "123321"
          , label = "Start here"
          , points = 1
          , issues =
                []
          }
        ]
    , dragDrop = DragDrop.init
    }
