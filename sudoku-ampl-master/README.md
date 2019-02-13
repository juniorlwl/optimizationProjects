# sudoku-ampl
[![Python](https://img.shields.io/badge/python-2.7-blue.svg)]() [![AMPL](https://img.shields.io/badge/AMPL-20120911-D0E75F.svg)]()

Tired of solving sudoku puzzles by boring old recursion? Want to titillate your grey matter? Try this!

## Getting started

We are going to try solving the world's [toughest (allegedly) sudoku puzzle](https://www.telegraph.co.uk/news/science/science-news/9359579/Worlds-hardest-sudoku-can-you-crack-it.html), and compare two approaches.
1. Install AMPL and the solver of your choice - CPLEX, Cbc, etc. 
2. Solve `hardest.dat` with the provided AMPL model `main.mod`
3. Solve `sudoku.py` with `python sudoku.py`
4. Compare execution time of both approaches
5. Revel in the power of mathematical modelling as opposed to boring old Python

## Notes

- Made originally during [40.302 Adv. Topics in Optimisation (Jan 2017)](https://esd.sutd.edu.sg/courses/40302-advanced-topics-in-optimisation/)
- Special thanks to [Prof. Ahipasaoglu](https://esd.sutd.edu.sg/people/faculty/selin-damla-ahipasaoglu)