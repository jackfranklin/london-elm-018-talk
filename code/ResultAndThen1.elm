module Main exposing (..)

import Html exposing (text)
import Result


double x =
    Ok (x * 2)


convertStringToYear str =
    String.toInt str
        |> Result.andThen (\x -> double x)


main =
    text <| toString <| (convertStringToYear "1234")
