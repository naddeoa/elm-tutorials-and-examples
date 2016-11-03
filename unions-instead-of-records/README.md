Comparing API Implementations: Exposing Union Types vs Exposing Records
===

This is a sample package that attempts to highlight some of the trade offs in
exposing raw records from a module as opposed to exposing opaque union types in
its place.  The implementation of the record based approach can be seen in
`RecordBasedModule.elm`, while the union based approach can be seen in
`UnionBasedModule.elm`. Finally, `Main.elm` contains some sample code that
consumes these two modules and highlights the differences from that point of
view.

## Advantages of exposing records
* Easy. You don't have to do a lot of work to whip up a record and declare
    fields with types.
* Flexible. Anyone can do whatever they want with it. It can be rendered in any
    way anyone wants to render it.

## Disadvantages of exposing records
* Implementation details leak out of the module and into every consumer.
* No ability to refactor modules without breaking consumers. If this module was
    a library then you would be forced to update your major version number if
    you wanted to change the name of a field in your record.


If we made the following change to our record based module, then we would
completely break everything.

```elm
type alias PublicType =
    { first: String -- renamed from firstName
    , last: String -- renamed from lastName
    }
```

We can't even change our types to `Maybe` without refactoring everything, which
also implies that we can't have anyone without a first or last name. This might
seem ok, but if you're writing an application that will one day be
internationalized then you'll quickly find out that there are many countries
that have very different naming schemes than english speaking ones. What would
you do at that point? Just use empty strings? You'll have to expand your test
coverage to ensure you don't put yourself into weird situations as well.

## Advantages of exposing only unions
* Ability to completely hide the implementation of your module and control how
    people interact with it.
* Can change any implementation detail at any point without breaking anyone.

## Disadvantages of exposing only unions
* Its more work upfront and it may require a bit more thought.
* Could be overkill.


This is one of those things that people tend to learn about and get carried away
with. I'll admit, that's what I'm doing in my personal life at the moment.
Trying to find a balance between options like these can be difficult in any
langauge. I think its just part of the experience of learning.

