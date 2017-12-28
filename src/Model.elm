module Model exposing (Model, initialModel)

import Html5.DragDrop as DragDrop
import Models.Issue exposing (Issue)
import Models.Bucket exposing (Bucket)


type alias Model =
    { issues : List Issue, buckets : List Bucket, dragDrop : DragDrop.Model Issue Bucket }


initialModel : Model
initialModel =
    { issues =
        [ { id = "1000"
          , key = "EX-01"
          , name = "Some Issue"
          , summary = "Issue description just a bit longer than name. Bad description!"
          }
        , { id = "1001"
          , key = "EX-02"
          , name = "Other Issue"
          , summary = "Issue description just a weenie bit longer than name. People never learn!"
          }
        ]
    , buckets =
        [ { id = "123321"
          , label = "Start here"
          , points = 1
          , issues =
                [ { id = "1001"
                  , key = "EX-02"
                  , name = "Other Issue"
                  , summary = "Issue description just a weenie bit longer than name. People never learn!"
                  }
                ]
          }
        ]
    , dragDrop = DragDrop.init
    }
