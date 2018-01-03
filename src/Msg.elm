module Msg exposing (..)

import Http
import Html5.DragDrop as DragDrop
import Models.Issue exposing (Issue)


type Position
    = First
    | Last
    | Index Int


type Msg
    = AddBucket Int
    | RemoveBucket Int
    | DnDIssue (DragDrop.Msg Issue Position)
    | LoadIssues (Result Http.Error (List Issue))
