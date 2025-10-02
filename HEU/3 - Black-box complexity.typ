#import "../utils.typ": *
#import "utils.typ": *
#show: notes.with(title: "HEU 3 - Black-box complexity")

= Black-box complexity

#def(title: "Black-box complexity")[
  Let $cal(A)$ be a collection/set of algorithms, and let $cal(F) subset.eq {f: S -> RR}$ be a set of functions defined over the _search space_ (sometimes _design space_) $S$.

  The _$cal(A)$-black-box complexity of $cal(F)$_ is defined as $ cal(A)"-BBC"(cal(F)) = inf_(A in cal(A)) sup_(f in cal(F)) EE[T(A, f)] $ the best worst-case expected runtime that an algorithm $A in cal(A)$ can achieve on the collection $cal(F)$.
]

*Reminder:* $T(A,f)$ denotes the number of evaluations that $A$ performs until it queries an element in $"argmax" f$.

*A general upper bound?* \
Let $S$ be a finite set and $cal(F) = {f: S -> RR}$. \
Let $cal(A)$ be the set of all (possibly randomized) algorithms.

$
  bbcf & <= |S| "by enumerating the elements in" S "and query one after the other" \
       & <= (|S|) / 2 "randomly"
$

Is this tight? \
Yes, it can be tight.

#ex(title: "Tight collections")[
  - $cal(F)$ a collection of completely random functions
  - needle in-the-hay stack $f_z: S --> R, x mapsto cases(1 "if" x = z, 0 "otherwise")$
]

#th(title: "No free lunch theorem")[
  This theorem essentially tells us that all algorithms have equal performance after averaging, over all possible functions ${f: S -> RR}$.
]

Hopefully in practice we do *not* look at all possible functions when optimizing a relevant problem.


*An upper bound for a single problem?* \
Let $f : S -> RR$ and $cal(F) = {f}$. \
Then, $bbcf = 1$. \
Proof: take $s in "argmax" f$. Let $A$ be the algorithm that queries $s$ in the first iteration.

Unfortunately this is not useful. Instead, we will typically look at collections of functions. Recall from lecture 1, we looked at functions $f_z : {0, 1}^n -> [0, n], x mapsto |{i in [n] | x_i = z_i}|$. We came from $OM$, then said that RLS behaves exactly the same on every function $f_z, z in {0, 1}^n$ (in particular $f_((1, ..., 1))$ which is $OM$).

Alternative to looking at ${f_z | z in {0, 1}^n}$ is to *restrict* the set of admissible algorithms. One popular way of restricting the class of admissible algorithms is to look only at _$k$-ary unbiased_ black-box optimization algorithms. These algorithms use only so-called $k$-ary unbiased _variation operators_.

#def(title: [$k$-ary unbiased variation operators (for $S = {0, 1}^n$)])[
  - _$k$-ary_: the output of the variation operator depends on at most k points. That is, we can describe it as a distribution $D(dot | x^1, ..., x^k)$ where the $x^i$'s can but do not have to be the $k$ most recently queried ones.
  - _unbiased_:
    1. `XOR`-invariant:
    $
      forall y, z in {0, 1}^n, D(y | x^1, ..., x^k) = D(y plus.circle z | x^1 plus.circle z, ..., x^k plus.circle z)
    $
    2. permutation invariance:
    $
      forall y in {0, 1}^n, forall sigma in cal(S)_n, D(y, x^1, ..., x^k) = D(sigma(y) | sigma(x^1), ..., sigma(x^k)) \
      "where" sigma(x) = (x_sigma(1), ..., x_sigma(n))
    $
]

#prop(title: "Black-box complexity of unbiased algorithms (no proof in lecture)")[
  Let $cal(U)$ be the set of of all unbiased black-box algorithms. \
  Let $f: {0, 1}^n -> RR$. \
  Then $cal(U)"-BBC"({f}) = bbc({f_(z,sigma) : {0, 1}^n -> RR, x mapsto f(sigma (x plus.circle z))})$.
]

- For $OM$, we did this ($sigma$ does not have any impact).
- For $LO$, the permutations do matter: if we want to study $cal(U)"-BBC"(LO)$, we need to consider the functions $ LO_(z, sigma): cases({0, 1}^n -> [0, n], x mapsto max {i in [0, n] | forall j < i, x_(sigma(j)) plus.circle z_(sigma(j)) = 1}) $

#ex(title: "Arity and unbiasedness of operators")[
  - *uniform sampling*: unbiased, $0$-ary (the one and only $0$-ary unbiased variation operator)
  - sample $(0, ..., 0)$: $0$-ary but not unbiased: not `XOR` invariant: $ PP((0, ..., 0)) = 1 != PP((0, ..., 0) plus.circle (1, ..., 1)) = 0 $
  - *$"flip"_l$* operator: given a point $x$, create $y$ by first sampling uar without replacement $l$ indices $i_1, ... i_l in [n]$ and then setting $ y_j = cases(1 - x_j "if" j in {i_1, ..., i_l}, x_j "otherwise") $ This operator is $1$-ary and unbiased.
]

*Note:* RLS uses $"flip"_1$.

#def(title: "Alternative definition of unbiasedness")[
  A $k$-ary variation distribution operator $D$ is unbiased if and only if it is _Hamming invariant_ ie. $ forall y, z in {0, 1}^n, forall i in [k], d(y, x^i) = d(z, x^i) => D(y | x^1, ..., x^k) = D(z | x^1, ..., x^k) $
]

