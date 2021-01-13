# XUMLIDOT

A Ruby UML XMI and DOT generator

## VERSION 0.1.0

- xmi and dot output works quite nicely (see examples folder), however there are still a few buggy cases.
- works with any ruby project (will break on broken code though)
- works with rails but doesn't add the model attributes (yet)
- can parse rails itself so *should* work on your project - please let me know if it doesn't.
- pretty comprehensive output but missing delegation (TODO), dynamic methods, etc. etc.

Why?

The main reason for this is that I am a fan of Model Driven Engineering and
whilst there are *great* tools like Railroady and Xamin out there, the focus on
Rails makes them less useful than I personally would like since Ruby != Rails. Also
Railroady has never had a working xmi option meaning that we can't import the output
into tools such as Visual Paradigm - one of my primary use cases (although being able
to output wall spanning class diagrams is *cool*).

In addition, one of the major problems (IMO) with the approach taken by other
tools is that they `require` files hence you need a project with all the
dependencies set up and working; fine most of the time but I've come across
more than one project so environment dependent that even the specs would not
run without vagrant or docker.  I want a tool where I can **quickly** get a high
level view of the code from an Object Oriented perspective.

Hence xumlidot ...

## INSTALLATION

```
gem install xumlidot
```

## USAGE

    xumlidot OPTIONS dir_a dir_b dir_c ...

xumlidot basically expects multiple directories from which it will create the
dot/xmi output. You can of course just point at an entire project but I've found
it useful to exclude tests/specs, and in a rails project, you don't _really_ want
the migrations so I tend to use something like `xumlidot --xmi app lib` for a
more focused model.

## USE CASES

Often I will come into a project and want a high level overview of things. My go to
tool was Railroady but this is only of use for Rails projects - now I use xumlidot.

I found myself this week having performed a refactor on a piece of code, creating a
common interface and splitting out classes to adhere to SRP. From there I wanted to
add in some PoC error handling (combining retrys and circuit breakers). I was able
to easiliy generate a diagram of the refactored code, import it into Visual Paradigm,
and then use the model to explore the functionality I wanted to add. (Its always nice
when you make a tool and then find it works!)

## OPTIONS

  --title
  Provides a title to use for the diagram

  --model
  Provides a name for the model

  --dot
  Output diagram using dot

  --xmi
  Output diagram using xmi

  --puml
  Output diagram using plantuml syntax (TODO; low on my list)

  --yuml
  Output diagram using yuml syntax (TODO; very low on my list)

  --debug
  Output (possibly too much) debug info.

  --exclude
  Exclude directories or filenames matching string or pattern

  --no-inheritance
  Dont output inheritence links

  --no-composition
  Dont output composition links

  --no-uses
  (TODO: totally, incorporate include/extend as inheritence)

  --rails
  (TODO: Gets additional rails knowledge such as model attributes)

  --split=n
  (TODO: Split into n diagrams where there are distinct class
  clusters)

  --sequence=CLASS.method_name (TODO: Sequence diagram output starting with )

  --no-consolodate (TODO: Use only a single path between each class - is now
  the default in order to reduce the number of paths that have to be drawn)


## EXAMPLE

```
  xumlidot --xmi --title="My Class Diagram" app lib
```

Should produce a reasonable complete class diagram for a rails project - you *may* need to do seperate
diagrams for different areas if you hit some limits in e.g. VP.

![Xumlidot inceptin itself](examples_output/xumlidot.png)

The above is a demostration image produced from importing into VisualParadigm
the xmi output of xumlidot graphing itself.  ## MAKIN PRETTy

### Graphviz
Have a look at examples_output/README.md for a couple of examples using dot. dot is beyond the
scope of documenting here do please look at https://graphviz.org/ for further info.

#### Visual Paradigm
I'm still playing with VP and hope to add some tips of how to obtain the best results at somepoint.

## DEPENDENCIES

You will need graphviz installed in order to parse the dot output.

## DEVELOPMENT PLAN/TODO

- specs
- CHECK adding of single files
- fix ** bugs seen in some codebases (e.g. rails) (probably will be fixed as I work on specs)
- Add full namespace lookup - fixes 'dangling' classes
- fix the terrible traversal code
- fix the terrible XMI code
- Put the bits that Xamin and Railroady get right (i.e. Rails Integration) in.
- Sequence diagrams(!! not sure how viable but ...)

## COPYRIGHTS/ATTTRIBUTIONS/THANKS

- Thanks to the seattlerb group for the excellent ruby-parser and sexp-processor which got
me parsing ruby superfast.

- Thanks to preston for the excellent Railroady which has got me going with many projects.

- Thanks to Brian Lonsdorf for Xamin which I had initially hoped to just fork but ended up
using to just get an idea of the XMI structure.

- Thanks to MyMedsAndMe for the 10% time to work on this project.
