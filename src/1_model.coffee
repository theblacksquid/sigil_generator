
generateGrid = (parent, num, totalWidth, totalHeight) ->
    i = 0
    cx = 0
    cy = 0
    rows = []
    bbox = {}
    while num > i
        row = []
        sub_i = 0
        cx = 0
        while num > sub_i
            row.push parent.rect(
                cx, cy
                totalWidth/num,
                totalHeight/num
                )
            row[sub_i].attr({
                'stroke-width': 3
                'fill': 'lightgray'
            })
            bbox = row[sub_i].getBBox()
            cx = cx + bbox.width
            sub_i++
        rows.push row
        cy = cy + bbox.height
        i++
    rows
    
getBBoxes = (grid) ->
    result = []
    for row in grid
        sub = []
        for cell in row
            sub.push cell.getBBox()
        result.push sub
    result

applyNumbers = (parent, bboxGrid, kamea) ->
    result = []
    i = 0
    while bboxGrid.length > i
        sub = []
        sub_i = 0
        while bboxGrid.length > sub_i
            cell = bboxGrid[i][sub_i]
            num = kamea[i][sub_i]
            sub.push parent.text(cell.cx, cell.cy, num+'').attr({
                'fill': 'black'
                'font-size': 20
            })
            sub_i++
        result.push sub
        i++
    result

renderKamea = (parent, int, size) ->
    if int < 3
        console.error 'Select Number between 3 to 9'
    else if int > 9
        console.error 'Select Number between 3 to 9'
    else 
        canvas = Raphael(parent, size, size)
        grid = generateGrid(parent, int, size, size)
        bboxes = getBBoxes(grid)
        numbers = applyNumbers(parent, bboxes, kameas[int])
        {
            'canvas': canvas
            'grid': grid
            'bboxes': bboxes
            'numbers': numbers
        }