module Msg exposing (..)

import Models.Bucket exposing (Bucket)


type Msg
    = AddBucket Bucket
    | RemoveBucket Bucket
