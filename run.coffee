#!/usr/bin/env coffee

$ ->
    # Run the simulations.
    [days, mean, trials] = Prisoner()

    # Convert to Mynd input format.
    data = days.map (datum, index) ->
        "description": index,
        "data":        [ datum ]

    chart = new Mynd.Chart.column(
        el:        $("#output")
        data:      data
        width:     $('#output').width()
        height:    $('#output').height()
        isStacked: false
        axis:
            'vertical':   'number'
            'horizontal': 'hour'
    )
    chart.render()