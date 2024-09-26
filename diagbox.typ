/**
 * A diagonal box going from top left to bottom right. (The right-most position determines the prefix.)
 * Note: If using this outside of a table, setting inset to '0pt' is recommended.
 *
 * 'text_left' is the text that appears at the bottom left;
 * 'text_right', at the top right;
 * 'width' is the total width the diag box should span. Specify the table's column width
 * in this option;
 * 'inset' is the inset (inner cell padding) of the table - defaults to 5pt (just like tables do). Set
 * this to 0pt if not inside a table;
 * 'text_pad' is the general inner padding applied to text, which makes it move more 'inside'. It is used,
 * with negative values, to 'counter' a table's inner padding (inset). By default, it follows the
 * formula '-2 * inset/3 + 3pt', which covers both low insets (with the 3pt) and
 * high insets (due to '-2 * inset/3'). Setting this option shouldn't normally be necessary.
 * 'box_stroke' optionally gives a border to the box (e.g., if outside a table) - defaults to 'none'
 * (uses the table's cell rendering), but you may write, e.g., `teal + 1pt`, `yellow`, `3pt` etc.
 * 'line_stroke' optionally controls the diagonal line's color and stroke size, with, for example,
 * `yellow + 2pt`, `blue`, `3pt` etc. Defaults to `1pt`.
 *
 * Additional options:
 * 'inner_width' overrides width calculation of the inner box (the width of the diagbox,
 * not considering the table's 'inset' padding). The default formula for inner width is
 * 'width - 2*inset', if column width is specified; otherwise, it simply measures the width
 * of the given texts: '2*calc.max(left, right)'. You shouldn't generally need to change this
 * option.
 * 'left_sep', 'right_sep' define the distance of the bottom left and top right texts to their nearest
 * respective vertical borders (they move those texts horizontally, away from the nearest border) -
 * they default to 0pt, and may be negative to move in the opposite direction;
 * 'left_outer_sep', 'right_outer_sep' define where the diagonal line starts and ends, respectively.
 * They move each end of the line horizontally, away from the nearest vertical border, and may
 * be negative.
 */
#let bdiagbox(
  text_left, text_right,
  width: none, height: none,
  inset: 5pt, text_pad: none,
  box_stroke: none, line_stroke: 1pt,
  inner_width: none,
  left_sep: 0pt, right_sep: 0pt,
  left_outer_sep: 0pt, right_outer_sep: 0pt,
) = context {
  let left_measure = measure(text_left)
  let right_measure = measure(text_right)

  let text_pad = if text_pad == none {
    // some adjusting; sum 3pt for the base case (5pt)
    // for larger insets, it isn't very relevant
    -2*inset/3 + 3pt
  } else {
    text_pad
  }
  
  let height = if height != none {
    height
  } else {
    2*(left_measure.height + right_measure.height)
  }

  let inner_width = if inner_width != none {
    inner_width
  } else if width != none {
    width - 2*inset
  } else {
    2*calc.max(left_measure.width, right_measure.width)
  }
  
  box(width: inner_width, height: height, stroke: box_stroke)[
    #show line: place.with(top + left)
    #place(top + right, move(dx: -right_sep - text_pad, dy: text_pad, text_right))
    #line(start: (left_outer_sep - inset, -inset), end: (inner_width + inset - right_outer_sep, height + inset), stroke: line_stroke)
    #place(bottom + left, move(dx: left_sep + text_pad, dy: -text_pad, text_left))
  ]
}

/**
 * Same as 'bdiagbox', but with the line going from bottom left to top right. Thus,
 * 'text_left' goes on the top left, while 'text_right' goes on the top right,
 * and the corresponding options affect the equivalent parameters (left -> `text_left`,
 * right -> `text_right`).
 */
#let tdiagbox(
  text_left, text_right,
  width: none, height: none,
  inset: 5pt, text_pad: none,
  box_stroke: none, line_stroke: 1pt,
  inner_width: none,
  left_sep: 0pt, right_sep: 0pt,
  left_outer_sep: 0pt, right_outer_sep: 0pt,
) = context {
  let left_measure = measure(text_left)
  let right_measure = measure(text_right)

  let text_pad = if text_pad == none {
    // some adjusting; sum 3pt for the base case (5pt)
    // for larger insets, it isn't very relevant
    -2*inset/3 + 3pt
  } else {
    text_pad
  }
  
  let height = if height != none {
    height
  } else {
    2*(left_measure.height + right_measure.height)
  }

  let inner_width = if inner_width != none {
    inner_width
  } else if width != none {
    width - 2*inset
  } else {
    2*calc.max(left_measure.width, right_measure.width)
  }

  box(width: inner_width, height: height, stroke: box_stroke)[
    #show line: place.with(top + left)
    #place(top + left, move(dx: left_sep + text_pad, dy: text_pad, text_left))
    #line(start: (left_outer_sep - inset, height + inset), end: (inner_width + inset - right_outer_sep, -inset), stroke: line_stroke)
    #place(bottom + right, move(dx: -right_sep - text_pad, dy: -text_pad, text_right))
  ]
}

// TODO: Add function for two diagonal lines (for a third text option, in the middle).
