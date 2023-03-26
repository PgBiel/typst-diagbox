# typst-diagbox
A library for diagonal boxes in Typst tables

## Usage

Move the `diagbox.typ` file to e.g. the same folder
your main `.typ` file is in, then write
`#import "diagbox.typ": *` inside it.

This will import two functions:
`bdiagbox[left][right]` (for a diagonal from top-left
to bottom-right) and `tdiagbox[left][right]` (for a
diagonal line from bottom-left to top-right).

See sample usage in the `examples` folder.
