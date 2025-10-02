#import "../utils.typ": *
#import "utils.typ": *
#show: notes.with(title: "HEU 2 - Randomized Local Search")

We want to maximize $f : {0, 1}^n -> RR$.

= Randomized Local Search

1. Sample $x in {0, 1}^n$ uar.
2. For $t=1, 2, ...$ do
  - sample $i in [n]$ uar
  - create $y$ such that for all $j in [n], y_j = cases(1 - x_j "if" j = i, x_j "otherwise")$
  - evaluate $f(y)$
  - selection $x <- y$ iff $f(y) >= f(x)$

We remind the $OM$ objective function $OM: cases({0, 1}^n -> [0, n], x mapsto lsum_(i=1)^n x_i)$

#prop(title: [Upper bound for RLS on $OM$])[
  From last lecture: $EE[T("RLS", OM)] <= (1 + o(1))n log n$.
]

#prop(title: [Lower bound for RLS on $OM$])[
  We have $EE[T("RLS", OM)] = Omega(n log n)$.
]

*Proof.* \
With probability $>= 1/2$, RLS starts in a point $x$ with $OM(x) <= n/2$. \
In each iteration, RLS can only go from $OM(x)$ to $OM(x)$ or $OM(x) + 1$. \
Probability to go to $OM(x) + 1$ is $(n - OM(x)) / n$. \
Hence, the expected optimization time is at least $1/2 lsum_(i=n/2)^(n-1) n/(n-i)= 1/2(1+o(1))n H_(n/2) = Omega(n log n)$.

== Fitness level method

Let $f : S -> RR$.

#def(title: "Fitness partition")[
  We call $L_1, ..., L_m$ a _fitness partition_ iff
  1. $L_1 union.sq ... union.sq L_m = S$
  2. $forall i < j, forall x in L_i, forall y in L_j, f(y) > f(x)$
  3. $forall x in L_m, f(x) = limits(max)_(s in S) f(s)$
]

Let $A$ be an _elitist_ (greedy) algorithm optimizing $f$.

For all $i$, let $p_i$ be a lower bound for the probability that algo $A$ starting in $x in L_i$ samples a solution $y in limits(union)_(j >= i) L_j$.

#prop(title: [Upper bound for $A$])[
  The expected optimization time of $A$ on $f$ is at most $lsum_(i=1)^(m-1)1/p_i$, that is $EE[T(A, f)] <= lsum_(i=1)^(m-1)1/p_i$.
]

We introduce two new objective functions.

#def(title: "Leading ones")[
  $LO: cases({0, 1}^n -> [0, n], x mapsto max {i in [0, n] | forall j <= i, x_j = 1})$
]

#ex(title: "Leading ones")[
  $LO(underline(111)0underbracket(11010, "tail")) = 3$
]

#def(title: "Binary value")[
  $BV: cases({0, 1}^n -> RR, x mapsto lsum_(i=1)^n 2^(n-i)x_i)$
]

#ex(title: "Binary value")[
  $BV(01001) = 9$
]

#prop(title: [Upper bound for $LO$])[
  $EE[T("RLS", LO)] = Theta(n^2)$
]

*Proof.* \
Use the fitness prop above with $p_i = 1/n$ (that only gives $O(dot)$ and not $Theta(dot)$).

#prop(title: [Upper bound for $BV$])[
  $EE[T("RLS", BV)] = Theta(n log n)$
]

*Proof.* \
Same as for $OM$ (not using fitness levels because there are too many).


= The $(1+1)$ Evolutionary Algorithm

With _mutation rate_ $p in [0, 1]$.

1. Sample $x in {0, 1}^n$ uar.
2. For $t = 1, 2, ...$ do
  - create $y in {0, 1}^n$ by setting for all $i in [n], y_i = cases(1-x_i "with probability" p, x_i "otherwise")$
  - evaluate $f(y)$
  - $x <- y "iff" f(y) >= f(x)$

*Remark:*
- if $p = 1/2$: uniform search
- if $p = 1/n$: in expectation we behave like RLS

