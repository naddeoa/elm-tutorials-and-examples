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
