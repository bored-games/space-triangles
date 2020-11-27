module Main exposing (..)

-- Press buttons to increment and decrement a counter.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/buttons.html
--

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class, id, style, type_)
import Html.Events exposing (onClick)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Player =
    { name : String
    , isTurn : Bool
    }


type Color
    = Red
    | Blue
    | Green
    | Yellow


type Size
    = Small
    | Medium
    | Large


type State
    = Planet
    | Ship
    | InBank


type alias Triangle =
    { color : String, size : Size, state : State }


type alias TriangleType =
    { small : List Triangle
    , medium : List Triangle
    , large : List Triangle
    }


type alias Board =
    { pieces : List TriangleType }


type alias Model =
    { turn : Int
    , player1 : Player
    , player2 : Player
    }


init : Model
init =
    Model 1 (Player "person1" True) (Player "person2" False)



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model
                | turn = model.turn + 1
                , player1 = updatePlayerTurn model.player1
                , player2 = updatePlayerTurn model.player2
            }

        Decrement ->
            { model | turn = model.turn - 1 }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ button [ onClick Increment ] [ text "Next turn" ]
        , div [] [ text ("Current turn " ++ String.fromInt model.turn ++ " (" ++ whoseTurn model ++ ")") ]
        , div [] [ button [ onClick Decrement ] [ text "Previous turn" ] ]
        ]


whoseTurn : Model -> String
whoseTurn model =
    if model.player1.isTurn then
        model.player1.name

    else
        model.player2.name


updatePlayerTurn : Player -> Player
updatePlayerTurn player =
    { player | isTurn = not player.isTurn }
