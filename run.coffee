#!/usr/bin/env coffee

$ ->
    # Run the simulations.
    [days, mean, trials] = Prisoner()

    # Convert to Mynd input format.
    data = days.map (single) ->
        "description": '',
        "data":        [ Math.random() ]

    chart = new Mynd.Chart.column(
        el:        $("#output div.chart")
        data:      data
        width:     460
        isStacked: false
        axis:      [ 'number', 'hour' ]
    )

    settings = new Mynd.Chart.settings(
        el:        $("#output div.settings")
        chart:     chart
        isStacked: false
    )
    settings.render()

    chart.height = $('#output').height() - $("#output div.settings").height()
    chart.render()