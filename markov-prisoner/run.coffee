#!/usr/bin/env coffee

$ ->
    # Run the simulations.
    [days, mean, trials] = Prisoner()

    # Setup.
    width = $('#chart').width() ; height = 300
    bins = 30 ; margins = [ 10, 10, 25, 25 ]

    maxval = Math.max days... ; minval = Math.min days...
    stepsize = (maxval - minval) / bins

    histogram = d3.layout.histogram().bins(bins)(days)
    
    # Domain
    x = d3.scale.ordinal().domain(histogram.map( (d) -> d.x )).rangeRoundBands([ 0, width - margins[3] - margins[1] ])
    y = d3.scale.linear().domain([ 0, d3.max(histogram.map( (d) -> d.y )) ]).range([ 0, height - margins[2] - margins[0] ])
    l = d3.scale.linear().domain([ 0, maxval ]).range([ 0, width - margins[3] - margins[1] ])

    svg = d3.select("#chart").append("svg:svg")
    .attr("width", width)
    .attr("height", height)

    # Axes.
    axes = svg.append("svg:g").attr("class", "axes")
    
    axisX = axes.append('svg:g')
    .attr('class', 'x')
    .attr('transform', "translate(#{margins[3]},0)")

    axisY = axes.append('svg:g').attr('class', 'y')
    .attr('transform', "translate(0,-#{margins[2] + margins[0]})")

    # Graph.
    graph = svg.append('svg:g')
    .attr('class', 'graph')
    .attr('transform', "translate(#{margins[3]},-#{margins[2] + margins[0]})")

    # Bars.
    bars = graph.append("svg:g")
    .attr('class', 'bars')

    bars.selectAll("rect").data(histogram).enter().append("svg:rect")
    .attr("width", x.rangeBand())
    .attr("x", (d) -> x d.x )
    .attr("y", (d) -> height - y(d.y) )
    .attr("height", (d) -> y d.y )
    
    # The converging point.
    circle = graph.append('svg:g').attr('class', 'result')

    circle.append('svg:text')
    .attr('x', l mean)
    .attr('y', height + 10)
    .text(mean)

    circle.append('svg:line')
    .attr('x1', l mean)
    .attr('x2', l mean)
    .attr('y1', 0)
    .attr('y2', height)

    # Hours.
    for tick in l.ticks(8)
        axisX.append("svg:text")
        .attr("x", l tick )
        .attr("y", height - 2)
        .text(tick)

    axisX.append("svg:text")
    .attr('class', 'legend')
    .attr("x", width / 2)
    .attr("y", height - 18)
    .text("Hours")

    # Number.
    for tick in y.ticks(10)
        axisY.append("svg:text")
        .attr("x", 0)
        .attr("y", height + margins[0] - y(tick))
        .text(tick)