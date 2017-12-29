module Msg exposing (..)

import Http
import Html5.DragDrop as DragDrop
import Models.Bucket exposing (Bucket)
import Models.Issue exposing (Issue)


type Msg
    = AddBucket Bucket
    | RemoveBucket Bucket
    | DragDropMsg (DragDrop.Msg Issue Bucket)
    | LoadIssues (Result Http.Error (List Issue))
