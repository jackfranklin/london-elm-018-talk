module Main exposing (..)

import Html exposing (text)
import Json.Decode as Decode
import Result


type alias User =
    { name : String
    , company : String
    , loves : List String
    }


someJson =
    """
    {
        "name": "Jack",
        "company": "Songkick",
        "loves": ["elm"]
    }
    """


userDecoder : Decode.Decoder User
userDecoder =
    Decode.map3 User
        (Decode.field "name" Decode.string)
        (Decode.field "company" Decode.string)
        (Decode.field "loves" (Decode.list Decode.string))



-- in 0.17
-- Decode.object3 User
--     ("name" := Decode.string)
--     ("company" :=  Decode.string)
--     ("loves" := (Decode.list Decode.string))


decodeJson : String -> Result String User
decodeJson =
    Decode.decodeString userDecoder


main =
    someJson
        |> decodeJson
        |> toString
        |> text
