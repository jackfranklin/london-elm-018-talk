module Main exposing (..)

import Html exposing (text, Html, div, button, img)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode


type alias Model =
    { gif : Maybe String
    }


type Msg
    = FetchGif
    | NewGif (Result Http.Error String)


getDogGif : Cmd Msg
getDogGif =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=dogs"
    in
        Http.send NewGif (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string


init : ( Model, Cmd Msg )
init =
    ( Model Nothing, getDogGif )


renderGif : Maybe String -> Html Msg
renderGif gif =
    case gif of
        Just url ->
            img [ src url ] []

        Nothing ->
            text ""


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick FetchGif ] [ text "New dog pls" ]
        , renderGif model.gif
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchGif ->
            ( model, getDogGif )

        NewGif (Ok newUrl) ->
            ( Model (Just newUrl), Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
