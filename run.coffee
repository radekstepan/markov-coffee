#!/usr/bin/env coffee

$ ->
    # Run the simulations.
    [days, mean, trials] = Prisoner()

    # Setup.
    width = 460 ; height = 430 ; bins = 30 ; legendHeight = 25

    maxval = Math.max days... ; minval = Math.min days...
    stepsize = (maxval - minval) / bins

    histogram = d3.layout.histogram().bins(bins)(days)
    
    # Domain
    x = d3.scale.ordinal().domain(histogram.map( (d) -> d.x )).rangeRoundBands([ 0, width ])
    y = d3.scale.linear().domain([ 0, d3.max(histogram.map( (d) -> d.y )) ]).range([ 0, height - legendHeight ])
    l = d3.scale.linear().domain([ 0, maxval ]).range([ 0, width ])

    svg = d3.select("#chart").append("svg:svg")
    .attr("width", width)
    .attr("height", height)

    axes = svg.append("svg:g").attr("class", "axes")
    .selectAll("g.rule").data(histogram).enter().append("svg:g")
    .attr("class", "rule")

    # Bars.
    bars = svg.append("svg:g")
    .attr('class', 'bars')

    bars.selectAll("rect").data(histogram).enter().append("svg:rect")
    .attr("width", x.rangeBand())
    .attr("x", (d) -> x d.x )
    .attr("y", (d) -> height - y(d.y) - legendHeight )
    .attr("height", (d) -> y d.y )
    
    # The converging point.
    circle = svg.append('svg:g').attr('class', 'result')
    
    circle.append('svg:circle')
    .attr('cx', l mean)
    .attr('cy', height - legendHeight)
    .attr('r', 3)

    circle.append('svg:text')
    .attr('x', l mean)
    .attr('y', height - 13)
    .text(mean)

    # Hours.
    axes.append("svg:text")
    .attr("x", (d, i) -> x(d.x))
    .attr("y", height - 2)
    .text((d, i) ->
        if i % 3 is 0 then Math.round d.x
    )