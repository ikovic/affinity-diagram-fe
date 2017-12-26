module App exposing (..)

import Html exposing (Html, section, div, text, program)
import Html.Attributes exposing (class)
import Models.Issue exposing (Issue)
import Views.Header as Header
import Views.Issues as Issues


-- MODEL --


type alias Model =
    { issues : List Issue }


init : ( Model, Cmd Msg )
init =
    ( { issues =
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
      }
    , Cmd.none
    )


type Msg
    = NoOp



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Header.view
        , section [ class "section" ]
            [ div [ class "container" ]
                [ div [ class "columns" ]
                    [ div [ class "column is-one-quarter hero is-fullheight" ]
                        [ Issues.view model.issues ]
                    , div [ class "column hero is-fullheight" ]
                        [ text "Auto" ]
                    ]
                ]
            ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



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
