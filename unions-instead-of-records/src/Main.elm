module Main exposing (..)

{-| This module demonstrates some of the trade-offs in each approach from a
consumer's point of view.
-}

import Html exposing (Html)
import Html.App
import RecordBasedModule
import UnionBasedModule


{-| Our main model consists of two submodels: one from the record based
approach and one from the union based approach.
-}
type alias Model =
    { recordBasedModel : RecordBasedModule.PublicType
    , unionBasedModule : UnionBasedModule.PublicType
    }


{-| Just a dummy Msg type, nothing to special.
-}
type Msg
    = NoOp


{-| Our view will render each of the two models. Since the union based model
exposes far less implementation detail, we have a lot less flexibility about
how to render it, but we also do a lot less work.

We have full visibility into the record based model on the other hand, so we
can render that however we want.
-}
view : Model -> Html a
view model =
    Html.div []
        [ Html.h1 [] [ Html.text "Render of the union based model" ]
        , Html.p []
            [ UnionBasedModule.view model.unionBasedModule
            ]
        , Html.h1 [] [ Html.text "Render of the record based model" ]
        , Html.p []
            [ Html.text (model.recordBasedModel.firstName ++ " " ++ model.recordBasedModel.lastName)
            ]
        ]


{-| Our model init has a similar story to our view. Since we know nothing about
the union based model, we depend on it for creating empty instances, which
means less work for this module and less options.

We do whatever we want with the record though, just like in view.
-}
init : Model
init =
    { unionBasedModule =
        UnionBasedModule.empty
            |> UnionBasedModule.firstName "Anthony"
            |> UnionBasedModule.lastName "Naddeo"
    , recordBasedModel = { firstName = "Anthony", lastName = "Naddeo" }
    }


update : Msg -> Model -> Model
update msg model =
    model


main =
    Html.App.beginnerProgram
        { model = init
        , view = view
        , update = update
        }
