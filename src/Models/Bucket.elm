module Models.Bucket exposing (..)

import Models.Issue exposing (Issue)


type alias Bucket =
    { label : String
    , points : Int
    , issues : List Issue
    }
