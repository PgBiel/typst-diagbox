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

![image](https://user-images.githubusercontent.com/9021226/227755001-a3a8b865-3de9-45be-869f-1ba755133f55.png)
