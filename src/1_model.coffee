
flatten = (arr) ->
    [].concat.apply([], arr)

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
        
findNumberCoords = (arrOfTargets, gridOfNumbers) ->
    targets = []
    result = []
    newArr = flatten(gridOfNumbers)
    for num in arrOfTargets
        targets.push newArr.filter((x)->
            if x.attrs.text is num+'' then x
            )[0]
    for obj in targets
        result.push {
            x: obj.getBBox().cx
            y: obj.getBBox().cy
        }
    result

generatePath = (arrOfCoords) ->
    subResult = []
    for coord in arrOfCoords
        if coord is arrOfCoords[0]
            subResult.push "M#{coord.x},#{coord.y}"
        else 
            subResult.push "L#{coord.x},#{coord.y}"
    subResult.join(" ")

renderPath = (parent, pathString) ->
    parent.path(pathString).attr({
        'stroke-width': 3
        'stroke': 'white'
    })

