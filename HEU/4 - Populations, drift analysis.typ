#import "../utils.typ": *
#import "utils.typ": *
#show: notes.with(title: "HEU 4 - Populations, drift analysis")

= Introduction

Why did Benjamin move to _Design and Analysis of Algorithms_ to _Heuristics_?
- huge *importance in practice*
- and *very little theoretical work so far*
  - large need
  - many fundamental questions are wide open
  - room for cool results
- some problems *cannot be solved with classic algorithms*

#ex(title: "Open questions")[
  - Do we need _crossover_ in EA?
  - Is _non-elitism_ (forgetting the best-so-far) useful?
  - How do I set _parameters_ of my favorite heuristic?
]

= Runtime Analysis of Simple Heuristics

#def(title: "Runtime analysis")[
  _Runtime analysis_: quantify the time $T$ before the first optimal solution is found.
]

Reminder from lecture 2 (upper bound for the RLS expected runtime on $OM$ using fitness-level argument, $opo$ on $OM$ using only 1-bit flips).

#def(title: [$(1+lambda)$-EA])[
  We now still have only one parent, but $lambda$ independent offsprings, and we pick the best one (if better than current parent).
]

*Task.* How long does it take to find the optimum, and what is the role of $lambda$?

*Clever proof.* Fitness-level method with expectations. \
- $OM(x) = n - d$
- $PP(OM(y_i) > OM(x)) >= d / (n e)$
- $EE(T_d) <= (e n) / d + lambda$ where $T_d$ is the time to get a better offspring
- $EE(T) = sum E(T_d) = e n ln n + n lambda + O(n)$

*Proof.* Classic fitness-level method. \
- $p_d >= 1 - (1 - d/(e n))^lambda$
- see the slides for tedious details (depends on the regime).

= Drift Analysis, Linear Functions

#def(title: "(Pseudo-Boolean) Linear function")[
  Let $a_1, ..., a_n in RR$. Then: $ f: cases(delim: #none, {0, 1}^n -> RR, x mapsto lsum_(i=1)^n a_i x_i) $ is called a _(pseudo-boolean) linear function_.
]

Usual assumptions:
- all weights $a_i$ are different from zero
- all weights $a_i$ are positive

*Question.* In how many iterations (in expectation) do RLS and $opo$ optimize such a linear function?

#emoji.warning The previous proof does not hold anymore. We needed $"higher fitness" => "more" 1"'s"$, which is not valid anymore. For example, think of $BV$: $BV((0, 1, ... 1)) = 2^(n-1)-1 < BV((1, 0, ..., 0)) = 2^(n-1)$.

This is known as *_low fitness-distance correlation_*: the fitness of a search point does not indicate well how close the search point is to the optimum.

#th(title: "Multiplicative drift")[
  Let $X_0, X_1, ...$ be a sequence of random variables taking values in the set ${0} union [x_min, infinity)$ $(x_min > 0)$.


  Let $delta > 0$. Assume that for all $t in NN$ and $x in RR_+$, we have $ EE[X_(t+1) | X_t = x] <= (1 - delta)x $
  Let $T := min {t in NN | X_t = 0}$. Then: $ EE[T | X_0 = x] <= (1 + ln x/x_min) / delta $
]

#prop(title: "Corollary of the multiplicative drift")[
  The $opo$ optimizes any linear function $f$ with weights in $[a_min, a_max]$ in expected time at most $e n (1 + ln (a_max n) / a_min)$.
]

= Metropolis Algorithm

You always take the newly generated solution if it's better. If it's worse, it is picked with probability $alpha^(f(y) - f(x^(t-1)))$, where $alpha$ is a given parameter.

*Task.* Analyze the runtime of the Metropolis algorithm on the $OM$ problem for reasonable values of $alpha$.

- $PP(-1) <= 1 / alpha$
- $PP(+1) = d/n >= 1 / n$
- Hopefully we will have: $EE[Delta f] >= 1 /n - 1/ alpha >= 1 / 2n$ (aiming for a multiplicative drift)
