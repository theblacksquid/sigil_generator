

paper_height = 500
paper_width = 500



paper = Raphael(document.querySelector('#app'), paper_width, paper_height)

generateGrid = (num, totalWidth, totalHeight) ->
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
            row.push paper.rect(
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