This gives us a nice characterization of unbiased operators.

#prop(title: "Characterization for unary unbiased variation operators")[
  Every unary unbiased variation operator can be described by a probability distribution $"prob"$ over the possible search radius.

  The operator first samples the radius $k ~_"prob" [0,n]$, then we apply the $"flip"_k$ operator.
]

A few more unary examples:
- *$opo$* uses the standard bit mutation operator $"sbm"_p$, which flips each bit independently with probability $p$. It is unbiased (use the previous characterization with $"prob" = cal(B)(n,p)$).
- *$"invert"_l$*: flips entry in position $l$: unary and not unbiased.
- *$"flip"_(3"-ones")$*: takes $x$ and flips exactly 3 positions whose entry is $1$, chosen uar: not unbiased.

Now, some binary operators:
- *uniform crossover*: from $x, y in {0, 1}^n$, create $z$ by setting $z_i = cases(x_i "with proba" 1/2, y_i "otherwise")$. It is unbiased.
- *biased crossover* with bias $c in ]0, 1/2[$: pick $x_i$ with proba $c$ - it is still unbiased!
- *$k$-point crossover*: given $x, y in {0, 1}^n$, create $z$ by first sampling uar without replacement $i_1, ..., i_k in [n]$ and setting $ x & = underline(0 1 1) | 1 1 0 | underline(...) | ... \
  y & = 1 0 1 | underline(0 1 0) | ... | underline(...) \
  z & = 0 1 1 | 0 1 0 | ... | ... $ It is not unbiased (it is not permutation invariant).
- *majority*: given $x^1, ..., x^k$ create $y$ by setting $ y_i = cases("maj"(x_i^1, ..., x_i^k) "if it exists", 1 "with probability" 1/2, 0 "else") $ It is also unbiased.

== Black-box complexity of $OM$

=== Lower bound

Technique:
1. bound the average deterministic BBC
2. use the so-called _Yao's minimax principle_

Let's look at deterministic algorithms for solving an arbitrary function $OM_z$.

Every deterministic algorithm can be expressed as a decision tree.

#lemma()[
  Let $cal(D)$ be the set of all deterministic algorithms operating on functions $f: S -> RR$. \
  Let $cal(F) subset.eq {f: S -> RR}$ such that for all $s in S$, there is a function $f_s$ whose unique global maximum is reached in $s$, that is ${s} = "argmax" f_s$.

  If for every $s$ it holds that $| {f_s(x) | x in S}| <= k$ (at most $k$ branching in our decision tree), then the best possible complexity that a deterministic algorithm can achieve on a uniformely chosen function $f_s$ is at least $log_k (|S|) - 1$.
]

Think of $OM_z$, which reaches its unique optimal value in $z$. Moreover, we have $k = n + 1$ possible answers.

*Proof* (sketch). \
We need to place all $s in S$ somewhere in the decision tree.

In the first $j$ levels of the decision tree, we can place at most $lsum_(i=1)^j k^(i-1)$. \
We need this sum to be at least $|S|$: essentially, we need at least $log_k (|S|)$ levels.
The average height (level) at which we can find a uniformely chosen $s in S$ is at least $log_k (|S|) - 1$.

*Conclusion:* we have a lower bound for all _deterministic_ algorithms on a function chosen uar.

#th(title: "Yao's (minimax) principle (FOCS, 77)")[
  This principle essentially tells us that the *best worst-case complexity of a randomized algorithm* over a set of functions $cal(F)$ *cannot be better* than the best worst-case expected complexity of a *deterministic* algorithm over a *randomly chosen function* $f in cal(F)$.
]

We need to define difficult distributions from which we sample the function $f in cal(F)$.

Going back to $OM$. \
Consider uniform distribution over ${f_z | z in {0, 1}^n}$. What could be the best possible complexity of a deterministic algorithm over randomly chosen $f_z$? \
By our lemma, this complexity is at least $log_(n+1)(2^n) - 1 tilde.eq n / (log_2 n)$.

*Conclusion:* the black-box complexity of $OM$ wirt. all randomized algorithms is at least $n/(log n)$.

Is this tight? Yes! See Erdös-Rényi 1983, Lindström, 1983.

[Sketch of the proof by Erdös-Rényi, involving lots of pre-computations (inefficient in practice).]

#emoji.warning *Black-box complexity has nothing to do with classical complexity!*

For example, NP-hard problems can have polynomial BBC.

#ex(title: [Black-box complexity $!=$ classical complexity])[
  MaxClique is NP-hard. \
  Black-box queries are $S subset.eq V$ and $f(S) = cases(0 "if" S "is not a clique", |S| "otherwise")$.

  We have $"BBC"("MaxClique") <= binom(|V|, 2)$:
  1. Query every possible edge ${v, w} subset.eq V^2$
  2. Reconstruct the set of edges $E$
  3. Offline computation of MaxClique (expensive because NP-hard but we don't care because we aren't making any query)
]

#th(title: [Black-box complexity of $OM$])[
  $bbc(OM) = Theta(n / (log n))$ *BUT* $1$-ary unbiased $bbc(OM) = Theta(n log n)$
]
