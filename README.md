# typst-diagbox
A library for diagonal line dividers in Typst tables; a.k.a.,
table cells with a diagonal line dividing them.

## Usage

Move the `diagbox.typ` file to e.g. the same folder
your main `.typ` file is in, then write
`#import "diagbox.typ": *` inside it.

This will import two functions:
`bdiagbox[left][right]` (for a diagonal from top-left
to bottom-right) and `tdiagbox[left][right]` (for a
diagonal line from bottom-left to top-right).

See sample usage in the `examples` folder.

![image](https://user-images.githubusercontent.com/9021226/227755001-a3a8b865-3de9-45be-869f-1ba755133f55.png)


## How it works

Using a simple box with a diagonal line across it won't work in
most cases, as `table`s come with an internal padding option
called `inset`; thus, no box would be able to occupy an entire
cell (there would always be some negative space around it).

Instead, the `bdiagbox` and `tdiagbox` functions take an `inset`
parameter (which defaults to `5pt`, the default for all tables,
but must be overridden if your table has a different value).
With that parameter, the diagonal line will exceed the box's
boundaries to compensate for the padding.

So, for example, if we consider a coordinate system with `(0, 0)`
as the inner box's top left corner, with `x` increasing to the right
and `y` increasing downwards, we would have, for `bdiagbox`
(a diagonal line going from top left to bottom right),
a line going from `(-inset, -inset)` to
`(inner_width + inset, inner_width + inset)`, where
`inner_width` is calculated (normally) by `width - 2*inset`
(where `width` is the column's total width, which the diagbox
should fully occupy).

This is why, if you place a diagbox outside of a table
without specifying `inset: 0pt`, with `box_stroke: 1pt`, you will
notice that the line "overflows" the box - this is necessary to
compensate for internal table padding.
