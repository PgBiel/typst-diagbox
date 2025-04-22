#let _diagbox(parent, text_left, text_right, start: top, inset: 0% + 5pt, stroke: 1pt + black, ..kwargs) = {
  
  let line_stroke = (:)
  let cell_stroke = (:)
  if (type(stroke) == dictionary) {
    for key in ("left", "top", "right", "bottom", "x", "y") {
      if key in stroke.keys() {
        cell_stroke.insert(key, stroke.at(key))
        _ = stroke.remove(key)
      }
    }
    if "diag" in stroke.keys() {
      line_stroke = stroke.at("diag")
      _ = stroke.remove("diag")
    }
    if "rest" in stroke.keys() {
      if line_stroke == (:) {
        line_stroke = stroke.at("rest")
      }
      cell_stroke.insert("rest", stroke.at("rest"))
      _ = stroke.remove("rest")
    }
  }
  if cell_stroke == (:) and line_stroke == (:) {
    cell_stroke = stroke
    line_stroke = stroke
  }
  else if stroke != (:) {
      panic("Unexpected key '" + stroke.keys().at(0) + "', valid keys are 'left', 'top', 'right', 'bottom', 'x', 'y', 'rest' and 'diag'")
  }
  
  let content = context {   
    
    let padded_right = pad(text_right, inset)
    let padded_left = pad(text_left, inset)

    let measure_right = measure(padded_right)
    let measure_left = measure(padded_left)

    // Used to account for big differences between text widths
    let width_diff = calc.abs(measure_right.width - measure_left.width)

    let inner_height = measure_right.height + measure_left.height + width_diff / 10
    let inner_width = measure_right.width + measure_left.width

    box(width: inner_width, height: inner_height) // Empty box to ensure minimal size

    if start == bottom {
      place(top + left, line(start: (0%, 100%), end: (100%, 0%), stroke: line_stroke))
    }
    else if start == top {
      place(top + left, line(start: (0%, 0%), end: (100%, 100%), stroke: line_stroke))
    }
    else {
      panic("Invalid value for start parameter, only 'top' and 'bottom' alignments are allowed")
    }
    
    place(start + right, padded_right)
    place(start.inv() + left, padded_left)
    // Manually create the stroke of the cell so that they are above the diagonal line
    place(top + left, rect(stroke: cell_stroke, width: 100%, height: 100%))
  }
  if parent not in (table, grid) {
    panic("Invalid value for object parameter, only 'table' and 'grid' are allowed")
  }
  parent.cell(content, ..kwargs, stroke: none, inset: 0pt, breakable: false)
}

/**
 * A grid cell containing a diagonal line.
 *
 * 'text_left' is the text that appears on the left (top or bottom).
 * 'text_right' is the text that appears on the right (top or bottom).
 * 'start' controls where the diagonal will start: `top` will create a line from top left to bottom right, `bottom` will create a line from bottom left to top right. Defaults to `top`.
 * Additionaly, the function accepts all parameters from `table.grid`. `stroke` accept a dictionnary with a `diag` key to customize the stroke of the diagonal line.
 */
#let grid_diagbox(text_left, text_right, ..kwargs) = _diagbox(grid, text_left, text_right, ..kwargs)

/**
 * A table cell containing a diagonal line.
 *
 * 'text_left' is the text that appears on the left (top or bottom).
 * 'text_right' is the text that appears on the right (top or bottom).
 * 'start' controls where the diagonal will start: `top` will create a line from top left to bottom right, `bottom` will create a line from bottom left to top right. Defaults to `top`.
 * Additionaly, the function accepts all parameters from `table.cell`. `stroke` accept a dictionnary with a `diag` key to customize the stroke of the diagonal line.
 */
#let table_diagbox(text_left, text_right, ..kwargs) = _diagbox(table, text_left, text_right, ..kwargs)
