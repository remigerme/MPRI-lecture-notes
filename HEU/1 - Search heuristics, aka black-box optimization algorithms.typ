#import "../utils.typ": *
#import "utils.typ": *
#show: notes.with(title: "HEU 1 - Search heuristics, aka black-box optimization algorithms")

= Introduction

Depending on the context of the optimization problem, we can evaluate a solution, using:
- simulations
- physical experiments
- user study

The black-box (function) returns a single number indicating how good is the proposed solution (for now). We submit different solutions until we are happy enough (in theory. In practice we are constrained by our budget.

*How do I decide the next solution?*

#def(
  title: "Key performance measure",
)[The key performance measure is the number of function (black-box) evaluations.]

#ex(title: "Applications")[
  Wherever *simulations* or *experiments* are needed (e.g. if we don't have an explicit model for the problem, in biology, engineering, machine learning, ...), or there is *no problem-specific algorithm available*.
]

Interactive exercise: finding the max value of a function defined over ${1, ..., 10} times {1, ..., 20}$. Notice how we naturally alternate between *exploration* and *exploitation*.

= Common black-box optimization algorithms

In practice, some real-world powerful algorithms are surprisingly simple.

How to overcome local optima?
1. Restart (either cause we're stuck or at certain intervals)
  1. at random
  2. with diversity in mind
2. Consider a larger neighborhood
3. Exploring taboo regions
4. Accept inferior solutions

#table(
  columns: 2,
  table.header([*Name*], [*Remarks*]),
  [Random sampling], [Simple yet (surprisingly) efficient],
  [Local search], [Beware of local optimum],
  [Simulated annealing], [Tradeoff between exploration and exploitation (as a function of time)],
  [Evolutionary algo.], [Different generations],
  [Genetic algo.], [Evolutionary + mutations, crossovers],
  [Population-based], [See above with multiple individuals],
  [Estimation of distribution], [...],
  [Swarm intelligence], [...],
  [Surrogate-based opt. (Bayesian opt.)], [...],
  [Partition-based methods], [...],
  [Gradient descent], [...],
)

Part of real-life research is to stick different methods together, and know _when_ to switch between them. Different algorithms have different results on different problems.

We study the maximization of a function $f : {0, 1}^n -> RR$.

= Randomized Local Search (RLS)

- Sample $x in {0, 1}^n$ uniformly at random (_uar_) and evaluate $f(x)$ (*initialization*)
- For $i = 1, 2, ...$ do
  - sample $j in [n]$ uar
  - create $y$ by setting $y_k = cases(x_k "for" k != j, 1 - x_k "for" k = j)$ (*mutation* or *variation*)
  - evaluate $f(y)$
  - if $f(y) >= f(x)$ then $x <- y$ (*greedy selection*)

This is simple but it might be inefficient to find quickly big values and it could get trapped in local optimum.

Consider the function $OM: {0, 1}^n -> RR, x mapsto lsum_(i=1)^n x_i$ .


*Remark.* \
This is relevant because it is equivalent to the following problem for any $z in {0, 1}^n$: $ f_z : x mapsto |{ i in [n] | x_i = z_i }| $
The lower bound for this problem is $Theta(n / log n)$. \
Note that this is a game of *Mastermind*, which is literally a black-box optimization problem.

How long does RLS needs to solve $OM$ in expectation? \
See #link("https://blog.remigerme.xyz/cs/stardew")[coupon collector problem (clickable self-promotion)]: $cal(O)(n log n)$.

*Homework 1.* Think of the lower bound $cal(O)(n log n)$. \
*Homework 2.* Coupon collector problem.
