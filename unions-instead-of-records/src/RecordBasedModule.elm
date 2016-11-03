module RecordBasedModule exposing (PublicType)

{-| This module does very little in and of itself. It defines the data shape that we care about and offers a sample `view` method.
-}

import Html exposing (Html)


type alias PublicType =
    { firstName : String
    , lastName : String
    }


view : PublicType -> Html a
view publicType =
    Html.text publicType.firstName
