module App exposing (..)

import Html exposing (Html, section, div, text, program)
import Html.Attributes exposing (class)
import Model exposing (Model, initialModel)
import Msg exposing (Msg)
import Update exposing (update)
import Models.Issue exposing (Issue)
import Models.Bucket exposing (Bucket)
import Views.Header as Header
import Views.Issues as Issues
import Views.Buckets as Buckets


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Header.view
        , section [ class "section" ]
            [ div [ class "container" ]
                [ div [ class "columns" ]
                    [ div [ class "column is-one-quarter hero is-fullheight is-info" ]
                        [ Issues.view model.issues ]
                    , div [ class "column hero is-fullheight is-paddingless" ]
                        [ Buckets.view model.buckets ]
                    ]
                ]
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
