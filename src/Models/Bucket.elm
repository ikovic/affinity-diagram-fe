module Models.Bucket exposing (..)

import Models.Issue exposing (Issue)


type alias Bucket =
    { id : String
    , label : String
    , points : Int
    , issues : List Issue
    }
