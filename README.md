# BayesianParticleFitler

Based on https://en.wikipedia.org/wiki/Particle_filter

Snake tracking on a 300x300 space using a bayesian particle filter.

The steps are as follows : 
1) Initialize the first n particles randomly
2) Make them evolve the same way the snake would
3) Assign a weight to them based on a observation (high weight if particle is at same position than snake, low otherwise)
4) Sample them by recreating the particles with the lowest weights around the ones with the heighest weights
5) Repeat from 2.

V1 is a simple version with the whole body being tracked (particles have weights, pos x, pos y)<br>
V2 is a bit more complex, only the head is tracked (particles have current weights, pos x, pos y, head orientation, previous weight)
