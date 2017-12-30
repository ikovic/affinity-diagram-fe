module Api.Client exposing (..)

import Http
import Json.Decode as Decode exposing (list, map5, string, field)
import Models.Issue exposing (Issue)
import Msg exposing (Msg)


getIssues : Http.Request (List Issue)
getIssues =
    Http.get "http://localhost:8080/backlog/1" decodeIssues


type alias Metadata =
    { author : String
    , pages : Int
    }


decodeIssues : Decode.Decoder (List Issue)
decodeIssues =
    Decode.list decodeIssue


decodeIssue : Decode.Decoder Issue
decodeIssue =
    map5 Issue
        (Decode.field "url" string)
        (Decode.field "key" string)
        (Decode.field "id" string)
        (Decode.field "summary" string)
        (Decode.field "description" string)


send : Cmd Msg
send =
    Http.send Msg.LoadIssues getIssues