#lemma()[
  Let $f: {0, 1}^n -> RR$. \
  Let $(X^i)_(i in NN)$ be the search trajectory of the $opo$ maximizing $f$. \

  Then $PP[X^t in "argmax" f] limits(->)_(t -> infinity) 1$.

  More precisely, for all $f$, we always have $EE[T((1+1)"-EA", f)] = O((1/p)^n)$.
]

Is this tight? Can we design a function $f: {0, 1}^n -> RR$ such that $EE[T(opo, f)] = Omega(1/p^n)$? Yes! We can use the needle below.

$mono("Needle"): f(x) = cases(1 "for x" eq 1...1, 0 "otherwise")$

Many variants possible (even possible to lead the algo in the wrong direction).

Carola presented an example (using a quadratic form) to trick only half of the people. Obtaining the following result :
$PP[T <= n log n] = 1/2$ and $PP[T >= n^n] = 1/2$

Now, let's try to establish upper bounds.

#prop(title: [Upper bound for $opo$ on $OM$])[
  $EE[T(opo, OM)] <= (1+o(1))e n log n$
]

*Proof.* \
For $OM$, we can only consider 1-bit flips (since the algorithm is elitist). \
That leads to $p_i >= (n - i) dot 1/n dot (1 - 1/n)^(n-1) tilde.eq (n - i)/n dot 1/e$.
Then $EE[T(opo, OM)] <= lsum_(i=0)^(n- 1) e n / (n - i) = (1+o(1))e n log n$

#prop(title: [Upper bound for $opo$ on $LO$])[
  $EE[T(opo, LO)] <= (1 + o(1)) e n^2$
]

*Proof.* \
Same as above.

#lemma(title: [Lower bound for $opo$])[
  The expected optimization time of the $opo$ on any function $f: {0, 1}^n -> RR$ with unique global optimum is $Omega(n log n)$.
]

*Proof.* \
In the initial solution, with probability at least $1/2$, half of the bits are incorrect. \
The probability that at least one of them has not been flipped in the first $t$ iterations equals $1 - (1-(1-1/n)^t)^(n/2)$. With $t = 1/3 n log n$, the probability is constant.

Let's get an upper bound for $opo$ on $BV$.

#emoji.warning We can accept $y$ with $BV(y) >= BV(x)$ but $d(y, "opt") > d(x, "opt")$ (this is not the case for $OM$), e.g.:
- $BV(10...0) = 2^(n-1)$
- $BV(01...1) < 2^(n-1)$

#th(title: "Later with Benjamin")[
  The expected optimization time of the $opo$ on any _linear_ function $f: cases({0, 1}^n -> RR, x mapsto lsum_(i=1)^n w_i x_i)$ is $Theta(n log n)$.
]

#prop(title: [Upper bound for $opo$ on $BV$])[
  $EE[T(opo, BV)] = O(n^2)$
]

*Proof.* \
Use fitness partition as in $LO$:
- $L_n = {(1...1)}$
- $L_i = {x | forall j <= i x_j = 1} \\ limits(union)_(j > i)L_j$
For $x in L_i$, the probability that the $opo$ with mutation probability $p + 1/n$ samples a solution $y in limits(union)_(j > i)L_j$ is at least $1/n (1 - 1/n)^(n-1) tilde.eq 1/n dot 1/(e^n)$ (since we need to flip the specific bit in position $i+1$). \
Using fitness level method gives $EE[T] <= lsum_(i=0)^(n-1) e n = e n^2$.

= Project

Based on _submodular problems_: $f(A union B) >=^? f(A inter B) ? f(A) + f(B)$.

The value of an item depends on the amount of that item we already have.

$forall X subset.eq Y, forall z in.not Y, f(X union {z}) - f(X) >= f(Y union {z}) - f(Y)$ (think of chocolate somehow).

#line(length: 100%)

*Theory:* we often study worst-case expected optimization time.

*Real life:* we often have a fixed budget, and we care much more about the actual distribution (*use box plots or similar*).

Metric: use *function evaluations* (not CPU time or something else, ...).

Attainment function (EAF): a grid (heatmap) where each cell is
(t, f(t)) = $PP["Algo finds within the first" t "iterations a solution of quality at least" f(t)]$

Performance is way more than "the expectation" and some box plots: we want to gain a deep understanding to be able to adapt algorithms given on the specific instances shape.
