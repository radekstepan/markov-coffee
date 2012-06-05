# Monte Carlo Simulation of Markov Prisoner

A CoffeeScript version as contributed to [Wolfram Mathematica](http://demonstrations.wolfram.com/MonteCarloSimulationOfMarkovPrisoner/).

## Problem

A prisoner is in a dungeon with three doors. One door leads to freedom, one door leads to a long tunnel, and a third door leads to a short tunnel. The two tunnels return the prisoner to the dungeon. If the prisoner returns to the dungeon, he attempts to gain his freedom again, but his past experiences do not help him in selecting the door that leads to freedom, that is, we assume a **Markov prisoner**.

## Probabilities

The prisoner's probability of selecting the doors are: `20%` to freedom, `50%` to the short tunnel, and `30%` to the long tunnel. Assuming the travel times through the long and short tunnels are `3` and `2` hours, respectively, our goal is to determine the expected number of hours until the prisoner selects the door which leads to freedom.

## Solution

Mathematically, you can solve this problem using expected values. This Demonstration showcases solving it using Monte Carlo simulation. The simulation show the number of hours until freedom is reached for a number of simulation trials.

As the number of trials increases, the mean of the simulation results converges to the theoretical value (`9.5` for the probabilities defined in the problem).