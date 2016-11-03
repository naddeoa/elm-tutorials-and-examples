module UnionBasedModule
    exposing
        ( PublicType
        , view
        , empty
        , firstName
        , lastName
        )

{-| This module provides the same functionality as RecordBasedModule, but it
doesn't actually expose any record type or implementation details.
-}

import Html exposing (Html)


{-| This is the main type that we are exporting. Since cwe don't export any of
the types that it defines we don't let anyone else know anything about it.
If we exposed nothing but PublicType, then everyone would be able to declare
functions that take public types, but they could'nt do anything that accessed
Model or its `.firstName`/`.lastName` fields.

I'm actually not sure when it is appropraite to use the single quote or not. It
doesn't mean anything special in terms of the language, but it does let you
visually distinguish identifiers. I'm using it here because it can get a little
confusing having a constructor with the same name as its type. At least now its
clear which one I'm referring to. If I was going to expose that constructor
then I definitely wouldn't do it. I don't want to make people use single quotes
in their code; it looks kind of funky to me.
-}
type PublicType
    = PublicType' Model


{-| This is where we store the data/state that we actually want to manage. We
don't expose this to anyone. Because of that, we have full freedom to change it
later on. In doing so, we also heavily restrict the ussage of PublicType.
Consumers can now only do what we let them.

In the end, it means we do more work in this module to create that
functionality, but we retain control over the type and how it can be used,
which lets us make a few more guarantees about our programs.
-}
type alias Model =
    { firstName : String
    , lastName : String
    }


{-| Since we don't expose Model, people have no way of getting instances of
one. We need to create functions that update Model based on PublicType
arguments. `empty` is a reasonable function to implement since people usually
create their own `init` functions when following the elm architecture anyway.

Since no one can see `Model`, we can do whatever we want here and not worry
about shooting outselves in the foot later. For now, we'll just put empty
strings inside of it. If it turns out that `firstName` and `lastName` should
actually be `Maybe`s, then we can just switch them and no one would have to
update a thing.
-}
empty : PublicType
empty =
    PublicType' (Model "" "")


{-| firstName and lastName are functions that we provide consumers that they
can use to set first and last names on `PublicType`. Whether or not we actually
want to provide this functionality depends on what our program is doing. The
pointhere is that people can only do what we allow them to do
-}
firstName : String -> PublicType -> PublicType
firstName name publicType =
    let
        model =
            getModel publicType
    in
        PublicType' { model | firstName = name }


{-| Same type of function as firstName.
-}
lastName : String -> PublicType -> PublicType
lastName name publicType =
    let
        model =
            getModel publicType
    in
        PublicType' { model | lastName = name }


{-| Another function that we don't expose. This is how we can pass
`PublicType`s around our application that are actually carrying `Model`s inside
of them. Using this function, we can get that model out and do stuff with it
within this module, but no one else can.
-}
getModel : PublicType -> Model
getModel publicType =
    case publicType of
        PublicType' model ->
            model


{-| We also provide a view function so that our type can be rendered. Just like
before, no one knows a thing about what is inside of `PublicType`, if we don't
give them a render method then it can't be rendered.
-}
view : PublicType -> Html a
view publicType =
    let
        model =
            getModel publicType
    in
        Html.text (model.firstName ++ " " ++ model.lastName)
