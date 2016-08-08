
paper_height = 500
paper_width = 500
paper = Raphael(document.querySelector('#app'), paper_width, paper_height)
test = findNumberCoords([37, 5, 6, 24], renderKamea(paper, 9, 500).numbers)

console.log generatePath(test)

renderPath(paper, generatePath(test))