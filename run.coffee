#!/usr/bin/env coffee

$ ->
    # Run the simulations.
    [days, mean, trials] = Prisoner()

    # Setup.
    width = 460 ; height = 430 ; bins = 30 ; axisXHeight = 25 ; axisYWidth = 25

    maxval = Math.max days... ; minval = Math.min days...
    stepsize = (maxval - minval) / bins

    histogram = d3.layout.histogram().bins(bins)(days)
    
    # Domain
    x = d3.scale.ordinal().domain(histogram.map( (d) -> d.x )).rangeRoundBands([ 0, width - axisYWidth ])
    y = d3.scale.linear().domain([ 0, d3.max(histogram.map( (d) -> d.y )) ]).range([ 0, height - axisXHeight ])
    l = d3.scale.linear().domain([ 0, maxval ]).range([ 0, width - axisYWidth ])

    svg = d3.select("#chart").append("svg:svg")
    .attr("width", width)
    .attr("height", height)

    # Axes.
    axes = svg.append("svg:g").attr("class", "axes")
    
    axisX = axes.append('svg:g').attr('class', 'x')
    .selectAll("g.rule").data(l.ticks(8)).enter().append("svg:g")
    .attr("class", "bin")
    .attr('transform', "translate(#{axisYWidth},0)")

    axisY = axes.append('svg:g').attr('class', 'y')
    .selectAll("g.rule").data(y.ticks(10)).enter().append("svg:g")
    .attr("class", "tick")
    .attr('transform', "translate(0,-#{axisXHeight})")

    # Graph.
    graph = svg.append('svg:g')
    .attr('class', 'graph')
    .attr('transform', "translate(#{axisYWidth},-#{axisXHeight})")

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
    
    circle.append('svg:circle')
    .attr('cx', l mean)
    .attr('cy', height)
    .attr('r', 3)

    circle.append('svg:text')
    .attr('x', l mean)
    .attr('y', height + 10)
    .text(mean)

    # Hours.
    axisX.append("svg:text")
    .attr("x", (d, i) -> l d )
    .attr("y", height - 2)
    .text( (d, i) -> d )

    # Number.
    axisY.append("svg:text")
    .attr("x", 10)
    .attr("y", (d, i) -> height - y(d))
    .text((d, i) -> d )