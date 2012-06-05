#!/usr/bin/env coffee

window.Prisoner = ->
    numbertrials = 50 # number of trials
    dlong = 3 # hours for the long tunnel
    dshort = 2 # hours for the short tunnel

    # Probabilities.
    pshort = 0.5
    plong = 0.3
    pfreedom = 0.2

    # Generates a list of expression results.
    Table = ->
        array = []

        for i in [0...numbertrials]
            current = 0
            doorselect = Math.random()

            loop
                break unless doorselect > pfreedom

                if doorselect <= (pfreedom + pshort)
                    current += dshort
                else
                    current += dlong

                doorselect = Math.random()

            array.push current

        array

    days = Table()

    # Gives the statistical mean of the elements in list.
    Mean = (list) ->
        sum = list.reduce (t, s) -> t + s
        (if list.length then sum / list.length else 0)

    [days, Mean(days), numbertrials]