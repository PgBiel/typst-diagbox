#import "../diagbox.typ": *

#let code(text) = rect(stroke: gray, width: 100%, {
    rect(fill: gray.lighten(80%), width: 100%, raw(text.trim().replace("\r", ""), lang: "typ", block: true))
    align(center, eval(text, mode: "markup", scope: (table_diagbox: table_diagbox, grid_diagbox: grid_diagbox)))
})

#show heading: it => {
    set text(weight: "regular", size: 11pt)
    it
}

= Using `auto` columns is very convenient when it is the largest cell in that column:

#code("
#table(
    columns: (auto, auto, auto),
        align: horizon + center,
        table_diagbox[Names][Properties], [*Can Walk*], [*Can Run*],
        [*Character A*], [Yes], [No],
        [*Character B*], [No], [No]
)
")

= This also work when the diagbox is not the largest cell:

#code("
#table(
    columns: (auto, auto, auto),
    align: horizon + center,
    table_diagbox[Names][Properties], [*Can Walk*], [*Can Run*],
    [*Long Long Long Character A*], [Yes], [No],
    [*Long Long Long Character B*], [No], [No]
)
")

= You can also have diagonal lines starting from the bottom, using `start: bottom`:

#code("
#let third_column_size = 5em;
#table(
    columns: (auto, auto, third_column_size),
    align: horizon + center,
    table_diagbox[Names][Properties], [*Can Walk*], [*Can Run*],
    [*Character A*], [Yes], [No],
    [*Character B*], [No], table_diagbox(start: bottom)[A][B]
)
")

= If your table has a custom `inset` (inner padding) property, make sure to pass it along:

#code("
#let third_column_size = 5em;
#let inset = 20pt;
#table(
    columns: (auto, auto, third_column_size),
    align: horizon + center,
    inset: inset,
    table_diagbox(inset: inset)[Names][Properties], [*Can Walk*], [*Can Run*],
    [*Character A*], [Yes], [No],
    [*Character B*], [No], table_diagbox(inset: inset, start: bottom)[A][B]
)
")

= You may specify a standalone (table-less) diagbox by wrapping it in a simple grid

#code("
#grid(grid_diagbox[Part A][Part B])
")

= Additionally, all the parameters which can be used on `grid.cell` are supported. The stroke parameter can be used to customize the diagonal line with the `diag` key:

#code("
#grid(
    grid_diagbox(stroke: (diag: yellow + 2pt, rest: teal + 3pt))[Part A][Part B])
")
