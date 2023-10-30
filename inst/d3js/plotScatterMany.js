var points = options.points, smooth = options.smooth,
    abline = options.abline,
    peaks = options.peaks, nlabel = options.nlabel,
    minVariable = options.xmin, maxVariable = options.xmax,
    minResidual = options.ymin, maxResidual = options.ymax,
    xTitle = options.xTitle, n = options.n,
    yTitle = options.yTitle, chartTitle = options.chartTitle,
    background = options.background;

var plotHeight, plotWidth,
    margin = {top: 78, right: 30, bottom: 50, left: 60, inner: 70},
    h = height - margin.top - margin.bottom,
    plotTop = margin.top, plotLeft = margin.left;

if (options.scalePlot === true) {
  var m = Math.ceil(n/2);
  if (n == 2) { m = 2; }
  plotHeight = (h-(m-1)*margin.inner)/m;
  plotWidth = 3*plotHeight/2;
} else {
  plotHeight = 280;
  plotWidth = 420;
}

var k;
if (smooth === true) { k = 1; } else { k = 0; }
var modelNames = Object.keys(data[k]);

var colors = getColors(3, "point"),
    pointColor = colors[k],
    smoothColor = colors[0],
    greyColor = colors[2];

residual(data);

svg.selectAll("text")
  .style('font-family', 'Fira Sans, sans-serif');

// plot function
function residual(data){
  var pointData = data[0], smoothData = data[1];
  for (var i=0; i<n; i++){
    var modelName = modelNames[i];
    singlePlot(modelName, pointData, smoothData, i+1);
  }
}

function singlePlot(modelName, pointData, smoothData, i) {

    var x = d3.scaleLinear()
          .range([plotLeft + 5, plotLeft + plotWidth - 5])
          .domain([minVariable, maxVariable]);

    var y = d3.scaleLinear()
          .range([plotTop + plotHeight, plotTop])
          .domain([minResidual, maxResidual]);

    // function to draw smooth lines
    var line = d3.line()
          .x(function(d) { return x(d.x); })
          .y(function(d) { return y(d.smooth); })
          .curve(d3.curveMonotoneX);

    // add plot things only once
    if (i==1) {
      svg.append("text")
          .attr("class", "bigTitle")
          .attr("x", plotLeft)
          .attr("y", plotTop - 40)
          .text(chartTitle);
    }

    svg.append("text")
        .attr("class","smallTitle")
        .attr("x", plotLeft)
        .attr("y", plotTop - 15)
        .text(modelName);

    var tickValues = getTickValues(x.domain());

    // axis and grid
    var xAxis = d3.axisBottom(x)
              .tickValues(tickValues)
              .tickSizeInner(0)
              .tickPadding(15);

    xAxis = svg.append("g")
              .attr("class", "axisLabel")
              .attr("transform", "translate(0,"+ (plotTop + plotHeight) + ")")
              .call(xAxis);

    var yGrid = svg.append("g")
             .attr("class", "grid")
             .attr("transform", "translate(" + plotLeft + ",0)")
             .call(d3.axisLeft(y)
                    .ticks(10)
                    .tickSize(-plotWidth)
                    .tickFormat("")
            ).call(g => g.select(".domain").remove());

    if (i%2 === 1) {
      var yAxis = d3.axisLeft(y)
              .ticks(5)
              .tickSize(0);

      yAxis = svg.append("g")
              .attr("class", "axisLabel")
              .attr("transform","translate(" + (plotLeft-8) + ",0)")
              .call(yAxis)
              .call(g => g.select(".domain").remove());
    }

    if (background === true){
      // draw grey scatter and smooth
      for (var j=0; j<n; j++){
        if (modelNames[j] !== modelName){
          let tempName = modelNames[j];

          if (points === true) {

            let scatter = svg.selectAll()
                .data(pointData[tempName])
                .enter();

            scatter.append("circle")
                .attr("class", "dot " + tempName)
                .attr("id", tempName)
                .attr("cx", d => x(d.x))
                .attr("cy", d => y(d.y))
                .attr("r", 1)
                .style("fill", greyColor)
                .style("opacity", 0.5);
          }

          if (smooth === true) {

            svg.append("path")
                .data([smoothData[tempName]])
                .attr("class", "smooth " + tempName)
                .attr("id", tempName)
                .attr("d", line)
                .style("fill", "none")
                .style("stroke", greyColor)
                .style("stroke-width", 2)
                .style("opacity", 0.5);
          }
        }
      }
    }

    // scatter
    if (points === true) {

      var p = svg.selectAll()
                  .data(pointData[modelName])
                  .enter()
                  .append("circle")
                  .attr("class", "dot " + modelName)
                  .attr("id", modelName)
                  .attr("cx", d => x(d.x))
                  .attr("cy", d => y(d.y))
                  .attr("r", 1.5)
                  .style("fill", pointColor);

      if (peaks === true) {
        p.style("stroke-width", 1.5)
         .style("stroke", d => d.peak === true ? "red" : "transparent")
         .style("stroke-opacity", 1);
      }

      if (nlabel === true) {
        svg.selectAll()
            .data(pData.filter(d => d.big === true))
            .enter()
            .append("text")
            .attr("class", "dot " + modelName)
            .text(d => d.index)
            .attr("x", d => x(d.x))
            .attr("y", d => y(d.y)-2)
            .attr("text-anchor", "middle")
            .style("font-weight", 400)
            .style("font-size", "11px")
            .style("text-align", "left");
      }
    }

    // smooth line
    if (smooth === true) {
      svg.append("path")
        .data([smoothData[modelName]])
        .attr("class", "smooth " + modelName)
        .attr("id", modelName)
        .attr("d", line)
        .style("fill", "none")
        .style("stroke", smoothColor)
        .style("stroke-width", 2);
    }

    if (abline === true) {
      let ta = [{x: minVariable, smooth: minVariable},
                {x: maxVariable, smooth: maxVariable}];

      svg.append("path")
        .data([ta])
        .attr("d", line)
        .style("fill", "none")
        .style("stroke", "#ae2c87")
        .style("opacity", 0.65)
        .style("stroke-width", 2)
        .style("stroke-dasharray", ("1, 2"));
    }

    if (i==n){
    	svg.append("text")
          .attr("class", "axisTitle")
          .attr("transform", "rotate(-90)")
          .attr("y", margin.left - 45)
          .attr("x", -(margin.top + plotTop + plotHeight)/2)
          .attr("text-anchor", "middle")
          .text(yTitle);

      svg.append("text")
          .attr("class", "axisTitle")
          .attr("y", (plotTop + plotHeight + margin.bottom - 15))
          .attr("x", (margin.left + plotWidth + 25/2))
          .attr("text-anchor", "middle")
          .text(xTitle);
 	  }

    if (i%2 === 1){
      plotLeft += (25 + plotWidth);
    }
    if (i%2 === 0){
      plotLeft -= (25 + plotWidth);
      plotTop += (margin.inner + plotHeight);
    }
}
