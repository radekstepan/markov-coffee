#!/usr/bin/env coffee

$ ->
    # Run the simulations.
    [days, mean, trials] = Prisoner()

    # Set the mean.
    $('#mean').text mean

    # Convert to d3.js format.
    data = days.map (datum, index) ->
        "number":   index + 1,
        "hour": datum

    n = 10000
    m = 10
    data = []
    i = 0

    while i < n
        s = 0
        j = 0

        while j < m
            s += Math.random()
            j++
        data.push s
        i++
    
    width = 460 ; height = 400

    histogram = d3.layout.histogram()(data)
    
    x = d3.scale.ordinal().domain(histogram.map( (d) -> d.x )).rangeRoundBands([ 0, width ])
    y = d3.scale.linear().domain([ 0, d3.max(histogram.map( (d) -> d.y )) ]).range([ 0, height ])
    
    svg = d3.select("#chart")
    .append("svg")
        .attr("width", width)
        .attr("height", height)
    
    svg.selectAll("rect").data(histogram).enter()
    .append("rect")
        .attr("width", x.rangeBand())
        .attr("x", (d) -> x d.x )
        .attr("y", (d) -> height - y(d.y) )
        .attr("height", (d) -> y d.y )

    svg
    .append("line")
        .attr("x1", 0)
        .attr("x2", width)
        .attr("y1", height)
        .attr("y2", height)
